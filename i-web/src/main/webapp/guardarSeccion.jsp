
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false" pageEncoding="UTF-8"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String titulo = request.getParameter("pt");
	String contenido = request.getParameter("pc");
	String dirigido = request.getParameter("pd");
	
	String foto = request.getParameter("pf");


out.println(contenido);
	int actualizo = 0;
	

		actualizo = bAdministrarPublicaciones.guardarSeccion(titulo, contenido, foto, dirigido);
		
	
%>

<input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion" type="hidden"
	value="<%=actualizo%>" />


