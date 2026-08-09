document.addEventListener("DOMContentLoaded", function () {
    const registerForm = document.getElementById("registerForm");
    const userNameInput = document.getElementById("userName");
    const nickNameInput = document.getElementById("nickName");
    const phoneNumberInput = document.getElementById("phoneNumber");
    const passwordInput = document.getElementById("password");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    const agreementInput = document.getElementById("agreement");

    if (!registerForm) {
        return;
    }

    registerForm.addEventListener("submit", function (event) {
        let valid = true;
        const userName = userNameInput ? userNameInput.value.trim() : "";
        const nickName = nickNameInput ? nickNameInput.value.trim() : "";
        const phoneNumber = phoneNumberInput ? phoneNumberInput.value.trim().replace(/[\s-]/g, "") : "";
        const password = passwordInput ? passwordInput.value.trim() : "";
        const confirmPassword = confirmPasswordInput ? confirmPasswordInput.value.trim() : "";

        clearErrors();

        if (userName.length < 3 || userName.length > 20) {
            setError("userNameError", "用户名长度需要在 3 到 20 位之间");
            valid = false;
        }
        if (nickName.length > 20) {
            setError("nickNameError", "昵称不能超过 20 位");
            valid = false;
        }
        if (!/^1\d{10}$/.test(phoneNumber)) {
            setError("phoneNumberError", "请输入 11 位中国大陆手机号");
            valid = false;
        }
        if (password.length < 6 || password.length > 30) {
            setError("passwordError", "密码长度需要在 6 到 30 位之间");
            valid = false;
        }
        if (password !== confirmPassword) {
            setError("confirmPasswordError", "两次输入的密码不一致");
            valid = false;
        }
        if (agreementInput && !agreementInput.checked) {
            setError("agreementError", "请先同意用户协议");
            valid = false;
        }

        if (!valid) {
            event.preventDefault();
        }
    });

    function clearErrors() {
        ["userNameError", "nickNameError", "phoneNumberError", "passwordError", "confirmPasswordError", "agreementError"].forEach(function (id) {
            setError(id, "");
        });
    }

    function setError(id, message) {
        const element = document.getElementById(id);
        if (element) {
            element.textContent = message;
        }
    }
});
