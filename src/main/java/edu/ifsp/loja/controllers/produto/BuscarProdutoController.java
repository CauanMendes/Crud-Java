package edu.ifsp.loja.controllers.produto;

import java.io.IOException;
import java.util.List;

import edu.ifsp.loja.service.ProdutoService;
import edu.ifsp.loja.util.ViewHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/produto/buscar")
public class BuscarProdutoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final int DEFAULT_PAGE_SIZE = 10;
	private static final int MIN_PAGE_SIZE = 10;
	private static final int MAX_PAGE_SIZE = 100;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameterMap().isEmpty()) {
			start(request, response);
		} else {
			search(request, response);
		}
	}

	private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BuscarProdutoForm form = new BuscarProdutoForm();

		String paramDescricao = request.getParameter("descricao");
		if (paramDescricao != null) {
			form.setDescricao(paramDescricao);
		}

		Double precoMinimo = parseDoubleOrNull(request.getParameter("precoMinimo"));
		if (precoMinimo != null) {
			form.setPrecoMinimo(precoMinimo);
		}

		Double precoMaximo = parseDoubleOrNull(request.getParameter("precoMaximo"));
		if (precoMaximo != null) {
			form.setPrecoMaximo(precoMaximo);
		}

		Integer page = parseIntOrNull(request.getParameter("page"));
		if (page != null) {
			form.setPage(page < 1 ? 1 : page);
		}

		Integer pageSize = parseIntOrNull(request.getParameter("pageSize"));
		if (pageSize != null) {
			if (pageSize < MIN_PAGE_SIZE || pageSize > MAX_PAGE_SIZE) {
				pageSize = DEFAULT_PAGE_SIZE;
			}
			form.setPageSize(pageSize);
		}

		ProdutoService service = new ProdutoService();
		List<ProdutoDTO> produtos = service.search(form);
		int totalItens = service.totalItens(form);

		request.setAttribute("produtos", produtos);
		request.setAttribute("totalItens", totalItens);
		request.setAttribute("form", form);

		ViewHelper.forward("produto/buscarProduto.jsp", request, response);
	}

	private void start(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("form", new BuscarProdutoForm());
		ViewHelper.forward("produto/buscarProduto.jsp", request, response);
	}

	private static Double parseDoubleOrNull(String value) {
		if (value == null || value.isBlank()) {
			return null;
		}
		try {
			return Double.parseDouble(value);
		} catch (NumberFormatException e) {
			return null;
		}
	}

	private static Integer parseIntOrNull(String value) {
		if (value == null || value.isBlank()) {
			return null;
		}
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			return null;
		}
	}
}
