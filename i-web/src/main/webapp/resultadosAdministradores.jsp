
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


List<Administrador> administradores = bAdministrarPublicaciones.getAdministradores();

	if (administradores.size() > 0) {  
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">ADMINISTRADOR</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">DOCUMENTO</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">CORREO</div>
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
			for (Administrador i : administradores) {
				j++;
	%>
	<tr >
		<td align="center" bgcolor="#EEEEEE"><font color="black"><%=j%></font></td>
		<td align="center" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i.getPrimerNombre() + " " + i.getSegundoNombre() + " " + i.getPrimerApellido() + " "+ i.getSegundoApellido() %></font></div>
		</td>
		<td align="center" bgcolor="#EEEEEE" ><font color="black"><%=i.getDocumento() %></font></td>
		<td align="left" bgcolor="#EEEEEE" ><font color="black"><%=i.getCorreo() %></font></td>
		<td align="center" bgcolor="#EEEEEE" ><a href="#" onclick="resetearClaveAdmin('<%=i.getCorreo() %>','<%=i.getIdAdministrador() %>'); return false;">Resetear clave</a></td>
		<td align="center" bgcolor="#EEEEEE"><a href="#" onclick="cargarEliminarAdministrador('<%=i.getIdAdministrador() %>'); return false;">Eliminar</a></td>
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen administardores creados en el sistema
<%
	}
%>



