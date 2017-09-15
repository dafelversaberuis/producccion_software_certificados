
<%@page import="beans.Certificado"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat, org.apache.commons.lang3.StringUtils" errorPage=""
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

String  consecutivo = request.getParameter("con");
String  cliente = request.getParameter("cli");



//out.println(tipoCertificado+"*"+ documento+"*"+ nombre+"*"+ fechaI+"*"+ fechaF);
try{
List<Certificado> certificados = bAdministrarPublicaciones.getCertificados(tipoCertificado, documento, nombre, fechaI, fechaF,consecutivo,cliente);

	if (certificados!=null && certificados.size() > 0) { 
%>
<a href="imprimir_certificados.jsp?i=1&tc=<%=tipoCertificado %>&d=<%=documento %>&n=<%=nombre %>&cli=<%=cliente%>&fi=<%=fechaI %>&ff=<%= fechaF%>" target="_blank">(Imprimir certificados vigentes)</a> | <a href="#" onclick="enviarMasivo('<%="tc="+tipoCertificado +"&d="+documento+"&n="+nombre+"&cli="+cliente+"&fi="+fechaI +"&ff="+fechaF %>'); return false;">(Enviar notificaciones de correo)</a>
<br/><br/>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>  
		<td bgcolor="#0089E1">  
		<div align="center" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">CERTIFICADO</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">CLIENTE</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">DOCUMENTO</div>
		</td>
		
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">NOMBRE</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">CORREO</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">EMPRESA PROVIENE</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">NRO.</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="right" style="color:#FFFFFF">H</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF"></div>
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
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><%=StringUtils.abbreviate(i.getTipoCertificado(), 20)+".."%> </font></td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=StringUtils.abbreviate(i.getNombreCliente(), 20)+".."%></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><%=i.getDocumento() %></font></td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=StringUtils.abbreviate(i.getNombre(), 20)+".."%></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><% if(i.getCiudadDocumento()!=null && !i.getCiudadDocumento().trim().equals("")){out.println(i.getCiudadDocumento().trim());}else{out.println("--");}%></font></td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><% if(i.getEmpresaProviene()!=null && !i.getEmpresaProviene().trim().equals("")){out.println(StringUtils.abbreviate(i.getEmpresaProviene(), 20)+"..");}else{out.println("--");}%></font></td>
	
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><% if(i.getConsecutivoCompleto()!=null){out.println(i.getConsecutivoCompleto());}%></font></td>
	
		<td align="right" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><%=i.getNumeroHoras()%></font></td>
		
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="#" onclick="cargarEliminarCertificado('<%=i.getId() %>'); return false;">Eliminar</a></td>
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><%if(i.getFechaDisponibilidad().compareTo(formato.format(new java.util.Date()))>=0 ){   %><a href="imprimir_certificado.jsp?rf=<%=Math.random()%>&i=<%=i.getId() %>&j=<%=Math.random()%>" target="_blank">Certificado</a><%}else{ %><font color="red">(Venció el <%=i.getFechaDisponibilidad() %>)</font><%} %></td>
		
	</tr>
	<%
		}}
	%>
</table>

<%
	} else {
%>
Aún no existen capacitados registrados en el sistema
<%
	}
}catch(Exception e){
	
}
%>



