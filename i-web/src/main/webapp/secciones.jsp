<%@ page language="java" contentType="text/html; charset=iso-8859-1" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
     session="true" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<%@page import="beans.Seccion"%>


	<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   <title>MULTIEMERGENCIAS S.A.S</title>
    <meta name="Description" content="CENTRO DE ENTRENAMIENTO EN EMERGENCIAS y SALUD OCUPACIONAL ">
  

</head>
    
    <script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>
<script type="text/javascript" src="Scripts/claves.js" charset="UTF-8"></script>
<meta name="viewport" content="initial-scale=1.0,width=device-width">
<link rel="stylesheet" type="text/css" href="home_files/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="home_files/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="home_files/style.css">

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
<link rel="stylesheet" href="assets/css/font-awesome.css" type="text/css" />
<script src="ckeditor/ckeditor.js" charset="utf-8"></script>
	<script src="ckeditor/samples/js/sample.js" charset="utf-8" ></script>
	<link rel="stylesheet" href="ckeditor/samples/toolbarconfigurator/lib/codemirror/neo.css">

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
			usuarioEncontrado = bSeguridad.consultarExistenciaUsuario(usuario, contrasena, null).intValue();
			if (usuarioEncontrado != 0) {
				bUsuario = bSeguridad.registrarSesion(usuario, contrasena, usuarioEncontrado);
				if (bUsuario != null) {
					session.setAttribute("sesionCreada", bUsuario);
					session.setMaxInactiveInterval(7200); //2h-7200
					bUsuario = (beans.Usuario) session.getAttribute("sesionCreada");
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
  <form  name="form1" id="form1" method="post"> 
<!--HEADER-->
	<header><img src="home_files/logo.png" alt="logo" width="220px" height="80px">
	<div class="container">
		
		<!--MENU-->
		<a href="" id="responsive-menu-button"><i class="fa fa-bars"></i></a>
		<nav class="menu" style="display: block;">
		<ul class="list-inline">
<li class="dropdown">
					<a href="">Capacitados</a>
						<ul class="dropdown-menu">
						<li><a href="cursos.jsp">Cursos o tipos de certificados</a></li>
							<li><a href="crearLote.jsp">Nuevo Lote de capacitados</a></li>
							<li><a href="consultarLote.jsp">Consultar Capacitados</a></li>
						</ul>
					</li>
			<li><a href="secciones.jsp">Secciones</a></li>
			<li><a href="portafolios.jsp">Portafolio</a></li>
			<li><a href="consultarRepositorio.jsp">Fotos</a></li>
			<li><a href="administradores.jsp">Administradores</a></li>
		</ul>
		</nav>
		<!--END MENU-->
		<p><%=bUsuario.getPrimerNombre().trim() + " " + bUsuario.getSegundoNombre().trim() + " " + bUsuario.getPrimerApellido().trim() + " " + bUsuario.getSegundoApellido().trim()%><a
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
							<h3>SECCIONES DEL SITIO</h3>

							<center><p>
	   	 <input name="hdnUs" id="hdnUs" type="hidden"
	value="<%=bUsuario.getIdUsuario()%>" />
<input name="hdnTipoUs" id="hdnTipoUs" type="hidden"
	value="2" />
	<input name="hdnSimulador" id="hdnSimulador" type="hidden"
	value="0" />
	<div id="pub1">
	   <%
	   
	
	 	String titulo = request.getParameter("txtTitulo");
	 	String contenido = request.getParameter("txtContenido");
	 	String dirigido = request.getParameter("sltDirigido");
	 	
	 	String foto = request.getParameter("hdnFoto");
	 	String hdnGuardarPublicacion = request.getParameter("hdnGuardarPublicacion");


	 	int actualizo = 0;
	 	if(hdnGuardarPublicacion!=null && hdnGuardarPublicacion.equals("1")){

	 		actualizo = bAdministrarPublicaciones.guardarSeccion(titulo, contenido, foto, dirigido);
	 	}	 		
	 	
	if(actualizo==1){
		
		%>
		<script>
		alert("SECCION ACTUALIZADA CON EXITO");
		</script>
		<% 		
	}

	
	   
	   
	String id = request.getParameter("sltDirigido");
if(id==null){
	id = "0";
}
	  
List<Seccion> secciones = bAdministrarPublicaciones.getSecciones();

Seccion seccion = null;
    %>
    
    	<%if(!id.equals("0")){
    		
    		
    		seccion = bAdministrarPublicaciones.getSeccion(Integer.parseInt(id));
    		
    	}%>
    	
    
    	
           
<table border="0" width="100%" cellpadding="2">
<tr>
		<td><span class="Estilo3"><span class="Estilo4 Estilo8">*</span>
		Sección a editar:</span></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>  
		<td>
		<select name="sltDirigido" id="sltDirigido" class="searchfield" onchange="recargarSeccion()" style="width:300px">
		<%if(id.equals("0")){
			%>
			<option value="0" selected>-Seleccione-</option>
			
			<%}else{
				%>
				<option value="0">-Seleccione-</option>
				<%}%>
			
	
		
		<%
		int c=0;
		for(Seccion s: secciones){
		c++;
		
		if(id.equals(""+s.getSeccion())){
		%>
		
		<option value="<%=s.getSeccion()%>" selected> <%=s.getTitulo() %></option>
		
		<%			
			
		}else{
		
		%>
		
		
		<option value="<%=s.getSeccion()%>"><%=s.getTitulo() %></option>
		
		
		<%}} %>
		
		
		</select>		</td>
		<td width="8%"></td>
		<td colspan="2"><span id="detalleEgresado"></span></td>
		<td width="5%"><span id="detalleEgresado2"></span>
		    <input
			name="hdnEgresado" id="hdnEgresado" type="hidden"
			value="0" /></td>
		<td width="14%">&nbsp;</td>
	</tr>
	
	<%if(!id.equals("0")){ %>
	
	<tr>
		<td width="39%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span> Título de la sección:</span></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td><input name="txtTitulo" type="text" id="txtTitulo" style="width:300px"
			class="searchfield" value="<%= seccion.getTitulo()%>"/></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	 
	
	<tr>
		<td>&nbsp;</td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td><span class="Estilo3"><span class="Estilo3"><span class="Estilo4 Estilo8">*</span>
		</span>Contenido:</span></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="6">
	
		
		<div lang="es">
		
		<textarea cols="80" id="txtContenido" name="txtContenido" rows="10" style="visibility: hidden; display: none;"><%= seccion.getContenido()%></textarea>
		</div>
		</td>
		</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3"> 
	<%if(seccion.getDireccionFoto()==null || seccion.getDireccionFoto().trim().equals("") || seccion.getDireccionFoto().trim().equals("null")){ %>
		<a href="#" onclick="buscarFoto(); return false;" style="text-decoration:none">Asociar una imagen a la portada (opcional)</a> 
		
		<%} %>
		
		</td>
		<td width="7%">
			</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="left" colspan="6"><span id="detalleFoto1">
			<%if(seccion.getDireccionFoto()!=null && !seccion.getDireccionFoto().trim().equals("") && !seccion.getDireccionFoto().trim().equals("null")){ %>
		
		<img src='/i-web/images/publicaciones/<%=seccion.getDireccionFoto() %>' width='317' height='187' />
	
		<%} %>
		
		
		</span></td>
		
	</tr>
	<tr>
		<td align="left"><span id="detalleFoto2">
		
		<%if(seccion.getDireccionFoto()!=null && !seccion.getDireccionFoto().trim().equals("") && !seccion.getDireccionFoto().trim().equals("null")){ %>
		<a class='current' href='#' onclick='removerFoto(); return false;'>(Remover imagen)</a><br>
		
		<%} %>
		</span></td>
		<td colspan="5" align="left"><span id="detalleGuardar"></span></td>
		
	</tr>  
	<%} %>
	
	
</table> 
 <input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion" type="hidden"
	 	value="0" />
<%if(!id.equals("0")){ %>

<input type="button" value="Actualizar sección" onclick="guardarSeccion()">

			 
			
			 
	    <input name="hdnFoto" id="hdnFoto" type="hidden"
	value="<%=seccion.getDireccionFoto() %>" />
	
	<%} %>
	<br/>
	   
	    </div>
	   </center>
<br/><br/><br/><br/><br/><br/>

						</div>
					</div>
					<!--END POST-->


				</div>
			</div>
		</div>
	</div>
	<!--END MAIN SECTION-->

	<!--FOOTER-->
	<footer><center>
	<div class="container">
		<img src="home_files/logo-sm.png" alt="">
		<ul class="list-inline social">
			<li><a href="https://www.facebook.com/muliemergencias.centrodeentrenamiento" target="_blank"><i class="fa fa-facebook"></i></a></li>
			<li><a href="http://www.twitter.com/" target="_blank" ><i class="fa fa-twitter"></i></a></li>
			<li><a href="https://co.linkedin.com/pub/jefe-nixon-zambrano/52/168/b8b" target="_blank" ><i class="fa fa-linkedin"></i></a></li>

		</ul>
		<p>
			Contacto: multiemergenciassas@gmail.com<br>Whatsapp: (+57) 316 629 27 91 ; (+57) 320 408 03 85<br>Diseñado por: quimerapps.com
		</p>
	</div></center>
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
</form>
</body>
</html>
<script>
	//initSample();
	CKEDITOR.replace( 'txtContenido' );

	
</script>
<script>
document.getElementById('hdnSimulador').value = document.getElementById('sltDirigido').value;

		</script>
