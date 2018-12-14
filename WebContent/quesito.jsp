<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List, model.Notas, controller.NotasQuesitos, model.Quesito" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ver Quesito</title>

<!-- Implementação do arquivo JQuery -->
<script type="text/javascript" src="./Recursos/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./Recursos/bootstrap.min.css"/>
		<script src="./Recursos/bootstrap.min.js"></script>
		<script src="./Recursos/popper.min.js" ></script>
</head>
<body>
	<h1>Apuração das notas das escolas de samba - Carnaval 2013</h1>
	<hr>
	<h3>Busca por Quesito</h3>

	<% NotasQuesitos nq = new NotasQuesitos(); %>
	<% List<Quesito> lista = nq.recebeQuesitos(); %>
	
	<form action="./NotasQuesitos" method="post">
	<select name="combobox">
	<% for (Quesito q : lista){%>
	<option value="<% out.print(q.getId()); %>"> <% out.print(q.getNome()); %> </option>
	<% } %>
	</select> <button type="submit" value="buscaQuesito" name="botao">Buscar</button>
	</form>
	
	<% List<Notas> notas = (List<Notas>)session.getAttribute("NOTASQUESITO"); %>
	<% if (notas != null && notas.size() > 0){ %>
	
	<br>
	<table class="table table-striped">
		<tr align="center">
			<th align="center"><% out.print(notas.get(0).getNome_quesito()); %></th>
		</tr>
	</table>
	
	<!-- tabela com notas por quesito -->
		<table class="table table-striped">
		<tr>
			<th>Escola</th>
			<th>Jurado</th>
			<th>Nota</th>
			<th>Descartada</th>
		</tr>
		<% double total = 0; %>
		<% int cont = 0;%>
		<% for(Notas nt : notas){ %>
			<tr>
				<td> <input type="hidden" name="escola"/> <% out.print(nt.getNome_escola()); %> </td>
				<td> <input type="hidden" name="jurado"/> <% out.print(nt.getNome_jurado()); %> </td>
				<td> <input type="hidden" name="nota"/> <% out.print(nt.getNota()); %> </td>
				<% if (nt.getDescarte() == true){ %>
				<td> <input type="hidden" name="descarte"/> DESCARTADO </td>
				<% } else { %>
					<td> <input type="hidden" name="descarte"/> </td>
					<% total = total +nt.getNota(); %>
				<% } %>
			</tr>
			<% cont++; %>
			
			<% if (cont != notas.size()){ %>
				<% if (nt.getNome_escola().equals(notas.get(cont).getNome_escola())) { %>
				
				<% } else { %>
				<tr>
					<th>Total - <% out.print(nt.getNome_escola()); %></th><td><% out.print(total); %></td>
					<% total = 0; %>
				</tr>
				<% } %>
			<% } else {%>
				<tr>
					<th>Total - <% out.print(nt.getNome_escola()); %></th><td><% out.print(total); %></td>
					<% total = 0; %>
				</tr>
			<% } %>
		<% } %>
		
		</table>
		
		<% } else { %>
		NENHUMA NOTA NESTE QUESITO!
		<% } %>
</body>
</html>