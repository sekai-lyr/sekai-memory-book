package com.sekai.memory.book.service.impl;

import com.sekai.memory.book.dataobject.SekaiMemoryBookUserDO;
import com.sekai.memory.book.mapper.SekaiMemoryBookUserMapper;
import com.sekai.memory.book.model.Result;
import com.sekai.memory.book.model.User;
import com.sekai.memory.book.service.UserService;
import com.sekai.memory.book.util.PasswordHashUtil;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private SekaiMemoryBookUserMapper userMapper;

    @Override
    @Transactional
    public Result<User> register(User user) {
        if (user == null) {
            return fail("用户信息不能为空");
        }

        user.setUserName(trimToNull(user.getUserName()));
        user.setPassword(trimToNull(user.getPassword()));
        user.setNickName(trimToNull(user.getNickName()));
        user.setPhoneNumber(normalizePhoneNumber(user.getPhoneNumber()));

        if (user.getUserName() == null) {
            return fail("用户名不能为空");
        }
        if (user.getPassword() == null) {
            return fail("密码不能为空");
        }

        if (user.getPhoneNumber() == null) {
            return fail("手机号不能为空");
        }
        if (!isValidPhoneNumber(user.getPhoneNumber())) {
            return fail("请输入 11 位中国大陆手机号");
        }

        SekaiMemoryBookUserDO existUser = userMapper.selectByUserName(user.getUserName());
        if (existUser != null) {
            return fail("用户名已存在");
        }

        SekaiMemoryBookUserDO existPhone = userMapper.selectByPhoneNumber(user.getPhoneNumber());
        if (existPhone != null) {
            return fail("手机号已绑定其他账号");
        }

        user.setPassword(PasswordHashUtil.hash(user.getPassword()));
        SekaiMemoryBookUserDO userDO = new SekaiMemoryBookUserDO(user);
        int insertRow = userMapper.insert(userDO);
        if (insertRow <= 0 || userDO.getId() == null) {
            return fail("数据库异常，注册失败");
        }

        SekaiMemoryBookUserDO dbUser = userMapper.selectByPrimaryKey(userDO.getId());
        Result<User> result = new Result<>();
        result.setCode("200");
        result.setMessage("注册成功");
        result.setSuccess(true);
        result.setData(dbUser.convertToUser());
        return result;
    }

    @Override
    @Transactional
    public Result<User> login(String userName, String password) {
        userName = trimToNull(userName);
        password = trimToNull(password);

        if (userName == null) {
            return fail("用户名不能为空");
        }
        if (password == null) {
            return fail("密码不能为空");
        }

        SekaiMemoryBookUserDO dbUser = userMapper.selectByLoginName(userName);
        if (dbUser == null) {
            return fail("用户名不存在，请先注册");
        }
        if (!PasswordHashUtil.matches(password, dbUser.getPassword())) {
            return fail("密码不正确");
        }
        if (!PasswordHashUtil.isHashed(dbUser.getPassword())) {
            dbUser.setPassword(PasswordHashUtil.hash(password));
            userMapper.updateByPrimaryKeySelective(dbUser);
        }

        Result<User> result = new Result<>();
        result.setCode("200");
        result.setMessage("登录成功");
        result.setSuccess(true);
        result.setData(dbUser.convertToUser());
        return result;
    }

    @Override
    public User getByUserName(String userName) {
        userName = trimToNull(userName);
        if (userName == null) {
            return null;
        }
        SekaiMemoryBookUserDO userDO = userMapper.selectByUserName(userName);
        return userDO == null ? null : userDO.convertToUser();
    }

    @Override
    public User getByPhoneNumber(String phoneNumber) {
        phoneNumber = normalizePhoneNumber(phoneNumber);
        if (phoneNumber == null || !isValidPhoneNumber(phoneNumber)) {
            return null;
        }
        SekaiMemoryBookUserDO userDO = userMapper.selectByPhoneNumber(phoneNumber);
        return userDO == null ? null : userDO.convertToUser();
    }

    @Override
    @Transactional
    public Result<User> resetPasswordByPhoneNumber(String phoneNumber, String newPassword) {
        phoneNumber = normalizePhoneNumber(phoneNumber);
        newPassword = trimToNull(newPassword);
        if (phoneNumber == null || !isValidPhoneNumber(phoneNumber)) {
            return fail("手机号格式不正确");
        }
        if (newPassword == null || newPassword.length() < 6 || newPassword.length() > 30) {
            return fail("新密码长度需要在 6 到 30 位之间");
        }
        SekaiMemoryBookUserDO userDO = userMapper.selectByPhoneNumber(phoneNumber);
        if (userDO == null) {
            return fail("没有找到绑定该手机号的账号");
        }
        userDO.setPassword(PasswordHashUtil.hash(newPassword));
        int updateRow = userMapper.updateByPrimaryKeySelective(userDO);
        if (updateRow <= 0) {
            return fail("密码重置失败，请稍后重试");
        }
        Result<User> result = new Result<>();
        result.setCode("200");
        result.setMessage("密码已重置");
        result.setSuccess(true);
        result.setData(userMapper.selectByPrimaryKey(userDO.getId()).convertToUser());
        return result;
    }

    @Override
    @Transactional
    public User activatePro(Long userId, int days) {
        if (userId == null || days <= 0) {
            return null;
        }
        SekaiMemoryBookUserDO userDO = userMapper.selectByPrimaryKey(userId);
        if (userDO == null) {
            return null;
        }
        LocalDateTime baseTime = userDO.getProExpireTime() != null
                && userDO.getProExpireTime().isAfter(LocalDateTime.now())
                ? userDO.getProExpireTime()
                : LocalDateTime.now();
        userDO.setMembershipPlan("PRO");
        userDO.setProExpireTime(baseTime.plusDays(days));
        userMapper.updateByPrimaryKeySelective(userDO);
        return userMapper.selectByPrimaryKey(userId).convertToUser();
    }

    private Result<User> fail(String message) {
        Result<User> result = new Result<>();
        result.setCode("400");
        result.setMessage(message);
        result.setSuccess(false);
        return result;
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String normalizePhoneNumber(String value) {
        String trimmed = trimToNull(value);
        if (trimmed == null) {
            return null;
        }
        return trimmed.replaceAll("[\\s-]", "");
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber != null && phoneNumber.matches("1\\d{10}");
    }
}
