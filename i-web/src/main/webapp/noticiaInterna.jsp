<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<%@page import="beans.Parametro"%>	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>MULTIEMERGENCIAS S.A.S</title>
    <meta name="Description" content="CENTRO DE ENTRENAMIENTO EN EMERGENCIAS y SALUD OCUPACIONAL ">
    <link href="estilos/estilos.css" rel="stylesheet" type="text/css">   
</head>
<body>
    
   <div id="top-izq"></div>  
     <div id="contenedor">
	<div id="encabezado">		 
      	<div id="barra_roja"><h1>Entrenamiento en Emergencias y Salud Ocupacional</h1></div>     
		<div id="logo_multiemergencias"><img id="" src="imagenes/logo-multiemergencias.png" alt="logo Multiemergencias" width="571" height="212"></div>
		<div id="menu_principal">
			
			<a ></a><a class="estilo_enlaces_principales" href="index.jsp"><< Regresar a página principal >></a>
			<a  ></a>
		</div> 		
	</div>
	 <% String idPublicacion= request.getParameter("id"); Publicacion l = null;
       if(idPublicacion!=null){
      l =  bAdministrarPublicaciones.getNotaPublica(Integer.parseInt(idPublicacion));
      
     %>
	 <div id="noticia_interna_1">                
                <div id="titulo_noticia"><center><h2><%=l.getTituloPublicacion().trim() %></h2></center><br></div> 
                <div id="contenido_noticia_1"><%if(l.getDireccionFotoPublicacion()!=null && !l.getDireccionFotoPublicacion().trim().equals("") && !l.getDireccionFotoPublicacion().trim().equals("null")){ %><div id="foto_noticia_interna"><center><img id="imagen_noticia" src="images/publicaciones/<%=l.getDireccionFotoPublicacion() %>"  width="470" height="450"></center><br/></div><%} %><br> <%=l.getContenidoPublicacion().trim() %>
              </div> 
           </div>
				<%} %>
	 	 
	</div>
	
	<div id="footer">            
        <div id="contenido_footer"><h3>Contacto: multiemergenciassas@gmail.com<br>Whatsapp: (+57) 316 629 27 91 ; (+57) 320 408 03 85<br>Bucaramanga, Colombia<br> <br>Software por: quimerapps.com</h3></div> 
		<div id="footer-der"></div>  
        </div>	

</body>
</html>