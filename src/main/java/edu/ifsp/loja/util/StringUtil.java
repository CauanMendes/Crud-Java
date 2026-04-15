package edu.ifsp.loja.util;

public final class StringUtil {
	private StringUtil() {}

	public static String emptyIfNull(String s) {
		return s == null ? "" : s;
	}

	public static String htmlEscape(String s) {
		if (s == null) {
			return "";
		}
		StringBuilder sb = new StringBuilder(s.length());
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			switch (c) {
				case '&': sb.append("&amp;"); break;
				case '<': sb.append("&lt;"); break;
				case '>': sb.append("&gt;"); break;
				case '"': sb.append("&quot;"); break;
				case '\'': sb.append("&#39;"); break;
				default: sb.append(c);
			}
		}
		return sb.toString();
	}
}
