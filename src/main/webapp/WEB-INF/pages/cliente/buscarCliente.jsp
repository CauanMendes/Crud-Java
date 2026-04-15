<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="edu.ifsp.loja.controllers.cliente.BuscarClienteForm" %>
<%@ page import="edu.ifsp.loja.controllers.cliente.ClienteDTO" %>
<%@ page import="edu.ifsp.loja.util.StringUtil" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loja Web2</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
	<%
	BuscarClienteForm dto = (BuscarClienteForm) request.getAttribute("dto");
	%>

	<h1>Buscar clientes</h1>
	<form method="get" action="<%= request.getContextPath() %>/cliente/buscar">
		<label for="nome">Nome: </label>
		<input type="text" name="nome" id="nome" value="<%= StringUtil.htmlEscape(dto.nome()) %>">
		<br>

		<input type="checkbox" <%= dto.ativo() ? "checked" : "" %> name="ativo" id="ativo" value="true">
		<label for="ativo">Ativo</label>
		<br>

		<button type="submit">Buscar</button>
	</form>

	<%
	if (request.getAttribute("clientes") != null) {
		List<ClienteDTO> clientes = (List<ClienteDTO>) request.getAttribute("clientes");
	%>
	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>Nome</th>
				<th>E-mail</th>
				<th>Ativo</th>
			</tr>
		</thead>
		<tbody>
			<% for (ClienteDTO c : clientes) { %>
			<tr>
				<td><%= c.id() %></td>
				<td><%= StringUtil.htmlEscape(c.nome()) %></td>
				<td><%= StringUtil.htmlEscape(c.email()) %></td>
				<td><%= c.ativo() ? "sim" : "não" %></td>
			</tr>
			<% } %>
		</tbody>
	</table>
	<%
	} else {
	%>
	<p class="empty">Nenhum cliente encontrado para os critérios informados.</p>
	<%
	}
	%>

</body>
</html>
