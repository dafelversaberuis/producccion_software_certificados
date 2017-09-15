<%@page import="beans.Seccion"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false" pageEncoding="UTF-8"%>
<jsp:useBean id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String id = request.getParameter("id");
if(id==null){
	id = "0";
}
	  
List<Seccion> secciones = bAdministrarPublicaciones.getSecciones();

Seccion seccion = null;
    %>
    
    	<%if(!id.equals("0")){
    		
    		
    		seccion = bAdministrarPublicaciones.getSeccion(Integer.parseInt(id));
    		
    	}%>
    	
    
    	
           
<table border="0" width="100%" cellpadding="2">
<tr>
		<td><span class="Estilo3"><span class="Estilo4 Estilo8">*</span>
		Sección a editar:</span></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>  
		<td>
		<select name="sltDirigido" id="sltDirigido" class="searchfield" onchange="recargarSeccion()" style="width:300px">
		<%if(id.equals("0")){
			%>
			<option value="0" selected>-Seleccione-</option>
			
			<%}else{
				%>
				<option value="0">-Seleccione-</option>
				<%}%>
			
	
		
		<%
		int c=0;
		for(Seccion s: secciones){
		c++;
		
		if(id.equals(""+s.getSeccion())){
		%>
		
		<option value="<%=s.getSeccion()%>" selected> <%=s.getTitulo() %></option>
		
		<%			
			
		}else{
		
		%>
		
		
		<option value="<%=s.getSeccion()%>"><%=s.getTitulo() %></option>
		
		
		<%}} %>
		
		
		</select>		</td>
		<td width="8%"></td>
		<td colspan="2"><span id="detalleEgresado"></span></td>
		<td width="5%"><span id="detalleEgresado2"></span>
		    <input
			name="hdnEgresado" id="hdnEgresado" type="hidden"
			value="0" /></td>
		<td width="14%">&nbsp;</td>
	</tr>
	
	<%if(!id.equals("0")){ %>
	
	<tr>
		<td width="39%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span> Título de la sección:</span></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td><input name="txtTitulo" type="text" id="txtTitulo" style="width:300px"
			class="searchfield" value="<%= seccion.getTitulo()%>"/></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	 
	
	<tr>
		<td>&nbsp;</td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td><span class="Estilo3"><span class="Estilo3"><span class="Estilo4 Estilo8">*</span>
		</span>Contenido:</span></td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="6"><textarea name="txtContenido" rows="10" class="searchfield" id="txtContenido" style="width: 94%"><%= seccion.getContenido()%></textarea></td>
		</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="3">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3"> 
	<%if(seccion.getDireccionFoto()==null || seccion.getDireccionFoto().trim().equals("") || seccion.getDireccionFoto().trim().equals("null")){ %>
		<a href="#" onclick="buscarFoto(); return false;" style="text-decoration:none">Asociar una imagen (opcional)</a> 
		
		<%} %>
		
		</td>
		<td width="7%">
			</td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td align="left" colspan="6"><span id="detalleFoto1">
			<%if(seccion.getDireccionFoto()!=null && !seccion.getDireccionFoto().trim().equals("") && !seccion.getDireccionFoto().trim().equals("null")){ %>
		
		<img src='/i-web/images/publicaciones/<%=seccion.getDireccionFoto() %>' width='317' height='187' />
	
		<%} %>
		
		
		</span></td>
		
	</tr>
	<tr>
		<td align="left"><span id="detalleFoto2">
		
		<%if(seccion.getDireccionFoto()!=null && !seccion.getDireccionFoto().trim().equals("") && !seccion.getDireccionFoto().trim().equals("null")){ %>
		<a class='current' href='#' onclick='removerFoto(); return false;'>(Remover imagen)</a><br>
		
		<%} %>
		</span></td>
		<td colspan="5" align="left"><span id="detalleGuardar"></span></td>
		
	</tr>  
	<%} %>
	
	
</table> 

<%if(!id.equals("0")){ %>
 <input 
			name="btnAceptar" id="btnAceptar" type="button"
			style="cursor: hand" value=" Actualizar sección "
			onclick="guardarSeccion(); return false;" />
	    <input name="hdnFoto" id="hdnFoto" type="hidden"
	value="<%=seccion.getDireccionFoto() %>" />
	
	<%} %>
	<br/>
	   
			
			



