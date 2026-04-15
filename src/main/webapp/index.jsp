<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Loja Web2</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
	<h1>Loja Web2</h1>

	<ul class="menu">
		<li><a href="<%= request.getContextPath() %>/cliente/buscar">Buscar clientes</a></li>
		<li><a href="<%= request.getContextPath() %>/produto/buscar">Buscar produtos</a></li>
	</ul>
</body>
</html>
