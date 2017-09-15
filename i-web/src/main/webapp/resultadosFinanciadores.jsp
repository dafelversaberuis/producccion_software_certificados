
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


List<Object[]> cursos = bAdministrarPublicaciones.getFinanciadores();

	if (cursos!=null && cursos.size() > 0) {  
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">CLIENTE</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">LOGO 1</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">LOGO 2</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="left" style="color:#FFFFFF">LOGO 3</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		
	</tr>
	<%
		int j = 0;
			for (Object[] i : cursos) {
				j++;
				
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
	%>
	<tr >
		<td align="left" bgcolor="<%=color %>"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%=i[1] %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<%if(i[2].equals("S")){ %><a href="#" onclick="window.open('/i-web/verLogo.jsp?id=<%=i[0]%>&n=1', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Ver logo</a> | <a href="#" onclick="cargarEliminarLogoFinanciador2('<%=i[0]%>','1'); return false;">Eliminar</a><%  }else{%> <a href="#" onclick="window.open('/i-web/subirLogo.jsp?id=<%=i[0]%>&n=1', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar nuevo</a><% } %>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<%if(i[3].equals("S")){ %><a href="#" onclick="window.open('/i-web/verLogo.jsp?id=<%=i[0]%>&n=2', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Ver logo</a> | <a href="#" onclick="cargarEliminarLogoFinanciador2('<%=i[0]%>','2'); return false;">Eliminar</a><%  }else{%> <a href="#" onclick="window.open('/i-web/subirLogo.jsp?id=<%=i[0]%>&n=2', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar nuevo</a><% } %>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<%if(i[4].equals("S")){ %><a href="#" onclick="window.open('/i-web/verLogo.jsp?id=<%=i[0]%>&n=3', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Ver logo</a> | <a href="#" onclick="cargarEliminarLogoFinanciador2('<%=i[0]%>','3'); return false;">Eliminar</a><%  }else{%> <a href="#" onclick="window.open('/i-web/subirLogo.jsp?id=<%=i[0]%>&n=3', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar nuevo</a><% } %>
		</td>
		<td align="center" bgcolor="<%=color %>"><a href="#" onclick="cargarEliminarFinanciador('<%=i[0]%>'); return false;">Eliminar cliente</a></td>  
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen clientes creados en el sistema
<%
	}
%>



