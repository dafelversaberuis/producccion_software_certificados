<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />

<html>
<head>
<title>ISOLUCIONES S.A.S</title>
<meta name="Description"
	content="Isoluciones, Innovación en Gestión Empresarial">
  

<? header("Cache-Control: no-cache, must-revalidate");?>
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="pragma" content="no-cache" />
<meta name="resource-type" content="document" />

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=7">
<script type="text/javascript" src="Scripts/noticias.js"></script>


<style type="text/css">
<!--
body {
	background-image: url();
background-color: #AFDBF6;
}
-->
</style>
<style type="text/css">
<!--
.Estilo5 {
	font-size: 12px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}

.Estilo6 {
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
</head>
<body><div id="contenedor">

<%
String curso = request.getParameter("id");

Object [] cursoX = bAdministrarPublicaciones.getCursoCompleto(curso);
	
	

List<Object[]> cursos = bAdministrarPublicaciones.getTemas(curso);

	out.println("<h2>Memorias de: "+cursoX[1]+"</h2>");
	
%>	
	
	
	<br/>
<form method="post" name="form1" id="form1">  

<%


if (cursos!=null && cursos.size() > 0) {
	
%>

<table width="100%" border="0" cellspacing="2" cellpadding="0">
	<tr>
		<td bgcolor="#0089E1" width="5%">
		<div align="right" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF"> MEMORIA/NORMA/DOCUMENTO </div>
		</td>
		
	
		<td bgcolor="#0089E1"  width="10%"> 
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
	int j = 0;
	for (Object[] i : cursos) {
		j++;
		
		String color ="#EEEEEE";
		if(j%2==0){
			color ="#FFFFFF";
		}
	%>
	<tr >
		<td align="right" bgcolor="<%=color %>" style="width:5%"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>" style="width:5%"><font color="black"><%=i[1] %></font></td>
		<td align="left"  bgcolor="<%=color %>"> 
		<%if(i[3]!=null && !i[3].equals("")){ if(i[4]!=null){%>
				<a href="/i-web/ver_archivo_adjunto.jsp?id=<%=i[0] %>" target="_blank" style="text-decoration:none">Ver/Descargar</a><%}else{ %><a href="#" onclick="window.open('/i-web/imagenes/archivosTemas/<%=i[3] %>', 'descarga_memoria', 'toolbar=no, menubar=no, scrollbars=no, resizable=yes, width=600, height=100'); return false;" style="text-decoration:none"><font color="blue">Ver/descargar</font></a><%}  }else{%>No disponible<% } %>
		
		
		</td> 
		
	</tr>
	
	<%} %>
	
</table>
<br/>
<br/>
<center>
<input type="button" value="Cerrar" onclick="window.close()"/>
</center>
<%}else{ %>
<center>
<span style="font-weight:bold"><h2>Las memorias no se encuentran disponibles en este momento, intente luego</h2></span>
<br/>

<input type="button" value="Cerrar" onclick="window.close()"/>
</center>
<%} %>

</form>
</div>
</body>
</html>
