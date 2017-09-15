
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%
	String titulo = request.getParameter("pt");
	String contenido = request.getParameter("pc");
	String dirigido = request.getParameter("pd");
	String egresadoEscogido = request.getParameter("pe");
	String foto = request.getParameter("pf");
	String us = request.getParameter("us");
	String tu  = request.getParameter("tu");

	int actualizo = 0;
	
	if(Integer.parseInt(tu)==1){
		actualizo = bAdministrarPublicaciones.guardarPublicacion(1,0,Integer.parseInt(us), Integer.parseInt(dirigido), titulo, contenido, foto, egresadoEscogido);
		
	}else{
		
		
		
		actualizo = bAdministrarPublicaciones.guardarPublicacion(2,Integer.parseInt(us),0, Integer.parseInt(dirigido), titulo, contenido, foto, egresadoEscogido);		
	}
%>

<input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion" type="hidden"
	value="<%=actualizo%>" />


