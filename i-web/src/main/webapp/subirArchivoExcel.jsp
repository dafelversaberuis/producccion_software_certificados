<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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

<script>
	function cargarImagen()
	{
		if(document.frm_cargar.fil_imagen.value)
		{
			cadena="";
			cadena = "etiqueta_capacitacion="+(document.getElementById("etiqueta_capacitacion").value.replace(/^\s*|\s*$/g, ""))+"&certificado="+encodeURIComponent(document.getElementById("certificado").value.replace(/^\s*|\s*$/g, ""))+"&ciudad_curso="+document.getElementById("ciudad_curso").value.replace(/^\s*|\s*$/g, "")+"&horas_certificadas="+encodeURIComponent(document.getElementById("horas_certificadas").value.replace(/^\s*|\s*$/g, ""))+"&fecha_inicio="+encodeURIComponent(document.getElementById("fecha_inicio").value.replace(/^\s*|\s*$/g, ""))+"&fecha_maxima="+encodeURIComponent(document.getElementById("fecha_maxima").value.replace(/^\s*|\s*$/g, ""))+"&cliente="+encodeURIComponent(document.getElementById("cliente").value.replace(/^\s*|\s*$/g, ""))+"&numero_firmas="+encodeURIComponent(document.getElementById("numero_firmas").value.replace(/^\s*|\s*$/g, ""))+"&nombre_capacitador="+(document.getElementById("nombre_capacitador").value.replace(/^\s*|\s*$/g, ""))+"&cargo_capacitador="+(document.getElementById("cargo_capacitador").value.replace(/^\s*|\s*$/g, ""))+"&empresa_capacitador="+(document.getElementById("empresa_capacitador").value.replace(/^\s*|\s*$/g, ""));
		
			document.frm_cargar.action="recibirArchivoExcel.jsp?"+cadena;
			document.frm_cargar.submit();
		}
		else 
		{
			alert("Debe seleccionar un archivo. Clic en el botón examinar; seleccione la imagen y luego clic en Aceptar");			
		}
	
	}

</script>
</head>
<body style="background-color: #AFDBF6">
<%


String ciudad_curso =  request.getParameter("ciudad_curso"); //fecha_disponibilidad
String fecha_maxima =  request.getParameter("fecha_maxima"); //fecha_disponibilidad
String etiqueta_capacitacion =  request.getParameter("etiqueta_capacitacion"); // label etiqueta
String fecha_inicio =  request.getParameter("fecha_inicio"); // fecha inicio
String horas_certificadas =  request.getParameter("horas_certificadas"); //horas
String certificado =  request.getParameter("certificado"); //tipo certificado
String cliente =  request.getParameter("cliente"); //cliente

String numero_firmas =  request.getParameter("numero_firmas"); //
String nombre_capacitador =  request.getParameter("nombre_capacitador"); //
String cargo_capacitador =  request.getParameter("cargo_capacitador"); //
String empresa_capacitador =  request.getParameter("empresa_capacitador"); //





%>

<p class="Estilo4">&nbsp;</p>
<p class="Estilo4">&nbsp;</p>
<p class="Estilo4">Seleccione el archivo que desea cargar. Formato excel aceptado <b>csv</b></p>
<form action="recibirArchivoExcel.jsp" method="post" enctype="multipart/form-data" name="frm_cargar">

<input type="hidden" id="ciudad_curso" name="ciudad_curso" value="<%=ciudad_curso%>">
<input type="hidden" id="fecha_maxima" name="fecha_maxima" value="<%=fecha_maxima%>">
<input type="hidden" id="etiqueta_capacitacion" name="etiqueta_capacitacion" value="<%=etiqueta_capacitacion%>">
<input type="hidden" id="fecha_inicio" name="fecha_inicio" value="<%=fecha_inicio%>">
<input type="hidden" id="horas_certificadas" name="horas_certificadas" value="<%=horas_certificadas%>">
<input type="hidden" id="certificado" name="certificado" value="<%=certificado%>">
<input type="hidden" id="cliente" name="cliente" value="<%=cliente%>">

<input type="hidden" id="numero_firmas" name="numero_firmas" value="<%=numero_firmas%>">
<input type="hidden" id="nombre_capacitador" name="nombre_capacitador" value="<%=nombre_capacitador%>">
<input type="hidden" id="cargo_capacitador" name="cargo_capacitador" value="<%=cargo_capacitador%>">
<input type="hidden" id="empresa_capacitador" name="empresa_capacitador" value="<%=empresa_capacitador%>">


        <p>
          <input name="fil_imagen" type="file" size="40">
 </p>
        <p align="center">         
          <input type="button" name="btn_cargar" value="Aceptar" onClick="cargarImagen();" class="searchbutton" style="cursor: hand">        
                </p>
                
                <br/>
                <br/>
                <br/>
                <br/>
                <br/>
                <br/>
                 <br/>
                <br/>
                <br/>
                <br/>
</form>
</body>
</html>
