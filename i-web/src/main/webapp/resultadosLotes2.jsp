
<%@page import="beans.Certificado"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>
<%@page import="beans.Administrador"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
String  tipoCertificado = request.getParameter("tc");
String  documento = request.getParameter("d");
String  nombre = request.getParameter("n");
String  fechaI = request.getParameter("fi");
String  fechaF = request.getParameter("ff");


//out.println(tipoCertificado+"*"+ documento+"*"+ nombre+"*"+ fechaI+"*"+ fechaF);
try{  
List<Certificado> certificados = bAdministrarPublicaciones.getCertificados(tipoCertificado, documento, nombre, fechaI, fechaF,null,null);

	if (certificados!=null && certificados.size() > 0) {

out.println("<h3>Bienvenido(a) <b>"+certificados.get(0).getNombre()+"!</b></h3>");
%>
<br/>
Listado de certificados disponibles. También lo invitamos a acceder a nuestras redes sociales, descargar fotos, visualizar videos, conocer nuestras ofertas, entre otros.
<ul class="et-social-icons">

						<li class="et-social-icon et-social-facebook"><a
							href="http://www.facebook.com/Isolucionessas" class="icon"
							target="_blank"> <span>Facebook</span>
						</a></li>
						<li class="et-social-icon et-social-youtube"><a
							href="https://www.youtube.com/channel/UChS1AGiOflOSFs1GaENI2AQ"
							class="icon" target="_blank"> <span>youtube</span>
						</a></li>
						

					</ul>

<br/>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#0089E1">
		<div align="right" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">CERTIFICADO EN</div>
		</td>
		
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">CLIENTE</div>
		</td>
		
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">FECHA</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="right" style="color:#FFFFFF">HORAS</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
	if(certificados!=null && certificados.size()>0){
			for (Certificado i : certificados) {
				j++;
				

				
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
	%>  
	<tr >  
		<td align="right" bgcolor="<%=color %>" style="width:5%"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>"><font color="black"><%=i.getTipoCertificado().toUpperCase() %></font></td>
		<td align="left" bgcolor="<%=color %>"><font color="black"><%if(i.getNombreCliente()!=null && !i.getNombreCliente().trim().equals("")){out.println(i.getNombreCliente().toUpperCase());}else{out.println("--");} %></font></td>
		<td align="left" bgcolor="<%=color %>" style="width:15%"><font color="black"><%=i.getFechaInicio()%></font></td>
	
		<td align="right" bgcolor="<%=color %>" style="width:5%"><font color="black"><%=i.getNumeroHoras()%></font></td>
		
		<td align="center" bgcolor="<%=color %>" style="width:20%"><%if(i.getFechaInicio().compareTo(formato.format(new java.util.Date()))<=0 && i.getFechaDisponibilidad().compareTo(formato.format(new java.util.Date()))>=0 ){   %><a href="imprimir_certificado.jsp?rf=<%=Math.random()%>&i=<%=i.getId() %>&j=<%=Math.random()%>" target="_blank"><font color="blue">Certificado</font></a> <%}else{ %><font color="red">(Certificado no disponible)</font><%} %> <% if(i.getFechaDisponibilidad().compareTo(formato.format(new java.util.Date()))>=0){ %>| <a href="#" onclick="window.open('/i-web/consultarDocumentos.jsp?id=<%=i.getIdTipoCertificado() %>', 'memorias', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=600, height=350'); return false;" style="text-decoration:none"><font color="blue">Memorias</font></a><%} %></td>
		
		

		
		
		
		
	</tr>
	<%
		}}
	%>
</table>

<%
	} else {
%>
<center>
<br/>
<h2><span style="font-weight:bold">
No existe información asociada al documento suministrado </span></h2>
</center>
<%
	}
}catch(Exception e){
	//out.println(e.toString());
}
%>



