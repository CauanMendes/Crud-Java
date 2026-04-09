package edu.ifsp.loja.util;

public final class StringUtil {
	private StringUtil() {}
	
	public static String emptyIfNull(String s) {
		return s == null ? "" : s;
	}
}
