document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById("loginForm");
    const userNameInput = document.getElementById("userName");
    const passwordInput = document.getElementById("password");
    const rememberMeInput = document.getElementById("rememberMe");
    const togglePassword = document.getElementById("togglePassword");
    const userNameError = document.getElementById("userNameError");
    const passwordError = document.getElementById("passwordError");

    if (!loginForm) {
        return;
    }

    const rememberedUserName = localStorage.getItem("sekaiRememberUserName");
    if (rememberedUserName && userNameInput) {
        userNameInput.value = rememberedUserName;
        if (rememberMeInput) {
            rememberMeInput.checked = true;
        }
    }

    if (togglePassword && passwordInput) {
        togglePassword.addEventListener("click", function () {
            const showing = passwordInput.type === "text";
            passwordInput.type = showing ? "password" : "text";
            togglePassword.textContent = showing ? "显示" : "隐藏";
        });
    }

    loginForm.addEventListener("submit", function (event) {
        let valid = true;
        const userName = userNameInput ? userNameInput.value.trim() : "";
        const password = passwordInput ? passwordInput.value.trim() : "";

        setError(userNameError, "");
        setError(passwordError, "");

        if (userName.length === 0) {
            setError(userNameError, "请输入用户名");
            valid = false;
        }
        if (password.length === 0) {
            setError(passwordError, "请输入密码");
            valid = false;
        }

        if (!valid) {
            event.preventDefault();
            return;
        }

        if (rememberMeInput && rememberMeInput.checked) {
            localStorage.setItem("sekaiRememberUserName", userName);
        } else {
            localStorage.removeItem("sekaiRememberUserName");
        }
    });

    function setError(element, message) {
        if (element) {
            element.textContent = message;
        }
    }
});
