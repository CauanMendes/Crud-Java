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

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameterMap().isEmpty()) { /* É a primeira chamada? */
			start(request, response);
		} else {
			search(request, response);
		}
		
	}

	private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paramDescricao = request.getParameter("descricao");
		String paramPrecoMinimo = request.getParameter("precoMinimo");
		String paramPrecoMaximo = request.getParameter("precoMaximo");
		String paramPage = request.getParameter("page");
		String paramPageSize = request.getParameter("pageSize");
		
		BuscarProdutoForm form = new BuscarProdutoForm();
		if (paramDescricao != null) {
			form.setDescricao(paramDescricao);
		}
		
		if (paramPrecoMinimo != null && !paramPrecoMinimo.isBlank()) {
			form.setPrecoMinimo(Double.parseDouble(paramPrecoMinimo));
		}

		if (paramPrecoMaximo != null && !paramPrecoMaximo.isBlank()) {
			form.setPrecoMaximo(Double.parseDouble(paramPrecoMaximo));
		}
		
		if (paramPage != null) {
			int page = Integer.parseInt(paramPage);
			if (page < 1) {
				page = 1;
			}
			form.setPage(page);
		}

		if (paramPageSize != null) {
			int pageSize = Integer.parseInt(paramPageSize);
			if (pageSize < 10 || pageSize > 100) {
				pageSize = 10;
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
}

