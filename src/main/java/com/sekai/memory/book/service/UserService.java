package com.sekai.memory.book.service;

import com.sekai.memory.book.model.Result;
import com.sekai.memory.book.model.User;

public interface UserService {

Result<User> register(User user);

Result<User> login(String userName, String password);

User getByUserName(String userName);

User getByPhoneNumber(String phoneNumber);

Result<User> resetPasswordByPhoneNumber(String phoneNumber, String newPassword);

User activatePro(Long userId, int days);

}
