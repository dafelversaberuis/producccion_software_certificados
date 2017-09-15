<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	pageEncoding="ISO-8859-1" session="true"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<title>ACCESO</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="Description"
	content="Innovación en Gestión Empresarial">


<script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>

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


<script language="javascript" type="text/javascript">
	function fMenu() {
		var vError1 = false;
		var vError2 = false;
		if (document.getElementById('usuario').value == "") {
			vError1 = true;

		}
		if (document.getElementById('contrasena').value == "") {
			vError2 = true;
		}
		if (vError1) {
			if (vError2) {
				alert('¡Debe digitar su documento y contraseña de administrador!');
				document.getElementById('usuario').focus();

			} else {
				alert('¡Debe digitar su documento!');
				document.getElementById('usuario').focus();
			}
		} else {
			if (vError2) {
				alert('¡Debe especificar la contraseña!');
				document.getElementById('contrasena').focus();
			} else {

				window.opener.document.getElementById('usuario').value = document.getElementById('usuario').value;
				window.opener.document.getElementById('contrasena').value = document.getElementById('contrasena').value;
				
				window.opener.siss.submit();
				window.close();
				
			}

		}

	}
</script>
</head>
<body>

	<%
		session.invalidate();
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
	%>




	<form id="siss" name="siss" action="home.jsp" method="post">
		<p>
			Ingrese información solicitada para ingresar al módulo administrador:<br />
			<br />
		</p>

<center>


		<input type="text" name="usuario" id="usuario"
			placeholder="* Documento : "
			
			onfocus="this.placeholder = ''"
			onBlur="this.placeholder = '* Documento :'" /><br>
		<br>
		<br>
		<input type="password" name="contrasena" id="contrasena"
			placeholder="* Clave : "
		
			onfocus="this.placeholder = ''"
			onBlur="this.placeholder = '* Clave :'" /><br>
		<br>
		<br>
		<input name="button" type="button" class="submitBtn" onclick="fMenu()"
			value="Ingresar"
			 />
</center>
	</form>



</body>




</html>
<script>
	function enviar_formulario() {

		mensaje = "";

		if (document.getElementById('nombres').value.replace(/^\s*|\s*$/g, "") == "") {
			mensaje = mensaje + "\n* Debe diligenciar nombre completo.";
		}

		if (document.getElementById('correo').value.replace(/^\s*|\s*$/g, "") == "") {
			mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
		}

		if ((document.contact_form.correo.value != "")
				&& (!es_correo(document.contact_form.correo.value))) {
			mensaje = mensaje
					+ "\n* El correo electrónico no tiene una estructura válida.";

		}

		if (document.getElementById('telefono').value.replace(/^\s*|\s*$/g, "") == "") {
			mensaje = mensaje + "\n* Debe diligenciar el teléfono ó celular.";
		}

		if ((document.contact_form.telefono.value != "")
				&& (!es_numero(document.contact_form.telefono.value))) {
			mensaje = mensaje
					+ "\n* El teléfono ó celular contiene caractéres no válidos (Debe ser numérico).";

		}

		if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g,
				"") == "") {
			mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
		}

		if (mensaje != "") {
			alert("Por favor revise lo siguiente:\n\n " + mensaje);

		} else {

			document.getElementById('bandera').value = "1";
			document.contact_form.submit();
		}

	}

	function limpiar_formulario() {

		document.getElementById('nombres').value = "";
		document.getElementById('correo').value = "";
		document.getElementById('telefono').value = "";
		document.getElementById('txtContenido').value = "";
		alert('Formulario limpiado');
		document.contact_form.nombres.focus();

	}

	function es_correo(direccion) {
		var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if (filter.test(direccion))
			return true;
		else
			return false;
	}

	function es_numero(cadena) {
		var longit = cadena.length;

		for (k = 0; k < longit; k++) {
			var car = cadena.charAt(k);
			if ((car != '1') && (car != '2') && (car != '3') && (car != '4')
					&& (car != '5') && (car != '6') && (car != '7')
					&& (car != '8') && (car != '9') && (car != '0'))
				return false;
		}
		if (longit > 0)
			return true;
		else
			return false;
	}
</script>