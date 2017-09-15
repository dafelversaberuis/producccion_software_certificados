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
<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
	<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span> Documento:</span></td>
		<td width="66%"><span class="Estilo3"><span class="Estilo4 Estilo8">*</span> Correo electr&oacute;nico:</span></td>
	</tr>
	<tr>
		<td><input name="txtDocumento" type="text" id="txtDocumento"
			class="searchfield"  /></td>
		<td><input name="txtCorreo" type="text" id="txtCorreo"
			class="searchfield" /></td>
	</tr>
	<tr>
      <td><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Primer nombre :</span></td>
	  <td><span class="Estilo3">Segundo nombre:</span></td>
    </tr>
	<tr>
		<td><input name="txtNombre1" type="text" id="txtNombre1"
			class="searchfield"  /></td>
		<td><input name="txtNombre2" type="text" id="txtNombre2"
			class="searchfield"  /></td>
	</tr>
	<tr>
      <td><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Primer apellido :</span></td>
	  <td><span class="Estilo3">Segundo apellido:</span></td>
    </tr>
	<tr>
      <td><input name="txtApellido1" type="text" id="txtApellido1"
			class="searchfield"  /></td>
	  <td><input name="txtApellido2" type="text" id="txtApellido2"
			class="searchfield"  /></td>
    </tr>
	<tr>
      <td><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Contrase&ntilde;a :</span></td>
	  <td><span class="Estilo3">Repita contrase&ntilde;a :</span></td>
    </tr>
	<tr>
      <td><input name="txtClave" type="password" id="txtClave"
			class="searchfield"  /></td>
	  <td><input name="txtClave2" type="password" id="txtClave2"
			class="searchfield"  /></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"><div align="center"><span id="detalleActualizarDatos">
		  <input class="searchbutton"
			name="btnActualizarDatos" id="btnActualizarDatos" type="button"
			style="cursor: hand" value=" Crear "
			onClick="nuevoAdmin(); return false;" />
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
</form>
</div>
</body>
</html>
