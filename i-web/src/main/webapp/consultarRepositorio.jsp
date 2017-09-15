<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
     session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
	<%@page import="beans.RepositorioFotos"%>
<%@page import="beans.Publicacion"%>	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>MULTIEMERGENCIAS S.A.S</title>
    <meta name="Description" content="CENTRO DE ENTRENAMIENTO EN EMERGENCIAS y SALUD OCUPACIONAL ">

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

<script>

function recargar(){
	
	document.form1.submit();
}

</script>
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
   <form  name="form1" id="form1" method="post" action="consultarRepositorio.jsp?r=<%=Math.random()%>"></form>
   
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
							<h3>REPOSITORIO DE FOTOS</h3>
<%  List<RepositorioFotos> fotos = bAdministrarPublicaciones.getRepositorioFotos(); if(fotos==null || (fotos!=null && fotos.size()<4)){ %>
							<a href="#" style="text-decoration:none" onclick="window.open('/i-web/subirFoto.jsp?tu=<%=bUsuario.getTipoUsuario()%>&us=<%=bUsuario.getIdUsuario()%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=400, height=300'); return false;">Compartir una nueva foto</a>&nbsp; |<%} %> &nbsp;
<a href="#" style="text-decoration:none" onclick="window.open('/i-web/eliminarFoto.jsp?tu=2&us=<%=bUsuario.getIdUsuario()%>&r=<%=Math.random()%>', 'popup2', 'toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=600, height=400'); return false;">Eliminar foto</a><br />
<p>(Sólo se permite hasta cuatro fotos simultáneas para no recargar la página principal)</p>
<div class="slider">
        					
    						<div class="bx-wrapper" style="max-width: 100%;"><div class="bx-viewport" style="width: 100%; overflow: hidden; position: relative; height: 500px;"><ul style="width: 415%; position: relative; transition-duration: 0s; transform: translate3d(-2320px, 0px, 0px);">
							
						 <%
    
   
    for(RepositorioFotos l: fotos){
    	%>	
							<li style="float: left; list-style: none; position: relative; width: 1140px;" class="bx-clone">
    								<img src="/i-web/imagenes/cursos/<%=l.getDireccionFoto() %>?rf=<%=Math.random()%>" alt="Multiemegergencias">
    							</li>
    							
    					<%
    	
    	
    	}
    
    %>		
    							</ul></div><div class="bx-controls bx-has-pager"><div class="bx-pager bx-default-pager"><div class="bx-pager-item"><a href="" data-slide-index="0" class="bx-pager-link">1</a></div><div class="bx-pager-item"><a href="" data-slide-index="1" class="bx-pager-link active">4</a></div></div></div></div>
    					</div>



   
    	      
            

<br/>
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

</body>
</html>
