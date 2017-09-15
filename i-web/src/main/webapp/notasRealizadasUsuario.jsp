<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>
<jsp:useBean id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%
	String us = request.getParameter("us");
	String tu = "2";
	

	 List<Publicacion> publicaciones = bAdministrarPublicaciones.getNotasPublicas(); for(Publicacion l: publicaciones){ 
    %> <br/><%= "<span style='color:#0089E1; font-weight:bold'>"+l.getTituloPublicacion()+"</span>"%><%if((l.getDireccionFotoPublicacion()!=null && !l.getDireccionFotoPublicacion().trim().equals("null") && !l.getDireccionFotoPublicacion().trim().equals(""))){ %><br><br><div id="foto_noticia"><img id="imagen_noticia" src="images/publicaciones/<%=l.getDireccionFotoPublicacion() %>"  width="317" height="187"></div><%} %><br><br><%= bAdministrarPublicaciones.getTextoCortado(l.getContenidoPublicacion())%><br><%= "<h6><a href='#'  onclick='eliminarPublicacion("+l.getIdPublicacion()+"); return false;'>Eliminar</a></h6>" %><%} %>
    
           




