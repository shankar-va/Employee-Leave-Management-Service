package com.project.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
	private PasswordUtil() {
		super();
	}
	public static String hashPassword(String pswd) {
		return BCrypt.hashpw(pswd, BCrypt.gensalt());
	}
	public static boolean verifyPassword(String pswd,String dbpswd) {
		return BCrypt.checkpw(pswd, dbpswd);
	}
}
