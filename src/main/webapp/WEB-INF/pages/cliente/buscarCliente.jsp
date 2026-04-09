<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="edu.ifsp.loja.controllers.cliente.BuscarClienteForm" %>
<%@ page import="edu.ifsp.loja.controllers.cliente.ClienteDTO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loja Web2</title>
</head>
<body>
	<%
	BuscarClienteForm dto = (BuscarClienteForm)request.getAttribute("dto");
	%>

	<h1>Buscar clientes</h1>
	<form method="get" action="/loja-web2/cliente/buscar">
		<label for="nome">Nome: </label>
		<input type="text" name="nome" id="nome" value="<%= dto.nome() %>">
		<br>
		
		<input type="checkbox" <%= dto.ativo() ? "checked" : "" %> name="ativo" id="ativo" value="true">
		<label for="ativo">Ativo</label>
		<br>
		
		<button type="submit">Buscar</button>
	</form>
	
	<%
	if (request.getAttribute("clientes") != null) {
		List<ClienteDTO> clientes = (List<ClienteDTO>)request.getAttribute("clientes");
	%>
	<br>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Nome</th>
			<th>E-mail</th>
			<th>Ativo</th>
		</tr>
		
		<% for (ClienteDTO c : clientes) { %>
		<tr>
			<td><%= c.id() %></td>
			<td><%= c.nome() %></td>
			<td><%= c.email() %></td>
			<td><%= c.ativo() ? "sim" : "não" %></td>
		</tr>
		<% } %>
		
	</table>
	<%
	} else {
	%>
	<p>Nenhum cliente encontrado para os critérios informados.</p>
	<%
	}
	%>
	
</body>
</html>