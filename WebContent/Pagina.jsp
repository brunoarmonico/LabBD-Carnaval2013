<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List, model.Notas, controller.CadastrarNota" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Carnaval 2013</title>
</head>
<!-- Implementação do arquivo JQuery -->
<script type="text/javascript" src="./Recursos/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./Recursos/bootstrap.min.css"/>
		<script src="./Recursos/bootstrap.min.js"></script>
		<script src="./Recursos/popper.min.js" ></script>

<!-- SCRIPTS -->
<script>

$(document).ready(function(){
        $("#notasAnteriores").hide();
        $("#ocultarNotas").hide();
});

//ver notas anteriores
$(document).ready(function(){
	    $("#verNotas").click(function(){
	        $("#notasAnteriores").show();
	        $("#verNotas").hide();
	        $("#ocultarNotas").show();
	    });
	});
	
//ocultar notas anteriores
$(document).ready(function(){
    $("#ocultarNotas").click(function(){
        $("#notasAnteriores").hide();
        $("#verNotas").show();
        $("#ocultarNotas").hide();
    });
});

//permite somente numeros no campo de nota
$(document).ready(function() {
    $("#adicionaNota").keydown(function (e) {
    	
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl/cmd+A
            (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+C
            (e.keyCode == 67 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: Ctrl/cmd+X
            (e.keyCode == 88 && (e.ctrlKey === true || e.metaKey === true)) ||
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
});
</script>
	
<body>
	<h1>Apuração das notas das escolas de samba - Carnaval 2013</h1>
	<hr>
	
	<% CadastrarNota cn = new CadastrarNota(); %>
	<% List<Notas> li = cn.recebeNotas(); %>
		<% if (li != null && li.size() > 0){ %>
			
	<h3 id="verNotas">[Ver notas anteriores]</h3>
	<h3 id="ocultarNotas">[Ocultar notas anteriores]</h3>
	
	<!-- Tabela com notas anteriores -->
	<table class="table table-striped table-dark" id="notasAnteriores">
		<tr>
			<th>Quesito</th>
			<th>Escola</th>
			<th>Jurado</th>
			<th>Nota</th>
		</tr>
		<% for (Notas posicao : li) {  %>
		<tr>
			<td> <% out.print(posicao.getNome_quesito()); %> </td>
			<td> <% out.print(posicao.getNome_escola()); %> </td>
			<td> <% out.print(posicao.getNome_jurado()); %> </td>
			<td> <% out.print(posicao.getNota()); %> </td>
		</tr>
		<% } %>
		<% } %>
		<% int que = 1, esc = 1, jur = 1;%>
		<% if (li != null && li.size() > 0){ %>
			<% Notas ultimo = li.get(li.size() -1); %>
			<% jur = ultimo.getId_jurado(); %>
			<% esc = ultimo.getId_escola() + 1; %>
			<% que = ultimo.getId_quesito(); %>
			
			<% if (esc == 15){ %>
			<% esc = 1; %>
			<% jur = ultimo.getId_jurado() + 1; %>
			<% } %>
			
			<% if (jur == 6 ){ %>
			<% jur = 1; %>
			<% que = ultimo.getId_quesito() + 1; %>
			<% } %>
		<% } %>
		
		<% String nomes[] = cn.proximaNota(que, esc, jur); %>
		
		<% if (que < 11 ){ %>		
	</table>
	<hr>
	
	<!-- Tabela para adicionar novas notas -->
		<form action="./CadastrarNota" method="post">
		<div class="container">
		<h3>Inserir Proxima Nota</h3>
			<table class="table table-striped">
				<tr>
					<th>Quesito</th>
					<th>Escola</th>
					<th>Jurado</th>
					<th>Nota</th>
				</tr>
				<tr>
					<td> <input type="hidden" name="quesito" value="<% out.print(que); %>"/> <% out.print(nomes[0]); %> </td>
					<td> <input type="hidden" name="escola" value="<% out.print(esc); %>"/> <% out.print(nomes[1]); %> </td>
					<td> <input type="hidden" name="jurado" value="<% out.print(jur); %>"/> <% out.print(nomes[2]); %> </td>
					<td> <input type="number" step=0.1 max="10" min="5" style="width: 5em;" name="nota"/> 	
					
					<button value="enviarNota" type="submit" name="prButton"> Enviar </button> </td>
				</tr>
			</table>
		<% } %>
		<div align="center">
			<button value="verQuesito" type="submit" name="prButton">Ver Quesito</button> 
			<button value="verTotal" type="submit" name="prButton">Ver Total</button>
		</div>
		<br>
		</div>
		</form>
</body>
</html>