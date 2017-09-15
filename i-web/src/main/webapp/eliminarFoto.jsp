<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.net.*, java.sql.*,java.util.*,java.text.SimpleDateFormat, java.text.NumberFormat,java.text.DecimalFormat" errorPage="" session="false"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.RepositorioFotos"%>
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
<script language="javascript" type="text/javascript">

function borrar(foto, nombreFoto){
if(confirm('Realmente dese elimnar la foto/imagen compartida?')){
//alert('foto '+foto);
	document.getElementById('hdnFoto22').value = foto;
		document.getElementById('hdnNombreFoto').value = nombreFoto;
		document.getElementById('hdnBorrar').value = "1";
		document.form1.submit();
}

}
</script>

</head>
<body>
<%
	String tu = request.getParameter("tu");
	String us = request.getParameter("us");

	String fotoAEliminar = request.getParameter("hdnFoto22");
	String borrar = request.getParameter("hdnBorrar");
	String nombreFoto = request.getParameter("hdnNombreFoto");

	if (borrar != null) {
		if (borrar.equals("1")) {

			bAdministrarPublicaciones.eliminarArchivo(application.getRealPath("imagenes")+"/cursos/"+nombreFoto, fotoAEliminar, application.getRealPath("imagenes"));
%>
<script>
			alert('Foto eliminada con éxito');
			try{
				window.opener.recargar();
				window.close(); 
				
			}catch(e) {
				
			}
			</script>
<%
	}

	}

	List<RepositorioFotos> fotos = bAdministrarPublicaciones.getRepositorioFotosEliminar(tu, us);
	int cuenta = 0;
%>

<form method="post" name="form1"><strong>Fotos que puede
eliminar(Clic en la foto que desea eliminar):</strong><br />
<table width="100%" border="0" cellpadding="2" cellspacing="2">
	<%
		for (RepositorioFotos l : fotos) {
			if (cuenta == 0) {
	%><tr>
		<%
			}

				cuenta++;
				if (cuenta <= 6) {
		%>    
		<td><a href="#"
			onClick="borrar('<%=l.getIdFoto()%>','<%=l.getDireccionFoto()%>'); return false;">
		<img src="imagenes/cursos/<%=l.getDireccionFoto()%>?re=<%=Math.random()%>"
			width="72" height="72" alt="" /></a><br />
		</td>
		<%
			}
				if (cuenta == 6 || cuenta == fotos.size()) {
					cuenta = 0;
		%>
	</tr>
	<%
		}
		}
	%>


</table>
<br />
<p><input class="searchbutton" name="pp" type="button"
	style="cursor: hand" value="Cerrar ventana"
	onclick="window.close(); return false;" /></p>
<input name="hdnFoto22" type="hidden" id="hdnFoto22" value="0">
<input name="hdnNombreFoto" type="hidden" id="hdnNombreFoto" value="0">
<input name="hdnBorrar" type="hidden" value="0" id="hdnBorrar">
</form>

</body>
</html>
