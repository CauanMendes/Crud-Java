<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="edu.ifsp.loja.controllers.produto.BuscarProdutoForm" %>
<%@ page import="edu.ifsp.loja.controllers.produto.ProdutoDTO" %>
<%@ page import="edu.ifsp.loja.util.StringUtil" %>
<%@ page import="java.util.List" %>
<% BuscarProdutoForm form = (BuscarProdutoForm) request.getAttribute("form"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Loja Web2</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
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

		function nuMovePage(offset) {
			gotoPage(offset);
		}
	</script>
</head>
<body>
	<h1>Buscar produtos</h1>
	<form id="search-form" method="get" action="<%= request.getContextPath() %>/produto/buscar">
		<label for="descricao">Descrição: </label>
		<input type="text" name="descricao" id="descricao"
			value="<%= StringUtil.htmlEscape(StringUtil.emptyIfNull(form.getDescricao())) %>"><br>

		<label for="preco-minimo">Preço Mínimo: </label>
		<input type="number" name="precoMinimo" id="preco-minimo" value="<%= form.getPrecoMinimo() %>"><br>

		<label for="preco-maximo">Preço Máximo: </label>
		<input type="number" name="precoMaximo" id="preco-maximo" value="<%= form.getPrecoMaximo() %>"><br>

		<label for="pageSize">Itens por página: </label>
		<input type="number" name="pageSize" id="pageSize" value="<%= form.getPageSize() %>"><br>

		<input type="hidden" name="page" value="1">

		<button type="submit">Buscar</button>
	</form>

	<%
	if (request.getAttribute("produtos") != null) {
		List<ProdutoDTO> produtos = (List<ProdutoDTO>) request.getAttribute("produtos");
		int totalitens = (int) request.getAttribute("totalItens");

		int nPage;
		if (totalitens % form.getPageSize() == 0) {
			nPage = totalitens / form.getPageSize();
		} else {
			nPage = (totalitens / form.getPageSize()) + 1;
		}
		int paginaAtual = form.getPage();
		boolean naPrimeira = paginaAtual <= 1;
		boolean naUltima = paginaAtual >= nPage;
	%>

	<script>
		let ordemCrescente = true;

		function ordenarTabelaPreco() {
			const tbody = document.querySelector("#tabela-produtos tbody");
			const linhas = Array.from(tbody.querySelectorAll("tr"));

			linhas.sort(function (a, b) {
				const precoA = parseFloat(a.children[2].textContent);
				const precoB = parseFloat(b.children[2].textContent);
				return ordemCrescente ? precoA - precoB : precoB - precoA;
			});

			tbody.innerHTML = "";
			linhas.forEach(tr => tbody.appendChild(tr));
			ordemCrescente = !ordemCrescente;
		}

		document.addEventListener("DOMContentLoaded", function () {
			const thPreco = document.getElementById("th-preco");
			thPreco.addEventListener("click", ordenarTabelaPreco);
		});
	</script>

	<table id="tabela-produtos">
		<thead>
			<tr>
				<th>ID</th>
				<th>Descrição</th>
				<th id="th-preco" style="cursor: pointer;">Preço ▲▼</th>
			</tr>
		</thead>
		<tbody>
			<% for (ProdutoDTO p : produtos) { %>
				<tr>
					<td><%= p.id() %></td>
					<td><%= StringUtil.htmlEscape(p.descricao()) %></td>
					<td><%= p.preco() %></td>
				</tr>
			<% } %>
		</tbody>
	</table>

	<div class="pagination">
		<a href="#" id="primeira"
			class="<%= naPrimeira ? "disabled" : "" %>"
			onclick="<%= naPrimeira ? "return false;" : "nuMovePage(1); return false;" %>">Primeira</a>

		<a href="#" id="anterior"
			class="<%= naPrimeira ? "disabled" : "" %>"
			onclick="<%= naPrimeira ? "return false;" : "movePage(-1); return false;" %>">Anterior</a>

		<% for (int i = 1; i <= nPage; i++) { %>
			<a href="#"
				class="<%= i == paginaAtual ? "disabled" : "" %>"
				onclick="<%= i == paginaAtual ? "return false;" : "nuMovePage(" + i + "); return false;" %>"><%= i %></a>
		<% } %>

		<a href="#" id="proxima"
			class="<%= naUltima ? "disabled" : "" %>"
			onclick="<%= naUltima ? "return false;" : "movePage(1); return false;" %>">Próxima</a>

		<a href="#" id="ultima"
			class="<%= naUltima ? "disabled" : "" %>"
			onclick="<%= naUltima ? "return false;" : "nuMovePage(" + nPage + "); return false;" %>">Última</a>
	</div>

	<div class="info">Página atual: <%= paginaAtual %> de <%= nPage %></div>
	<div class="info">Total de registros: <%= totalitens %></div>

	<% } else { %>
		<p class="empty">Nenhum resultado encontrado para os critérios informados.</p>
	<% } %>
</body>
</html>
