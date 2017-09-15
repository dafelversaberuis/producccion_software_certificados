<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>MULTIEMERGENCIAS S.A.S</title>
    <meta name="Description" content="CENTRO DE ENTRENAMIENTO EN EMERGENCIAS y SALUD OCUPACIONAL ">


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
.Estilo4 {
	font-size: 12px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
-->
</style>

<script>
	function cargarImagen()
	{
		if(document.frm_cargar.fil_imagen.value)
		{
			document.frm_cargar.submit();
		}
		else
		{
			alert("Debe seleccionar una imagen. Clic en el botón examinar; seleccione la imagen y luego clic en Aceptar");			
		}
	
	}

</script>
</head>
<body>
<%
String tu = request.getParameter("tu");
String us = request.getParameter("us");


%>

<p class="Estilo4">&nbsp;</p>
<p class="Estilo4">&nbsp;</p>
<p class="Estilo4">Busque la imagen a asociar (jpg,gif,png):</p>
<form action="recibirFotoPublicacion.jsp?tu=2&us=<%=us%>" method="post" enctype="multipart/form-data" name="frm_cargar">
        <p>
          <input name="fil_imagen" type="file" size="40">
 </p>
        <p align="center">         
          <input type="button" name="btn_cargar" value="Aceptar" onClick="cargarImagen();" class="searchbutton" style="cursor: hand">        
                </p>
</form>
</body>
</html>
