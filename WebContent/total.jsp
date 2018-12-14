<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List, model.TotalNotas, controller.NotasQuesitos, model.Quesito" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="./Recursos/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./Recursos/bootstrap.min.css"/>
		<script src="./Recursos/bootstrap.min.js"></script>
		<script src="./Recursos/popper.min.js" ></script>
<title>Total Escolas</title>
</head>
<body>
<h1>Apuração das notas das escolas de samba - Carnaval 2013</h1>
	<hr>
	<h3>Total por Escola</h3>
	<% NotasQuesitos nq = new NotasQuesitos(); %>
	<% List<TotalNotas> lista = nq.recebeTotal(); %>
	
	<form action="./NotasQuesitos" method="post">
	<% if (lista != null && lista.size() > 0){ %>
	
	<br>
		<table class="table table-striped">
			<tr>
				<th>Escola</th>
				<th>Nota</th>
			</tr>
			<% for(TotalNotas nt : lista){ %>
			<tr>
				<td> <input type="hidden" name="escola"/> <% out.print(nt.getEscola()); %> </td>
				<td> <input type="hidden" name="total"/> <% out.print(nt.getTotal()); %> </td>
			</tr>
			<% } %>	
		</table>		
		<% } else { %>
		NENHUMA NOTA AINDA.
		<% } %>
</body>
</html>