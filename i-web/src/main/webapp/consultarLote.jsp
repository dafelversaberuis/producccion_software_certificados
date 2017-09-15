
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<%@page import="beans.Certificado"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>ISOLUCIONES S.A.S</title>
<meta name="Description"
	content="Isoluciones, Innovación en Gestión Empresarial">

<script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>
<script type="text/javascript" src="Scripts/claves.js" charset="UTF-8"></script>



<meta name="viewport" content="initial-scale=1.0,width=device-width">
<link rel="stylesheet" type="text/css" href="home_files/bootstrap.css">



<style>
.filters:before {
	width: 0% !important;
}
</style>
<style>
.fluidvids-elem {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	height: 100%;
}

.fluidvids {
	width: 100%;
	position: relative;
}
</style>
<style>
.filters:before {
	width: 100% !important;
}
</style>
<style>
.filters:before {
	width: 100% !important;
}
</style>
<style>
.filters:before {
	width: 0% !important;
}
</style>
<style>
.filters:before {
	width: 0% !important;
}
</style>
<link rel="stylesheet" type="text/css" href="css/epoch_styles.css" />
<script type="text/javascript" src="Scripts/epoch_classes.js"></script>
<script language="JavaScript">
	//Este script debe ponerse antes del Formulario
	//Empieza Calendario
	var dp_cal;
	var dp_cal2;
	window.onload = function() {
		dp_cal = new Epoch('dp_cal', 'popup', document
				.getElementById('fecha_inicio'));
		dp_cal2 = new Epoch('dp_cal2', 'popup', document
				.getElementById('fecha_fin'));
		dp_cal3 = new Epoch('dp_cal3', 'popup', document
				.getElementById('fecha_maxima'));
	};
	//Termina Calendario
	//Esta funcion asigna el calendario al campo5  del formulario
</script>
		<link rel="stylesheet" type="text/css" href="home_files/style.css">
</head>
<!--****************************INICIO SESION************************************* -->
<%
	java.util.Date fechaActual = new java.util.Date();
	SimpleDateFormat vFormato = new SimpleDateFormat("dd'/'MMMM'/'yyyy");
	String vFechaActual = vFormato.format(fechaActual);
	SimpleDateFormat vFormato2 = new SimpleDateFormat("yyy-MM-dd");
	String vFechaActual2 = vFormato2.format(fechaActual);

	String url = "";
	String field = "";
	String tipoUsuario = new String();
	String contrasena = new String();
	String usuario = new String();
	String rol = new String();
	int usuarioEncontrado = 0;

	if (session.isNew()) {
		//out.println("IdSesion: " + session.getId());
		usuario = (String) request.getParameter("usuario");
		contrasena = (String) request.getParameter("contrasena");

		if (usuario != null && !usuario.trim().equals("")) {
			usuarioEncontrado = bSeguridad.consultarExistenciaUsuario(
					usuario, contrasena, null).intValue();
			if (usuarioEncontrado != 0) {
				bUsuario = bSeguridad.registrarSesion(usuario,
						contrasena, usuarioEncontrado);
				if (bUsuario != null) {
					session.setAttribute("sesionCreada", bUsuario);
					session.setMaxInactiveInterval(7200); //2h-7200
					bUsuario = (beans.Usuario) session
							.getAttribute("sesionCreada");
				} else {
					session.invalidate();
					url = "notificacion.jsp";
					field = "*Su documento y/o contraseñas son incorrectos*";
				}

			} else {
				session.invalidate();
				url = "notificacion.jsp";
				field = "*Su documento y/o contraseñas son incorrectos*";
			}

		}

	} else {
		bUsuario = (beans.Usuario) session.getAttribute("sesionCreada");
		if (bUsuario == null) {
			session.invalidate();
			url = "notificacion.jsp";
			field = "Debe ingresar con su documento y contraseña...";
		}
	}

	if (!field.equals("")) {
%>
<jsp:forward page="<%=url%>">
	<jsp:param name="campo" value="<%=field%>" />
</jsp:forward>
<%
	}

	String tipoEgresado = "ADMINISTRADOR";
%>


<!--****************************FIN SESION************************************* -->
<body>
<%


List<Certificado> tiposCertificados = bAdministrarPublicaciones.getTiposCertificados();
List<Object[]> clientes = bAdministrarPublicaciones.getFinanciadores();
%>
	<form name="form1" id="form1" method="post">
  
		<!--HEADER-->
		<header><img src="home_files/logo.png" alt="logo" width="220px" height="auto">
		<div class="container">

			<!--MENU-->
			<a href="" id="responsive-menu-button"><i class="fa fa-bars"></i></a>
			<nav class="menu" style="display: block;">
			<%@include file="menu.html" %>
			</nav>
			<!--END MENU-->
			<p><%=bUsuario.getPrimerNombre().trim() + " "
					+ bUsuario.getSegundoNombre().trim() + " "
					+ bUsuario.getPrimerApellido().trim() + " "
					+ bUsuario.getSegundoApellido().trim()%><a
					href="#"
					onclick="document.getElementById('form1').action='index.jsp?sesion=false'; document.getElementById('form1').submit()"
					class="cerrar" style="text-decoration: none;"> (Cerrar sesión)</a>
			</p>
		</div>
		</header>
		<!--END HEADER-->

		<!--MAIN SECTION-->
		<div class="main work-page">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<!--POST-->
						<div class="post">

							<div class="content">
								<h4>Consultar personas capacitadas</h4><br><br>
