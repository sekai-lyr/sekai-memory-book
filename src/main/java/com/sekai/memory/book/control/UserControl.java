package com.sekai.memory.book.control;

import com.sekai.memory.book.dataobject.SekaiMemoryBookOrderDO;
import com.sekai.memory.book.model.Result;
import com.sekai.memory.book.model.User;
import com.sekai.memory.book.service.MembershipOrderService;
import com.sekai.memory.book.service.UserService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.SecureRandom;

@Controller
public class UserControl {

    private static final String RESET_PHONE_SESSION_KEY = "passwordResetPhone";
    private static final String RESET_CODE_SESSION_KEY = "passwordResetCode";
    private static final String RESET_EXPIRE_SESSION_KEY = "passwordResetExpireAt";
    private static final long RESET_CODE_TTL_MILLIS = 5 * 60 * 1000L;
    private static final SecureRandom RANDOM = new SecureRandom();

    @Resource
    private UserService userService;

    @Resource
    private MembershipOrderService membershipOrderService;

    @PostMapping("/user/register")
    public String register(@ModelAttribute User user,
                           @RequestParam("confirmPassword") String confirmPassword,
                           RedirectAttributes redirectAttributes) {
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "用户信息不能为空");
            return "redirect:/register";
        }

        if (user.getPassword() == null || confirmPassword == null
                || !user.getPassword().equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "两次输入的密码不一致");
            return "redirect:/register";
        }

        Result<User> result = userService.register(user);
        if (!result.isSuccess()) {
            redirectAttributes.addFlashAttribute("error", result.getMessage());
            return "redirect:/register";
        }

        redirectAttributes.addFlashAttribute("message", "注册成功，请登录");
        return "redirect:/login";
    }

    @PostMapping("/user/login")
    public String login(@RequestParam("userName") String userName,
                        @RequestParam("password") String password,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        Result<User> result = userService.login(userName, password);
        if (!result.isSuccess()) {
            redirectAttributes.addFlashAttribute("error", result.getMessage());
            return "redirect:/login";
        }

        session.setAttribute("loginUser", result.getData());
        return "redirect:/home";
    }

    @PostMapping("/forgot-password/send-code")
    public String sendPasswordResetCode(@RequestParam("phoneNumber") String phoneNumber,
                                        HttpSession session,
                                        RedirectAttributes redirectAttributes) {
        String normalizedPhone = normalizePhoneNumber(phoneNumber);
        if (!isValidPhoneNumber(normalizedPhone)) {
            redirectAttributes.addFlashAttribute("error", "请输入 11 位中国大陆手机号");
            return "redirect:/forgot-password";
        }
        User user = userService.getByPhoneNumber(normalizedPhone);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "没有找到绑定该手机号的账号");
            return "redirect:/forgot-password";
        }
        String code = generateNumericCode();
        session.setAttribute(RESET_PHONE_SESSION_KEY, normalizedPhone);
        session.setAttribute(RESET_CODE_SESSION_KEY, code);
        session.setAttribute(RESET_EXPIRE_SESSION_KEY, System.currentTimeMillis() + RESET_CODE_TTL_MILLIS);
        redirectAttributes.addFlashAttribute("phoneNumber", normalizedPhone);
        redirectAttributes.addFlashAttribute("message", "验证码已发送。本地演示验证码：" + code + "，5 分钟内有效。");
        return "redirect:/forgot-password";
    }

    @PostMapping("/forgot-password/reset")
    public String resetPasswordByPhoneCode(@RequestParam("phoneNumber") String phoneNumber,
                                           @RequestParam("code") String code,
                                           HttpSession session,
                                           RedirectAttributes redirectAttributes) {
        String normalizedPhone = normalizePhoneNumber(phoneNumber);
        String normalizedCode = code == null ? "" : code.trim();
        Object sessionPhone = session.getAttribute(RESET_PHONE_SESSION_KEY);
        Object sessionCode = session.getAttribute(RESET_CODE_SESSION_KEY);
        Object sessionExpire = session.getAttribute(RESET_EXPIRE_SESSION_KEY);
        if (!isValidPhoneNumber(normalizedPhone)) {
            redirectAttributes.addFlashAttribute("error", "请输入 11 位中国大陆手机号");
            return "redirect:/forgot-password";
        }
        if (!normalizedPhone.equals(sessionPhone)
                || !normalizedCode.equals(sessionCode)
                || !(sessionExpire instanceof Long expireAt)
                || expireAt < System.currentTimeMillis()) {
            redirectAttributes.addFlashAttribute("phoneNumber", normalizedPhone);
            redirectAttributes.addFlashAttribute("error", "验证码不正确或已过期，请重新获取");
            return "redirect:/forgot-password";
        }

        String tempPassword = generateTemporaryPassword();
        Result<User> result = userService.resetPasswordByPhoneNumber(normalizedPhone, tempPassword);
        if (!result.isSuccess()) {
            redirectAttributes.addFlashAttribute("phoneNumber", normalizedPhone);
            redirectAttributes.addFlashAttribute("error", result.getMessage());
            return "redirect:/forgot-password";
        }
        clearResetSession(session);
        User user = result.getData();
        redirectAttributes.addFlashAttribute("resetUserName", user.getUserName());
        redirectAttributes.addFlashAttribute("resetTempPassword", tempPassword);
        redirectAttributes.addFlashAttribute("message", "验证成功，已生成新的临时密码");
        return "redirect:/forgot-password";
    }

    @PostMapping("/pro/activate-demo")
    public String activateDemoPro(@RequestParam(value = "planCode", defaultValue = "PRO_MONTHLY") String planCode,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        Object loginUser = session.getAttribute("loginUser");
        if (!(loginUser instanceof User user)) {
            return "redirect:/login";
        }
        int days = resolvePlanDays(planCode);
        BigDecimal amount = resolvePlanAmount(planCode);
        SekaiMemoryBookOrderDO order = membershipOrderService.createDemoOrder(user.getId(), planCode, amount);
        User proUser = userService.activatePro(user.getId(), days);
        if (proUser == null) {
            redirectAttributes.addFlashAttribute("error", "Pro 开通失败，请稍后重试");
            return "redirect:/pro/checkout";
        }
        if (order != null) {
            membershipOrderService.markPaid(order.getOrderNo(), "DEMO");
        }
        session.setAttribute("loginUser", proUser);
        redirectAttributes.addFlashAttribute("message", "已模拟付款并开通 " + days + " 天 Pro，订单已记录，后续可替换为真实支付回调");
        return "redirect:/pro";
    }

    private int resolvePlanDays(String planCode) {
        return switch (planCode) {
            case "PRO_EARLY_BIRD", "PRO_SUPPORTER" -> 36500;
            default -> 30;
        };
    }

    private BigDecimal resolvePlanAmount(String planCode) {
        return switch (planCode) {
            case "PRO_EARLY_BIRD" -> new BigDecimal("9.90");
            case "PRO_SUPPORTER" -> new BigDecimal("19.90");
            default -> new BigDecimal("3.00");
        };
    }

    private String normalizePhoneNumber(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed.replaceAll("[\\s-]", "");
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber != null && phoneNumber.matches("1\\d{10}");
    }

    private String generateNumericCode() {
        return String.format("%06d", RANDOM.nextInt(1_000_000));
    }

    private String generateTemporaryPassword() {
        return "Sekai@" + String.format("%06d", RANDOM.nextInt(1_000_000));
    }

    private void clearResetSession(HttpSession session) {
        session.removeAttribute(RESET_PHONE_SESSION_KEY);
        session.removeAttribute(RESET_CODE_SESSION_KEY);
        session.removeAttribute(RESET_EXPIRE_SESSION_KEY);
    }
}
