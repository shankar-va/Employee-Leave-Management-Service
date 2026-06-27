package com.project.util;

public class DB_INFO {

    private static final String url =
            System.getenv("DB_URL");

    private static final String username =
            System.getenv("DB_USERNAME");

    private static final String pswd =
            System.getenv("DB_PASSWORD");

    public static String getUrl() {
        return url;
    }

    public static String getUsername() {
        return username;
    }

    public static String getPswd() {
        return pswd;
    }
}