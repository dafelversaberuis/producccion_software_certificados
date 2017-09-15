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
<%

String bandera = request.getParameter("bandera");

String asunto = "";
String mensaje ="";
String usuarioEnvia ="";
String fromEnvia ="";
String nombreAdjuntoCorreo="";


String seudonimo = "";
String nombres = request.getParameter("nombres");

String correoe =  request.getParameter("correo");
String telefono =  request.getParameter("telefono");
String contenido = request.getParameter("txtContenido");

if(correoe==null){
	

	correoe =  "";
	
	
}

if(nombres==null){
	
	nombres = "";

	
}

if(telefono==null){
	
	
	telefono = "";
	
}

if(contenido==null){
	
	contenido = "";
	
}

if(bandera!=null && bandera.equals("1")){
	
	int exito = bAdministrarPublicaciones.contactar(correoe, nombres, telefono, contenido);
	
	if(exito==1){
		nombres = "";

		correoe =  "";
		telefono = "";
		contenido = "";
		%>
		<script>
alert('Información enviada con éxito');



		</script>
		<%
	}
}


%>
    <form action="" method="post" name="form1" >
                        <input name="bandera" id="bandera" type="hidden" value="0" />
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
	
	 <div id="noticia_interna_1">                
                <div id="titulo_noticia"><center><h2>Contáctenos</h2></center><br></div> 
                <div id="contenido_noticia_1">
              </div> 
           </div><center>Correo: multiemergenciassas@gmail.com<br/>Whatsapp: (+57) 316 629 27 91 ; (+57) 320 408 03 85<br/>Ó diligencie el siguiente formulario sobre cualquier tema. Enseguida le estaremos respondiendo.</center> 
                <br><br>
                
                 <table width="70%" border="0" cellspacing="2" cellpadding="2"  align="center">
                                <tr>
                                <td colspan="3" align="center">&nbsp;</td>
                                </tr>
                             
                              <tr>
                                <td style="padding:0 0 0 80px ">Nombre completo:</td>
                                <td colspan="2" align="center">
                                  <input name="nombres" type="text" id="nombres" style="width:90%" value="<%=nombres%>" class="texto_contenido" /></td>
                                </tr>
                             
                              <tr>
                                <td style="padding:0 0 0 80px ">Correo electr&oacute;nico:</td>
                                <td colspan="2" align="center"><input name="correo" type="text" id="correo" style="width:90%" value="<%=correoe%>" class="texto_contenido"/></td>
                                </tr>
                              <tr>
                                <td style="padding:0 0 0 80px ">Tel&eacute;fono:</td>
                                <td colspan="2" align="center"><input name="telefono" type="text" id="telefono" style="width:90%" value="<%=telefono%>" class="texto_contenido"/></td>
                                </tr>
                                  <tr>
                                <td style="padding:0 0 0 80px ">Escribe aquí:</td>
                                <td colspan="2" align="center"><textarea name="txtContenido" rows="10"  id="txtContenido" style="width: 90%"><%=contenido%></textarea></td>
                                </tr>
                              
                              <tr>
                                <td>&nbsp;</td>
                                <td colspan="2">&nbsp;</td>
                              </tr>
                             
                              <tr>
                                <td align="center"></td>
                                <td colspan="2" align="center"></td>
                              </tr>
                              <tr>
                                <td colspan="3" align="center">&nbsp;</td>
                                </tr>
                              <tr>
                                <td colspan="3" align="center"><input type="submit" name="button" id="button" value="Enviar" onclick="enviar_formulario(); return false;" class="texto_contenido"/>
&nbsp;&nbsp;&nbsp;
<input type="submit" name="limpiar" id="limpiar" value="Limpiar formulario" onclick="limpiar_formulario(); return false;" class="texto_contenido"/></td>
                              </tr>
                            </table>
				
	 	 
	</div>
	
	<div id="footer">            
        <div id="contenido_footer"><h3>Contacto: multiemergenciassas@gmail.com<br>Whatsapp: (+57) 316 629 27 91 ; (+57) 320 408 03 85<br>Bucaramanga, Colombia<br> <br>Software por: quimerapps.com</h3></div> 
		<div id="footer-der"></div>  
        </div>	
</form>
	
</body>
</html>
<script>

function enviar_formulario(){
	
	mensaje = "";
	
	if(document.getElementById('nombres').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar nombre completo.";
	}
	
	
	if(document.getElementById('correo').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
	}
	
	if ((document.form1.correo.value!="") && (!es_correo(document.form1.correo.value)))
	{
		mensaje = mensaje + "\n* El correo electrónico no tiene una estructura válida.";
		
	}
	
	if(document.getElementById('telefono').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar el teléfono ó celular.";
	}
	
	if ((document.form1.telefono.value!="") && (!es_numero(document.form1.telefono.value)))
	{
		mensaje = mensaje + "\n* El teléfono ó celular contiene caractéres no válidos (Debe ser numérico).";
		
	}
	
	if(document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
	}
	
	
	
	
	
	
	
	
	
	if(mensaje!=""){
				alert("Por favor revise lo siguiente:\n\n "+mensaje);
	
	}else{
		
		
			document.getElementById('bandera').value = "1";
			document.form1.submit();	
	}
	
}


function limpiar_formulario(){
	

	document.getElementById('nombres').value = "";
	document.getElementById('correo').value = "";
	document.getElementById('telefono').value = "";
	document.getElementById('txtContenido').value = "";
	alert('Formulario limpiado');
	document.form1.nombres.focus();
	

	
}

function es_correo(direccion) 
{
	var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	if (filter.test(direccion)) return true;
	else return false;
}


function es_numero(cadena)
{
	var longit = cadena.length;
	
	for(k=0;k<longit;k++)
	{
		var car = cadena.charAt(k);
		if ((car!='1') && (car!='2') && (car!='3') && (car!='4') && (car!='5') && (car!='6') && (car!='7') && (car!='8') && (car!='9') && (car!='0'))
			return false;
	}
	if (longit>0) return true;
	else return false;
}




</script>