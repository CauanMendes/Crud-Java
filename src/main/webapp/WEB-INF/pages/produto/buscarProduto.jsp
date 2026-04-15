<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="edu.ifsp.loja.controllers.produto.BuscarProdutoForm"%>
<%@ page import="edu.ifsp.loja.controllers.produto.ProdutoDTO"%>
<%@ page import="edu.ifsp.loja.util.StringUtil"%>
<%@ page import="java.util.List"%>

<%
BuscarProdutoForm form = (BuscarProdutoForm) request.getAttribute("form");
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
	const currentPage = <%=form.getPage()%>;
	gotoPage(currentPage + offset);
	
}

function nuMovePage(offset) {
	gotoPage(offset);
	
}


}

</script>
</head>
<body>
	<h1>Buscar produtos</h1>
	<form id="search-form" method="get"
		action="<%=request.getContextPath()%>/produto/buscar">
		<label for="descricao">Descrição: </label> <input type="text"
			name="descricao" id="descricao"
			value="<%=StringUtil.emptyIfNull(form.getDescricao())%>"> <br>

		<label for="preco-minimo">Preço Mínimo: </label> <input type="number"
			name="precoMinimo" id="preco-minimo"
			value="<%=form.getPrecoMinimo()%>"> <br> <label
			for="preco-maximo">Preço Máximo: </label> <input type="number"
			name="precoMaximo" id="preco-maximo"
			value="<%=form.getPrecoMaximo()%>"> <br> <label
			for="pageSize">Número de itens por Página: </label> <input
			type="number" name="pageSize" id="pageSize"
			value="<%=form.getPageSize()%>"> <br> <input
			type="hidden" name="page" value="1"> <input type="hidden"
			name="pageSize" value="<%=form.getPageSize()%>">

		<button type="submit" onsubmit="formSubmit();">Buscar</button>


	</form>

	<%
	
	
	int totalitens = 0;

	if (request.getAttribute("produtos") != null) {
		List<ProdutoDTO> produtos = (List<ProdutoDTO>) request.getAttribute("produtos");

		totalitens = (int) request.getAttribute("totalItens");
		
		
		
		int nPage = 0;

		if (totalitens % form.getPageSize() == 0) {
			nPage = totalitens / form.getPageSize();
		} else {
			nPage = (totalitens / form.getPageSize()) + 1;
		}
	%>
	
	
	<br>

	<script>
let ordemCrescente = true;

document.addEventListener("DOMContentLoaded", function () {
    const thPreco = document.getElementById("th-preco");

    thPreco.addEventListener("click", function () {
        ordenarTabelaPreco();
    });

    controlarPaginacao();
});

function ordenarTabelaPreco() {
    const tbody = document.querySelector("#tabela-produtos tbody");
    const linhas = Array.from(tbody.querySelectorAll("tr"));

    linhas.sort(function (a, b) {
        const precoA = parseFloat(a.children[2].textContent);
        const precoB = parseFloat(b.children[2].textContent);

        if (ordemCrescente) {
            return precoA - precoB;
        } else {
            return precoB - precoA;
        }
    });

    // limpa tbody
    tbody.innerHTML = "";

    // reinsere ordenado
    linhas.forEach(tr => tbody.appendChild(tr));

    // alterna ordem
    ordemCrescente = !ordemCrescente;
    
    function controlarPaginacao() {
        const paginaAtual = <%=form.getPage()%>;
        const totalPaginas = <%=nPage%>;

        const primeira = document.getElementById("primeira");
        const anterior = document.getElementById("anterior");
        const proxima = document.getElementById("proxima");
        const ultima = document.getElementById("ultima");

        // Primeira página
        if (paginaAtual <= 1) {
            primeira.style.display = "none";
            anterior.style.display = "none";
        }

        // Última página
        if (paginaAtual >= totalPaginas) {
            proxima.style.display = "none";
            ultima.style.display = "none";
        }
}
</script>

	<table border="1" id="tabela-produtos">
		<thead>
			<tr>
				<th>ID</th>
				<th>Descrição</th>
				<th id="th-preco" style="cursor: pointer;">Preço ▲▼</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (ProdutoDTO p : produtos) {
			%>
			<tr>
				<td><%=p.id()%></td>
				<td><%=p.descricao()%></td>
				<td><%=p.preco()%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<a href="#" id="primeira" onclick="nuMovePage(1)">Primeira Página</a>
	<br>

	<a href="#" id="anterior" onclick="movePage(-1)">Anterior</a>

	<%
	

	for (int i = 1; i <= nPage; i++) {
	%>
	<a href="#" onclick="nuMovePage(<%=i%>)"><%=i%></a>
	<%
	}
	%>

	<a href="#" id="proxima" onclick="movePage(1)">Próxima</a>
	<br>

	<a href="#" id="ultima" onclick="nuMovePage(<%=nPage%>)">Última
		Página</a>

	<br>

	<div>
		Página atual:
		<%=form.getPage()%></div>



	<div>
		Total de Registros:
		<%=totalitens%></div>
	<%
	} else {
	%>
	<p>Nenhum resultado encontrado para os critérios informados.</p>
	<%
	}
	%>

</body>
</html>