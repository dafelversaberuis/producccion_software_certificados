<%@page import="beans.Certificado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager.*"%>
<%@ page
	import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>
<%@ page import="java.lang.*,java.util.*,java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.lowagie.text.Image"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%
	try {

		String meses[] = { " ", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

		DecimalFormatSymbols simbolo = new DecimalFormatSymbols();
		simbolo.setDecimalSeparator(',');
		simbolo.setGroupingSeparator('.');

		DecimalFormat formateador = new DecimalFormat("###,###.##", simbolo);
		String reporte = new String();
		reporte = "certificado.jasper";

		String id = request.getParameter("i");
		if (id != null && !id.equals("")) {

			//Ruta donde se encuentra la plantilla que diseña el admin del IPRED
			String ruta_servidor_plantilla = request.getRealPath("/reportes/");

			//
			String logo = request.getRealPath("/imagenes/");

			Map pars = new HashMap();
			
			
			List<String> cuales = new ArrayList<String>();
			Certificado certificado = bAdministrarPublicaciones.getCertificado(Integer.parseInt(id));
			if (certificado != null) {

				String[] fechaInicio = certificado.getFechaInicio().split("-");
				
				String[] fechaMax = certificado.getFechaDisponibilidad().split("-");

				
				int numeroLogos = 0;
				if(certificado.getPoseeLogo1()!=null && certificado.getPoseeLogo1().equals("S")){
					numeroLogos++;
					cuales.add("1");
				}
				
				if(certificado.getPoseeLogo2()!=null && certificado.getPoseeLogo2().equals("S")){
					numeroLogos++;
					cuales.add("2");
				}
				
				if(certificado.getPoseeLogo3()!=null && certificado.getPoseeLogo3().equals("S")){
					numeroLogos++;
					cuales.add("3");
				}
				
				
				
				pars.put("pNumeroLogos", ""+numeroLogos);
				
				pars.put("pRuta", ""+logo);
				
				
				
				
				int cuenta=0;
				if(numeroLogos>0){
					
					for(String p: cuales){
						cuenta++;
						if(cuenta==1){
							
							pars.put("pLogo", logo+"/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg");
							
						}else{
							
							pars.put("pLogo"+cuenta, logo+"/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg");
							
						}
						
						
						
					}
					
				}
				
				
				
				
				
				pars.put("pNombre", certificado.getNombre());
				
				
				String ciudad = "";
				
				if(certificado.getCiudadDocumento()!=null && !certificado.getCiudadDocumento().trim().equals("")){
					ciudad = " de "+certificado.getCiudadDocumento();
				}
				
				if(certificado.getTipoDocumento().equals("C.E.") || certificado.getTipoDocumento().equals("T.I.")){
					
					pars.put("pDocumento", "Identificado(a) con "+certificado.getTipoDocumento() + " No. " + certificado.getDocumento());
				}else{
					pars.put("pDocumento", "Identificado(a) con "+certificado.getTipoDocumento() + " No. " + formateador.format(certificado.getDocumento()));
				}
				
				String con = ""+certificado.getConsecutivoCompleto();
				
				if(certificado.getEmpresaProviene()!=null && !certificado.getEmpresaProviene().trim().equals("")){
				
					pars.put("pEmpresa", "("+certificado.getEmpresaProviene().trim().toUpperCase()+")");
					
				}else{
					pars.put("pEmpresa", "");
					
				}
				
				
			
			
				/*if(certificado.getId()<=1000){
					
					con = "RCA/0000"+certificado.getId();
				}else if(certificado.getId()<=10000){
					
					con = "RCA/000"+certificado.getId();
				}else if(certificado.getId()<=100000){
					con = "RCA/00"+certificado.getId();
					
				}else if(certificado.getId()<=1000000){
					con = "RCA/0"+certificado.getId();
					
				}*/
			
				
				
				pars.put("pCurso", certificado.getFechaFin().trim()+" "+certificado.getTipoCertificado().trim());
				
				pars.put("pHoras", "Intensidad "+certificado.getNumeroHoras()+" horas");
				
				pars.put("pFechas", con);
				
				pars.put("pId", certificado.getIdCliente());
				
				if (certificado.getCiudadDepartamentoCurso()!=null && !certificado.getCiudadDepartamentoCurso().trim().equals("")) {
					
					pars.put("pLeyenda", certificado.getCiudadDepartamentoCurso()+", "+fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0]);
						
					
				}else{
					
					pars.put("pLeyenda", fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0]);
					
				}
				
/*
				if (certificado.getFechaInicio().equals(certificado.getFechaFin())) {
					pars.put("pFechas", "Llevado a cabo el " + fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0] + ", con una intensidad de " + certificado.getNumeroHoras() + " horas, " + certificado.getCiudadDepartamentoCurso() + ", " + meses[Integer.parseInt(fechaFin[1])] + " " + fechaFin[2] + " de " + fechaFin[0]+", Consecutivo:"+con);
				} else {
					pars.put("pFechas", "Llevado a cabo del " + fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0] + " al " + fechaFin[2] + " de " + meses[Integer.parseInt(fechaFin[1])] + " de " + fechaFin[0] + ", con una intensidad de " + certificado.getNumeroHoras() + " horas, " + certificado.getCiudadDepartamentoCurso() + ", " + meses[Integer.parseInt(fechaFin[1])] + " " + fechaFin[2] + " de " + fechaFin[0]+", Consecutivo:"+con);

				}

				pars.put("pLeyenda", "Fecha sugerida de renovación de certificado y credencial: para reentrenamiento en " + certificado.getTipoCertificado() + ", " + meses[Integer.parseInt(fechaMax[1])] + " de " + fechaMax[0]);
				*/
				//

				//Cuando se quiere usar un listado
				// A la linea de bytes el ultimo parametro se cambia por datasource
				// y se descomentarea la siguiente linea y se le pasa el listado armado un List<>
				//JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(listado);

				//Si se quiere usar una conexion se pasa como parmetro un objeto de conexion this.con ó
				//Connection conexion algo asi
				// y el ultimo parametro se de bytes se cambia por la conexion

				//Si solo son parametros, sin conexion ni lista solo como ultimo parametro en la
				//linea de bytes lo siguiente: new JREmptyDataSource()

				byte[] bytes = JasperRunManager.runReportToPdf(ruta_servidor_plantilla + "/" + reporte, pars, new JREmptyDataSource());

				/*Indicamos que la respuesta va a ser en formato PDF*/

				response.setContentType("application/pdf");
				response.setContentLength(bytes.length);
				ServletOutputStream ouputStream = response.getOutputStream();
				ouputStream.write(bytes, 0, bytes.length);

				/*Limpiamos y cerramos flujos de salida*/

				ouputStream.flush();
				ouputStream.close();

			} else {

				out.println("NO SE PUEDE MOSTRAR EL CERTIFICADO");
			}

		} else {

			out.println("NO SE PUEDE MOSTRAR EL CERTIFICADO");
		}

	} catch (Exception e) {
		out.println(e.toString());
	}
%>