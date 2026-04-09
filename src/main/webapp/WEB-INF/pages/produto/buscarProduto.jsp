<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="edu.ifsp.loja.controllers.produto.BuscarProdutoForm" %>
<%@ page import="edu.ifsp.loja.controllers.produto.ProdutoDTO" %>
<%@ page import="edu.ifsp.loja.util.StringUtil" %>
<%@ page import="java.util.List" %>

<%
BuscarProdutoForm form = (BuscarProdutoForm)request.getAttribute("form");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loja Web2</title>
<script>
function gotoPage(page) {
	const form = document.querySelector('#search-form');
	const pageInput = form.querySelector('input[name="page"]');
	pageInput.value = page;
	form.submit();		
}

function movePage(offset) {
	const currentPage = <%= form.getPage() %>;
	gotoPage(currentPage + offset);
	
}

</script>
</head>
<body>
	<h1>Buscar produtos</h1>
	<form id="search-form" method="get" action="<%= request.getContextPath() %>/produto/buscar">
		<label for="descricao">Descrição: </label>
		<input type="text" name="descricao" id="descricao" value="<%= StringUtil.emptyIfNull(form.getDescricao()) %>">
		<br>

		<label for="preco-minimo">Preço Mínimo: </label>
		<input type="number" name="precoMinimo" id="preco-minimo" value="<%= form.getPrecoMinimo() %>">
		<br>
				
		<label for="preco-maximo">Preço Máximo: </label>
		<input type="number" name="precoMaximo" id="preco-maximo" value="<%= form.getPrecoMaximo() %>">
		<br>
		
		<label for="pageSize">Número de itens por Página: </label>
		<input type="number" name="pageSize" id="pageSize" value="<%= form.getPageSize() %>">
		<br>
		
		<input type="hidden" name="page" value="1">
		<input type="hidden" name="pageSize" value="<%= form.getPageSize() %>">

		<button type="submit" onsubmit="formSubmit();">Buscar</button>
		
		
	</form>
	
	<%
	if (request.getAttribute("produtos") != null) {
		List<ProdutoDTO> produtos = (List<ProdutoDTO>)request.getAttribute("produtos");
		
	int totalitens = (int)request.getAttribute("totalItens");
	%>
	<br>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Descrição</th>
			<th>Preco</th>
		</tr>
		
		<% for (ProdutoDTO p : produtos) { %>
		<tr>
			<td><%= p.id() %></td>
			<td><%= p.descricao() %></td>
			<td><%= p.preco() %></td>
		</tr>
		<% } %>
		
	</table>
	
	<a href="#" onclick="movePage(-1)">Anterior</a> 
	<a href="#" onclick="movePage(1)">Próxima</a>
	<br>
	
	<div>Página atual: <%= form.getPage() %></div>
	
	<div>Total de Registros: <%= totalitens %></div>
	
	<%
	} else {
	%>
	<p>Nenhum resultado encontrado para os critérios informados.</p>
	<%
	}
	%>
	
	
</body>
</html>