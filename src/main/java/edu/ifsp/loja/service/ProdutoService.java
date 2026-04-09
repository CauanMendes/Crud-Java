package edu.ifsp.loja.service;

import java.util.List;

import edu.ifsp.loja.controllers.produto.BuscarProdutoForm;
import edu.ifsp.loja.controllers.produto.ProdutoDTO;
import edu.ifsp.loja.persistencia.ProdutoDAO;

public class ProdutoService {
	private ProdutoDAO dao = new ProdutoDAO();
	
	public List<ProdutoDTO> search(BuscarProdutoForm form) {
		
		
		List<ProdutoDTO> produtos = dao.findPaged(
				form.getPage(), form.getPageSize(), 
				form.getDescricao(), form.getPrecoMinimo(), form.getPrecoMaximo())
				.stream()
				.map(p -> new ProdutoDTO(p.getId(), p.getDescricao(), p.getPreco()))
				.toList();
		
		return produtos;
	}
	
	public int totalItens(BuscarProdutoForm form) {
		return dao.totalItens(form.getDescricao(), form.getPrecoMinimo(), form.getPrecoMaximo());

	}

}