<div align="left">
								<table width="100%" border="0" cellspacing="2" cellpadding="2">
								<tr>
										<td># Certificado o parte del mismo:</td>
										<td><input id="consecutivo" name="consecutivo"
											type="text" value="" /></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>Curso/tema/evento:</td>
										<td><select name="certificado" id="certificado" style="width:300px">
												<option value="0" selected>Seleccione..</option>
												<% if(tiposCertificados!=null && tiposCertificados.size()>0){
													for(Certificado c: tiposCertificados){
														%>
														<option value="<%=c.getId() %>"><%=c.getNombre().trim()%></option>
														<%
													}
												}
												
												%>

										</select></td>
										<td>Cliente:</td>
										<td><select name="cliente" id="cliente" style="width:300px">
										
												<option value="" selected>Seleccione..</option>
												<% if(clientes!=null && clientes.size()>0){ 
													for(Object[] c: clientes){
														%>
														<option value="<%=c[0] %>"><%=c[1]%></option>
														<%
													}
												}
												
												%>

										</select></td>
									</tr>
									<tr>
										<td>Documento:</td>
										<td><input id="documento" name="documento"
											type="text" value="" /></td>
										<td>Nombre persona o parte del mismo:</td>
										<td><input id="nombre" name="nombre"
											type="text" value="" /></td>
									</tr>
									<tr>
										<td>Fecha desde constancia:</td>
										<td><input name="fecha_inicio" id="fecha_inicio"
											class="texto" type="text"
											style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
											readonly="true" tabindex="2" size="14"
											value="" /> <img id="cal" name="cal"
											style="vertical-align: middle"
											src="images/iconocalendario.gif" title="Calendario"
											width="25" height="25" onClick="dp_cal.toggle();" /></td>


										<td>Fecha hasta constancia:</td>
										<td><input name="fecha_fin" id="fecha_fin" class="texto"
											type="text"
											style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
											readonly="true" tabindex="2" size="14"
											value="" /> <img id="cal2" name="cal2"
											style="vertical-align: middle"
											src="images/iconocalendario.gif" title="Calendario"
											width="25" height="25" onClick="dp_cal2.toggle();" /></td>
										<td>&nbsp;</td>
									</tr>
									
								</table></div>
								
								<br /><input type="button" value=" Consultar " onclick="validarLoteConsulta();"/><span id="detalleFechas"></span><br/><span id="detalleFechas"></span><br/><span id="detalleCorreos" style="text-align: center"></span><br/> <span id="detalleLote" style="text-align: center"></span>

								<input name="hdnUs" id="hdnUs" type="hidden"
									value="<%=bUsuario.getIdUsuario()%>" />
								

								<br />
								
								<br />
								<br />
								<br />

							</div>
						</div>
						<!--END POST-->


					</div>
				</div>
			</div>
		</div>
		
		<!--END MAIN SECTION-->

		<!--FOOTER-->
		<footer>
		<center>
			<div class="container">
				<img src="home_files/logo-sm.png" alt="">
				
				<p>
					Contacto: directorcomercial@isolucionesltda.com<br>(+57) 1 6960495 <br>Diseñado por:
					quimerapps.com
				</p>
			</div>
		</center>
		</footer>
		<!--END FOOTER-->

		<script src="home_files/jquery-1.11.0.min.js"></script>
		<script src="home_files/jquery-migrate-1.2.1.js"></script>

		<script src="home_files/smoothscroll.js"></script>
		<script src="home_files/snap.svg-min.js"></script>
		<script src="home_files/jquery.bxslider.js"></script>
		<script src="home_files/retina.min.js"></script>
		<script src="home_files/imagesloaded.pkgd.min.js"></script>
		<script src="home_files/masonry.pkgd.min.js"></script>
		<script src="home_files/classie.js"></script>
		<script src="home_files/modernizr.custom.js"></script>
		<script src="home_files/cbpGridGallery.js"></script>
		<script src="home_files/jquery.resizestop.min.js"></script>
		<script src="home_files/fluidvids.js"></script>
		<script src="home_files/doubletaptogo.js"></script>

		<script src="home_files/main.js"></script>
		 <input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion" type="hidden"
	 	value="0" />
</form>
</body>
</html>

