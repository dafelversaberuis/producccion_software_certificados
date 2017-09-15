
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


String n= request.getParameter("n");
try{
	if (n!=null && !n.equals("") && Integer.parseInt(n)>0) {
%>

<input type="button" value=" Guardar " onclick="validarLote();"/>
<br/><br/><br/>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">TIPO DOC.</div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">DOCUMENTO<span style="color:red; font-size:20px">*</span></div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">NOMBRE COMPLETO<span style="color:red; font-size:20px">*</span></div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">CORREO</div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">EMPRESA PROVIENE</div>
		</td>
		
	</tr>
	<%
		
			for (int i=1; i<= Integer.parseInt(n); i++) {
			
	%>
	<tr class="campos">
		<td align="right" bgcolor="#EEEEEE"><font color="black"><%=i %></font></td>
		<td align="center" bgcolor="#EEEEEE"><font color="black"><select name="tipo<%=i %>" id="tipo<%=i %>" >
    		<option value="C.C." selected>CC</option>
    		<option value="C.E.">CE</option>
            <option value="T.I.">TI</option>
    
    </select></font></td>
		<td align="center" bgcolor="#EEEEEE"><font color="black"><input id="documento<%=i %>" name="documento<%=i %>" type="text" value=""/></font></td>
		<td align="center" bgcolor="#EEEEEE"><font color="black"><input id="nombre<%=i %>" name="nombre<%=i %>" type="text" value="" style="width:350px"/></font></td>
		<td align="center" bgcolor="#EEEEEE"><font color="black"><input id="ciudad<%=i %>" name="ciudad<%=i %>" type="text" value=""/></font></td>
		<td align="center" bgcolor="#EEEEEE"><font color="black"><input id="empresa<%=i %>" name="empresa<%=i %>" type="text" value=""/></font></td>
		
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Seleccione el número de personas que recibe el certificado
<%
	}
	
}catch(Exception e){
	%>
	Seleccione el número de personas que recibe el certificado
	<% 
}
%>



