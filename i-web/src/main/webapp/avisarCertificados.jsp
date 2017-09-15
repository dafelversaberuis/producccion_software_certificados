<%@page import="beans.Certificado"%>
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
int sw =0;
try{
	

	
	SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
	String tipoCertificado = request.getParameter("tc");
	String documento = request.getParameter("d");
	String nombre = request.getParameter("n");
	String fechaI = request.getParameter("fi");
	String fechaF = request.getParameter("ff");
	String  cliente = request.getParameter("cli");
	
	List<String> correos = new ArrayList<String>();
	
	List<Certificado> certificados = bAdministrarPublicaciones.getCertificados(tipoCertificado, documento, nombre, fechaI, fechaF,null,cliente);
	if (certificados != null && certificados.size() > 0) {

		for (Certificado certificado : certificados) {

			if (certificado.getFechaDisponibilidad().compareTo(formato.format(new java.util.Date())) >= 0) {
				
				if(certificado.getCiudadDocumento()!=null && !certificado.getCiudadDocumento().trim().equals("")){
					correos.add(certificado.getCiudadDocumento().trim());
				}
				
			}
			
		}
		
	}
	
	List<String> listaCorreos = new ArrayList<String>();
	if (correos != null && correos.size() > 0) {
		for (String h : correos) {
			if (listaCorreos.size() < 100 && !(listaCorreos.contains(h.trim()))) {
				
				boolean ok = bAdministrarPublicaciones.validateEmail(h.trim());
				
				if(ok){
				listaCorreos.add(h.trim());
				}
			}
		}
	}

		
		if(listaCorreos!=null && listaCorreos.size()>0){
			
			sw=1;
			
			bAdministrarPublicaciones.enviarCorreoMasivo(listaCorreos);
		}
		
		

	
	
}catch(Exception e){
	
}
	


%>

<input name="hdnEnvio" id="hdnEnvio" type="hidden"
	value="<%=sw %>" />


