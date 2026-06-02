package com.bggchef.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

/** SHA-256 비밀번호 암호화 유틸 */
public class PasswordUtil {

    public static String encrypt(String plain) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(plain.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("암호화 실패", e);
        }
    }

    public static boolean matches(String plain, String encrypted) {
        return encrypt(plain).equals(encrypted);
    }
}
