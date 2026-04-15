package edu.ifsp.loja.controllers.cliente;

import java.io.IOException;
import java.util.List;

import edu.ifsp.loja.service.ClienteService;
import edu.ifsp.loja.util.ViewHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cliente/buscar")
public class BuscarClienteController  extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (request.getParameterMap().isEmpty()) { /* É a primeira chamada? */
			start(request, response);
		} else {
			search(request, response);
		}
		
	}

	private void start(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("dto", new BuscarClienteForm("", true));
		ViewHelper.forward("cliente/buscarCliente.jsp", request, response);
	}
	
	private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nome = request.getParameter("nome");
		if (nome == null) {
			nome = "";
		}
		boolean ativo = "true".equals(request.getParameter("ativo"));

		ClienteService service = new ClienteService();
		BuscarClienteForm searchDTO = new BuscarClienteForm(nome, ativo);
		List<ClienteDTO> clientes = service.buscar(searchDTO);
		
		request.setAttribute("clientes", clientes);
		request.setAttribute("dto", searchDTO);
		ViewHelper.forward("cliente/buscarCliente.jsp", request, response);
	}
	
}
