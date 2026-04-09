package edu.ifsp.loja.util;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public final class ViewHelper {
	private ViewHelper() {}
	
	public static String pathForJSP(String jspPath) {
		return "/WEB-INF/pages/" + jspPath;
	}
	
	public static void forward(String jspPath, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher(ViewHelper.pathForJSP(jspPath)).forward(request, response);		
	}
}
