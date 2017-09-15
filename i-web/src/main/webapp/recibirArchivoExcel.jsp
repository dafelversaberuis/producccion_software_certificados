<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.io.*,org.apache.commons.fileupload.*,java.text.SimpleDateFormat"
	errorPage=""%>  
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	
<%@page import="beans.Parametro"%>  
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%

	SimpleDateFormat hora = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");

	Parametro parametro = new Parametro();
	String[] parametros2 = parametro.getarametros();
	String directorio_ruta = application.getRealPath("imagenes")+"/archivosTemas/";

	String ciudad_curso =  request.getParameter("ciudad_curso"); //fecha_disponibilidad
	String fecha_maxima =  request.getParameter("fecha_maxima"); //fecha_disponibilidad
	String etiqueta_capacitacion =  request.getParameter("etiqueta_capacitacion");
	String fecha_inicio =  request.getParameter("fecha_inicio"); // fecha inicio
	String horas_certificadas =  request.getParameter("horas_certificadas"); //horas
	String certificado =  request.getParameter("certificado"); //tipo certificado
	String cliente =  request.getParameter("cliente"); //cliente
	
	
	String numero_firmas =  request.getParameter("numero_firmas"); //
	String nombre_capacitador =  request.getParameter("nombre_capacitador"); //
	String cargo_capacitador =  request.getParameter("cargo_capacitador"); //
	String empresa_capacitador =  request.getParameter("empresa_capacitador"); //
	
	if(numero_firmas!=null && numero_firmas.equals("N")){
		 nombre_capacitador =   "";
		 cargo_capacitador =    "";
		 empresa_capacitador =  "";
	}


	int guardo = 0;
	// Si se ha enviado correctamente el formulario con la imagens se carga la imagen al servidor	
	int l = 0;
	int campo = 1;
	int tamano_maximo_archivo = 1024*30;
	String solonombrearchivo = new String();
	// verifica si tenemos un request de file upload
	boolean isMultipart = FileUpload.isMultipartContent(request);
	if (isMultipart == true) { //valida q si haya un archivo para subir
		// Crea a nuevo manejador de file upload
		DiskFileUpload upload = new DiskFileUpload();
		// Analiza el request   
		List items = upload.parseRequest(request);
		// Crea un iterador para procesar los items
		Iterator iter = items.iterator();
		// Procesa los items subidos
		String[] parametros = new String[50];
		while (iter.hasNext()) {
			FileItem item2 = (FileItem) iter.next();

			if (item2.isFormField()) {
				parametros[l] = item2.getString();
				l++;
			}

			else {
				String fieldName = item2.getFieldName();
				String fileName = item2.getName();
				String contentType = item2.getContentType();
				boolean isInMemory = item2.isInMemory();
				long sizeInBytes = (item2.getSize() / 1024);
				int punto = fileName.lastIndexOf('.');
				String ext = fileName.substring(punto + 1);
				ext = ext.toUpperCase(); //solo vamos aceptar minusculas
				if (ext.equals("CSV")) {//valida q extensiones puedo subir
					int slash = fileName.lastIndexOf('/');
					int backslash = fileName.lastIndexOf('\\');
					int finpath = backslash;
					if (slash > backslash) {
						finpath = slash;
					}

					solonombrearchivo = fileName.substring(finpath + 1);
					String nombre = solonombrearchivo;
					
					//aqui colocamos el maximo nombre
					
					
					
					
					int puntos = nombre.indexOf('.');
					nombre = nombre.substring(0, puntos);
					nombre = nombre.toUpperCase();
					File dir = new File(directorio_ruta);
					if (dir.exists()) {
						String[] nombres = dir.list();
						for (int i = 0; i < nombres.length; i++) {
							String nombredir = nombres[i];
							int pto = nombredir.indexOf('.');
							nombredir = nombredir.substring(0, pto);
							nombredir = nombredir.toUpperCase();
							if (1==2) {
%><script language="javascript">window.alert("Existe una archivo con el mismo nombre. Cámbieselo o busque otro");</script>


<%
	//i=nombres.length;
								break;
							}//fin if de comparacion para q no sobrescriba
							else {
								if (i == nombres.length - 1) {
									if (sizeInBytes <= tamano_maximo_archivo) {
										
									String fecha = hora.format(new java.util.Date());
										
										File uploadedFile = new File(directorio_ruta + "capacitados_"+fecha+"."+ext.toLowerCase());
										
										//item2.
										  
										item2.write(uploadedFile);
										
							
										
										
										guardo = 1;     
										 
										String sarta = bAdministrarPublicaciones.guardarCertificadoExcel(uploadedFile, ciudad_curso, fecha_maxima, etiqueta_capacitacion, fecha_inicio, horas_certificadas, certificado, cliente, numero_firmas, nombre_capacitador, cargo_capacitador, empresa_capacitador);
										
										int ultima =1;
if(sarta!=null && sarta.equals("ok2")){

%>
<script>alert('Archivo EXCEL cargado con éxito, se cerrará la ventana. Si esto no sucede haga clic en el botón cerrar'); 
try{
	window.opener.document.form1.submit();
	
}catch(e) {
	//alert('La ventana desde la que se abrió ésta, fue cerrada. La foto se cargó, pero para visualizarla abra la ventana repositorio de fotos nuevamente');
}
window.close();

</script>
<%
}else{
	%>
	<script language="javascript">window.alert("NO SE CARGÓ.\n\n-Revise si todos los datos requeridos (*) están diligenciados\n-Revise que los documentos no posean comas ni puntos\n-Revise que los tipos de documento sean CC ó CE ó TI "); window.close();</script>
	
	<%
}

	} else {
%><script language="javascript">window.alert("Archivo excede el tamaño máximo de: "+ <%=tamano_maximo_archivo%> +"KB");</script>
<%
	}
								}//fin if q va dentro del else copia solo cuando llega al ultivo archivo
							}//fin else de comparacion para q no sobrescriba
						}//fin for nombres.length
					}//fin if dir
				}//fin if ext
				else {
%><script language="javascript">window.alert("Solo se pueden cargar archivos excel con extensión csv"); window.close();</script>

<%
	}
			}//fin else
		}//fin while
	}//fin if
%>
<html>
<head>
<title>ISOLUCIONES S.A.S</title>
<meta name="Description"
	content="Isoluciones, Innovación en Gestión Empresarial">
   

<? header("Cache-Control: no-cache, must-revalidate");?>
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="pragma" content="no-cache" />
<meta name="resource-type" content="document" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<style type="text/css">
<!--
body {
	background-image: url();
background-color: #AFDBF6;
}
-->
</style>
<style type="text/css">
<!--
.Estilo5 {
	font-size: 12px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}

.Estilo6 {
	font-size: 12px;
	font-weight: bold;
}
-->
</style>

</head>
<body>
<p />
<p />
<p />
<p />
<form name="form1">
<%
	if (guardo == 1) {
%>
<center><strong>Cierre la ventana para continuar</strong><br />
<br />
<input class="searchbutton" name="btnCerrar" id="btnCerrar"
	type="button" style="cursor: hand" value="Cerrar"
	onclick="window.close(); return false;" /></center>
<%
	} else {
%>
<center><strong>Haga clic en volver para agregar otro
archivo</strong><br />
<br />
<input class="searchbutton" name="btnVolver" id="btnVolver"
	type="button" style="cursor: hand" value="Volver"
	onclick="document.form1.action='subirArchivoTema.jsp'; document.form1.submit(); return false;" /></center>
<%
	}
%>
</form>
</body>
</html>