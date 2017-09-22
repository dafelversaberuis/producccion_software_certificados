<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>
	
	<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

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

<link href="estilos/estilos.css" rel="stylesheet" type="text/css">
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
<body>
<%
//String tu = request.getParameter("tu");
//String us = request.getParameter("us");
String id = request.getParameter("id");
String n = request.getParameter("n");



//lo crea x sia ca no está
String directorio_ruta = application.getRealPath("imagenes")+"/logosFinanciadores/";
int sw= 0;
Object[] financiador = bAdministrarPublicaciones.getFinanciador(Integer.parseInt(id));

if(n!=null && n.equals("1")){  
	if(financiador[5]!=null){
	sw=1;
	bAdministrarPublicaciones.guardarArchivoDisco(directorio_ruta + "logo_financiador_"+id+"-"+n+".jpg", (byte[])financiador[5]);
	
	}
	
}else if(n!=null && n.equals("2")){
	if(financiador[6]!=null){
		sw=1;
		bAdministrarPublicaciones.guardarArchivoDisco(directorio_ruta + "logo_financiador_"+id+"-"+n+".jpg", (byte[])financiador[6]);
		
		}
} else if(n!=null && n.equals("3")){
	if(financiador[7]!=null){
		sw=1;
		bAdministrarPublicaciones.guardarArchivoDisco(directorio_ruta + "logo_financiador_"+id+"-"+n+".jpg", (byte[])financiador[7]);
		
		}
}

   
	



%>

<div id="contiene-imagenes" style="width:500px; height: 500px">
<%if(sw==0){ %>
<img src="imagenes/logosFinanciadores/logo_financiador_<%=id %>-<%=n%>.jpg" alt="CLIENTE" title="CLIENTE"/>

<%}else{ %>
<img src="/i-web/ver_foto_adjunta.jsp?id=<%=financiador[0] %>&n=<%=n%>" alt="CLIENTE" title="CLIENTE"/>
<% }%>
</div>

</body>
</html>
