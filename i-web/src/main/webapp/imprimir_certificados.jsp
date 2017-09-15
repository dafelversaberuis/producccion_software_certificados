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

		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		String tipoCertificado = request.getParameter("tc");
		String documento = request.getParameter("d");
		String nombre = request.getParameter("n");
		String fechaI = request.getParameter("fi");
		String fechaF = request.getParameter("ff");
		String  cliente = request.getParameter("cli");

		String meses[] = { " ", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

		DecimalFormatSymbols simbolo = new DecimalFormatSymbols();
		simbolo.setDecimalSeparator(',');
		simbolo.setGroupingSeparator('.');

		DecimalFormat formateador = new DecimalFormat("###,###.##", simbolo);
		String reporte = new String();
		reporte = "variosCertificados.jasper";

		String id = request.getParameter("i");
		if (id != null && !id.equals("")) {

			//Ruta donde se encuentra la plantilla que diseña el admin del IPRED
			String ruta_servidor_plantilla = request.getRealPath("/reportes/");

			//
			String logo = request.getRealPath("/imagenes/");

			Map pars = new HashMap();
			//pars.put("pLogo", logo);
			pars.put("pRuta", logo);
			pars.put("SUBREPORT_DIR", ruta_servidor_plantilla + "/");

			List<Certificado> certificados = bAdministrarPublicaciones.getCertificados(tipoCertificado, documento, nombre, fechaI, fechaF,null,cliente);
			List<Certificado> certificados2 = new ArrayList<Certificado>();
			if (certificados != null && certificados.size() > 0) {

				for (Certificado certificado : certificados) {

					if (certificado.getFechaDisponibilidad().compareTo(formato.format(new java.util.Date())) >= 0) {

						String[] fechaInicio = certificado.getFechaInicio().split("-");
					
						String[] fechaMax = certificado.getFechaDisponibilidad().split("-");

						certificado.setNombre(certificado.getNombre());
						
						certificado.setTipoCertificado( certificado.getFechaFin().trim()+" "+certificado.getTipoCertificado().trim());
							
						
						if(certificado.getTipoDocumento().equals("C.E.") || certificado.getTipoDocumento().equals("T.I.")){  
							certificado.setTipoDocumento("Identificado(a) con "+certificado.getTipoDocumento() + " " + certificado.getDocumento());
						}else{
							certificado.setTipoDocumento("Identificado(a) con "+certificado.getTipoDocumento() + " " + formateador.format(certificado.getDocumento()));
						}
						
						
						String con = ""+certificado.getConsecutivoCompleto();
						
						
						List<String> cuales = new ArrayList<String>();
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
						
						
						certificado.setNumeroLogos(""+numeroLogos);
						
						
						certificado.setFirma1(logo+"/firma1.png");
						certificado.setFirma2(logo+"/firma2.png");
						
						if(certificado.getPoseeCapacitador()!=null && certificado.getPoseeCapacitador().equals("S")){
							certificado.setPoseeCapacitador("S");
							
						}else{
							
							certificado.setPoseeCapacitador("N");
						}
						
						

						int cuenta=0;
						if(numeroLogos>0){
							
							for(String p: cuales){
								cuenta++;
								if(cuenta==1){
									certificado.setLogoCliente(logo+"/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg");
									
									
								}else if(cuenta==2){
									certificado.setLogoCliente2(logo+"/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg");
									
								}else{
									
									certificado.setLogoCliente3(logo+"/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg");
								}
								
								
								
							}
							
						}
						
						
						
						if(certificado.getEmpresaProviene()!=null && !certificado.getEmpresaProviene().trim().equals("")){
				
							certificado.setEmpresaProviene("("+certificado.getEmpresaProviene().trim().toUpperCase()+")");
					
						}else{
					
							certificado.setEmpresaProviene("");
						}
						
						
						
						
						/*
						String con = ""+certificado.getId();
						if(certificado.getId()<=1000){
							
							con = "RCA/0000"+certificado.getId();
						}else if(certificado.getId()<=10000){
							
							con = "RCA/000"+certificado.getId();
						}else if(certificado.getId()<=100000){
							con = "RCA/00"+certificado.getId();
							
						}else if(certificado.getId()<=1000000){
							con = "RCA/0"+certificado.getId();
							
						}
						*/
						
						
						
					
						
						

						if (certificado.getCiudadDepartamentoCurso()!=null && !certificado.getCiudadDepartamentoCurso().trim().equals("")) {
									certificado.setFechaFin(certificado.getCiudadDepartamentoCurso()+", "+fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0]);
						} else {
							certificado.setFechaFin(fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0]);

						}

						certificado.setFechaDisponibilidad("Intensidad "+certificado.getNumeroHoras()+" horas");

						
						
						certificado.setCiudadDocumento(con);
						
						
					
						
						
						certificados2.add(certificado);

					}

				}

				if (certificados2 != null && certificados2.size() > 0) {

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

					byte[] bytes = JasperRunManager.runReportToPdf(ruta_servidor_plantilla + "/" + reporte, pars, new JRBeanCollectionDataSource(certificados2));

					/*Indicamos que la respuesta va a ser en formato PDF*/

					response.setContentType("application/pdf");
					response.setContentLength(bytes.length);
					ServletOutputStream ouputStream = response.getOutputStream();
					ouputStream.write(bytes, 0, bytes.length);

					/*Limpiamos y cerramos flujos de salida*/

					ouputStream.flush();
					ouputStream.close();

				} else {

					out.println("NO EXISTEN CERTIFICADOS VIGENTES...");

				}

			} else {

				out.println("NO EXISTEN CERTIFICADOS..");
			}

		} else {

			out.println("NO SE PUEDE MOSTRAR LOS CERTIFICADOS.");
		}

	} catch (Exception e) {
		out.println(e.toString());
	}
%>