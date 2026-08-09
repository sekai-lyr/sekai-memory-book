package com.sekai.memory.book.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class PasswordHashUtilTest {

    @Test
    void hashShouldMatchOriginalPasswordOnly() {
        String hashed = PasswordHashUtil.hash("sekai-password");

        assertTrue(PasswordHashUtil.isHashed(hashed));
        assertTrue(PasswordHashUtil.matches("sekai-password", hashed));
        assertFalse(PasswordHashUtil.matches("wrong-password", hashed));
        assertNotEquals("sekai-password", hashed);
    }

    @Test
    void legacyPlainTextPasswordShouldStillMatch() {
        assertTrue(PasswordHashUtil.matches("123456", "123456"));
        assertFalse(PasswordHashUtil.matches("123456", "654321"));
    }
}
