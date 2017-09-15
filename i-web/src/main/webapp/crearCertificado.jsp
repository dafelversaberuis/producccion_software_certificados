<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
     session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>MULTIEMERGENCIAS S.A.S</title>
    <meta name="Description" content="CENTRO DE ENTRENAMIENTO EN EMERGENCIAS y SALUD OCUPACIONAL ">
    <link href="estilos/estilos.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>
<script type="text/javascript" src="Scripts/claves.js" charset="UTF-8"></script>

<link rel="stylesheet" type="text/css" href="css/epoch_styles.css" />
	<script type="text/javascript" src="Scripts/epoch_classes.js"></script>
	<script language="JavaScript">
	//Este script debe ponerse antes del Formulario
	//Empieza Calendario
	var dp_cal;
	var dp_cal2;      
	window.onload = function () {
	dp_cal  = new Epoch('dp_cal','popup',document.getElementById('fecha_inicio'));
	dp_cal2  = new Epoch('dp_cal2','popup',document.getElementById('fecha_fin'));
	dp_cal3  = new Epoch('dp_cal3','popup',document.getElementById('fecha_maxima'));
	};
	//Termina Calendario
//Esta funcion asigna el calendario al campo5  del formulario
	
</script>

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
<body> <form  name="form1" id="form1" method="post"> 
        <div id="top-izq"></div>  
     <div id="contenedor">
	<div id="encabezado">		 
      	<div id="barra_roja"><h1><%=bUsuario.getPrimerNombre().trim() + " " + bUsuario.getSegundoNombre().trim() + " " + bUsuario.getPrimerApellido().trim() + " " + bUsuario.getSegundoApellido().trim()%><a href="#" onclick="document.getElementById('form1').action='index.jsp?sesion=false'; document.getElementById('form1').submit()" class="cerrar" style="text-decoration:none;"> (Cerrar sesión)</a></h1></div>     
		<div id="logo_multiemergencias"><img id="" src="imagenes/logo-multiemergencias.png" alt="logo Multiemergencias" width="571" height="212"></div>
		<div id="menu_principal">
			<a class="estilo_enlaces_principales"  href="publicaciones.jsp">Noticias</a>
                <a class="estilo_enlaces_principales"  href="secciones.jsp">Secciones</a>
                <a class="estilo_enlaces_principales" href="portafolios.jsp">Portafolio</a>
                <a class="estilo_enlaces_principales" href="consultarRepositorio.jsp">Fotos</a>
                <a class="estilo_enlaces_principales"  href="administradores.jsp">Administradores</a>
		</div> 		
	</div>
	
	 <div id="noticia_interna_1">                
                <div id="titulo_noticia"><center><h2>Crear nuevo grupo de certificados</h2></center><br></div> 
                <div id="contenido_noticia_1">
	   <table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td>Certificado:</td>
    <td><select name="certificado" id="certificado" style="font-size: 11px">
    		<option value="0">Seleccione..</option>
    
    </select></td>
    <td>Ciudad/Departamento donde se dictó:</td>
    <td><input id="ciudad_curso" name="ciudad_curso" type="text" value="Bucaramanga"/></td>
  </tr>
  <tr>
    <td>Fecha inicio curso: </td>
     <td><input name="fecha_inicio" id="fecha_inicio" class="texto" type="text" style="background-color:#D1D6E2 ; text-align:center ; vertical-align:middle" readonly="true" tabindex="2" size="14" value="<%=vFechaActual2%>"/>
        <img id="cal" name="cal" style="vertical-align:middle" src="images/iconocalendario.gif" title="Calendario" width="25" height="25" onClick="dp_cal.toggle();"/></td>
    

    <td>Fecha fin curso:</td>
    <td>
<input name="fecha_fin" id="fecha_fin" class="texto" type="text" style="background-color:#D1D6E2 ; text-align:center ; vertical-align:middle" readonly="true" tabindex="2" size="14" value="<%=vFechaActual2%>"/>
        <img id="cal2" name="cal2" style="vertical-align:middle" src="images/iconocalendario.gif" title="Calendario" width="25" height="25" onClick="dp_cal2.toggle();"/></td>   
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Fecha máx disponibilidad:</td>
    <td><input name="fecha_maxima" id="fecha_maxima" class="texto" type="text" style="background-color:#D1D6E2 ; text-align:center ; vertical-align:middle" readonly="true" tabindex="2" size="14" value="<%=vFechaActual2%>"/>
        <img id="cal3" name="cal3" style="vertical-align:middle" src="images/iconocalendario.gif" title="Calendario" width="25" height="25" onClick="dp_cal3.toggle();"/></td>
    <td>Horas certificadas:</td>
    <td><input id="horas_certificadas" name="horas_certificadas" type="text" value="0" style="width:30px" /></td>
  </tr>  
  <tr>
    <td>Número personas:</td>
    <td><input id="numero_personas" name="numero_personas" type="text" value="1" style="width:30px" onchange="cargarNuevoLote();"/></td>
    <td></td>
    <td></td>
  </tr>  
</table>


<br/>
<br/>
<br/>
<center>
<span id="detalleLote" style="text-align:center"></span>
</center>
<input name="hdnUs" id="hdnUs" type="hidden"
	value="<%=bUsuario.getIdUsuario()%>" />
	   <script>
	   cargarNuevoLote();
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