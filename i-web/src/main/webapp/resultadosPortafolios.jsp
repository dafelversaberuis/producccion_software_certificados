
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>
<%@page import="beans.Portafolio"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%


List<Portafolio> portafolios = bAdministrarPublicaciones.getPortafolios();

	if (portafolios.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#0089E1"  >
		<div align="center" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">Servicio ofrecido</div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF">Contenido</div>
		</td>
		<td bgcolor="#0089E1" >
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>  
	<%
		int j = 0;
			for (Portafolio i : portafolios) {
				j++;
	%>
	<tr class="campos">
		<td align="center"  bgcolor="#EEEEEE"><font color="black"><%=j%></font></td>
		<td align="center"  bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i.getTitulo() %></font></div>
		</td>
		<td align="left"  bgcolor="#EEEEEE"><font color="black"><%=i.getContenido() %></font></td>
		<td align="center"  bgcolor="#EEEEEE"><a href="#" onclick="cargarEliminarPortafolio('<%=i.getIdPortafolio() %>'); return false;">Eliminar</a></td>
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen servicios creados
<%
	}
%>



