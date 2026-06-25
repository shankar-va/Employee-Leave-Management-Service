package com.project.util;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validator {

    // Regex for standard email format validation
    private static final String EMAIL_REGEX = 
        "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";

    private static final String PHONE_REGEX = 
        "^(\\+\\d{1,3}([- ]?))?(\\(?\\d{3,4}\\)?[- ]?)?\\d{3}[- ]?\\d{4}$";

    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);
    private static final Pattern PHONE_PATTERN = Pattern.compile(PHONE_REGEX);

    // Method to validate email
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        Matcher matcher = EMAIL_PATTERN.matcher(email);
        return matcher.matches();
    }

    // Method to validate phone number
    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        Matcher matcher = PHONE_PATTERN.matcher(phone);
        return matcher.matches();
    }

}