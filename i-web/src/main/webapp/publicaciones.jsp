<%@ page language="java" contentType="text/html; charset=iso-8859-1"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	session="true"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title>MULTIEMERGENCIAS S.A.S</title>
<meta name="Description"
	content="CENTRO DE ENTRENAMIENTO EN EMERGENCIAS y SALUD OCUPACIONAL ">

<style type="text/css" media="all">
@import "css/widgEditor.css";
</style>

<script type="text/javascript" src="Scripts/widgEditor.js"></script>

<link href="estilos/estilos.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>
<script type="text/javascript" src="Scripts/claves.js" charset="UTF-8"></script>



</head>
<!--****************************INICIO SESION************************************* -->
<%
	java.util.Date fechaActual = new java.util.Date();
	SimpleDateFormat vFormato = new SimpleDateFormat("dd'/'MMMM'/'yyyy");
	String vFechaActual = vFormato.format(fechaActual);

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
	<form name="form1" id="form1" method="post" action="publicaciones.jsp" onsubmit="guardarPublicacion();">
		<div id="top-izq"></div>
		<div id="contenedor">
			<div id="encabezado">
				<div id="barra_roja">
					<h1><%=bUsuario.getPrimerNombre().trim() + " "
					+ bUsuario.getSegundoNombre().trim() + " "
					+ bUsuario.getPrimerApellido().trim() + " "
					+ bUsuario.getSegundoApellido().trim()%><a href="#"
							onclick="document.getElementById('form1').action='index.jsp?sesion=false'; document.getElementById('form1').submit()"
							class="cerrar" style="text-decoration: none; color:"> (Cerrar
							sesión)</a>
					</h1>
				</div>
				<div id="logo_multiemergencias">
					<img id="" src="imagenes/logo-multiemergencias.png"
						alt="logo Multiemergencias" width="571" height="212">
				</div>
				<div id="menu_principal">
					<a class="estilo_enlaces_principales"  href="publicaciones.jsp">Noticias</a>
                <a class="estilo_enlaces_principales"  href="secciones.jsp">Secciones</a>
                <a class="estilo_enlaces_principales" href="portafolios.jsp">Portafolio</a>
                <a class="estilo_enlaces_principales" href="consultarRepositorio.jsp">Fotos</a>
                <a class="estilo_enlaces_principales"  href="administradores.jsp">Administradores</a>
				</div>
			</div>

			<div id="noticia_interna_1">
				<div id="titulo_noticia">
					<center>
						<h2>Administración de noticias</h2>
					</center>
					<br>
				</div>
				<div id="contenido_noticia_1">
					<input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion"
						type="hidden" value="0" />
					<%
						String titulo = request.getParameter("txtTitulo");
						String contenido = request.getParameter("txtContenido");
						String dirigido = request.getParameter("sltDirigido");
						String egresadoEscogido = request.getParameter("hdnEgresado");
						String foto = request.getParameter("hdnFoto");
						String us = request.getParameter("hdnUs");
						String tu = request.getParameter("hdnTipoUs");
						String hdnGuardarPublicacion = request
								.getParameter("hdnGuardarPublicacion");

						int actualizo = 0;
						if (hdnGuardarPublicacion != null
								&& hdnGuardarPublicacion.equals("1")) {
							if (tu != null) {
								if (Integer.parseInt(tu) == 1) {
									actualizo = bAdministrarPublicaciones
											.guardarPublicacion(1, 0, Integer.parseInt(us),
													Integer.parseInt(dirigido), titulo,
													contenido, foto, egresadoEscogido);

								} else {

									actualizo = bAdministrarPublicaciones
											.guardarPublicacion(2, Integer.parseInt(us), 0,
													Integer.parseInt(dirigido), titulo,
													contenido, foto, egresadoEscogido);
								}
							}
							
							
							if(actualizo==1){
								
								%>
								<script>

								alert('NOTICIA GUARDADA CON EXITO');

								</script>
								<%
								
							}
							

						}
					%>
					<p>
						<br>Seleccione una de estas dos opciones:<br> <br>
						<br> <a href="#"
							onclick="document.getElementById('pub1').style.display = 'block'; document.getElementById('pub2').style.display = 'none'; return false; "
							style="text-decoration: none">1 - Crear nueva noticia</a><br>
						<a href="#"
							onclick="document.getElementById('pub2').style.display = 'block'; document.getElementById('pub1').style.display = 'none'; return false;"
							style="text-decoration: none">2 - Consultar / eliminar
							noticias</a>
					</p>
					<input name="hdnUs" id="hdnUs" type="hidden"
						value="<%=bUsuario.getIdUsuario()%>" /> <input name="hdnTipoUs"
						id="hdnTipoUs" type="hidden" value="2" />
					<div id="pub1">
						<p style="color: #FFD014; font-weight: bold">Datos de la
							noticia a crear:</p>
						<table border="0" width="100%" cellpadding="2">

							<tr>
								<td>* Título Noticia:<br /> <input name="txtTitulo"
									type="text" id="txtTitulo" style="width: 300px"
									class="searchfield" /></td>
								<td colspan="3">&nbsp;</td>
								<td colspan="2">&nbsp;</td>
							</tr>

							<tr>
								<td><input type="hidden" value="2" name="sltDirigido"
									id="sltDirigido" /></td>
								<td width="8%"></td>
								<td colspan="2"><span id="detalleEgresado"></span></td>
								<td width="5%"><span id="detalleEgresado2"></span> <input
									name="hdnEgresado" id="hdnEgresado" type="hidden" value="0" /></td>
								<td width="14%">&nbsp;<br /> <br /></td>
							</tr>


							<tr>
								<td colspan="6">*Contenido:<br /> <textarea
										name="txtContenido" rows="10" class="widgEditor nothing"
										id="txtContenido" style="width: 94%"></textarea></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td colspan="3">&nbsp;</td>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="3"><a href="#"
									onclick="buscarFoto(); return false;"
									style="text-decoration: none">Asociar una imagen (opcional)</a>
								</td>
								<td width="7%"></td>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td align="left" colspan="6"><span id="detalleFoto1"></span></td>

							</tr>
							<tr>
								<td align="left"><span id="detalleFoto2"></span></td>
								<td colspan="5" align="left"><span id="detalleGuardar"></span></td>

							</tr>
						</table>
						<input name="hdnFoto" id="hdnFoto" type="hidden" value="" /><br>
						<input class="searchbutton" name="btnAceptar" id="btnAceptar"
							type="submit" style="cursor: hand" value=" Guardar "
							 />
					</div>

				</div>


				<div id="pub2" style='display: none;'>
					<p style="color: #FFD014; font-weight: bold">Noticias ya
						realizadas:</p>

					<span id="detalleEliminar"></span>
					<div id="detallePropias"></div>
					<script language="javascript" type="text/javascript">
						cargarPropias();
					</script>
				</div>



			</div>
		</div>




		<div id="footer">
			<div id="contenido_footer"><h3>Contacto: multiemergenciassas@gmail.com<br>Whatsapp: (+57) 316 629 27 91 ; (+57) 320 408 03 85<br>Bucaramanga, Colombia<br> <br>Software por: quimerapps.com</h3></div>
			<div id="footer-der"></div>
		</div>
	</form>

</body>
</html>
