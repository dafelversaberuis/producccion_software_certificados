package beans;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperRunManager;

@WebServlet("/imprimir_certificado.jsp")
public class ImprimirCertificado extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2007916962156596630L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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

				// Ruta donde se encuentra la plantilla que diseña el admin del IPRED
				String ruta_servidor_plantilla = request.getRealPath("/reportes/");

				//
				String logo = request.getRealPath("/imagenes/");

				Map pars = new HashMap();

				List<String> cuales = new ArrayList<String>();
				Certificado certificado = new AdministrarPublicaciones().getCertificado(Integer.parseInt(id));
				if (certificado != null) {

					String[] fechaInicio = certificado.getFechaInicio().split("-");

					String[] fechaMax = certificado.getFechaDisponibilidad().split("-");

					int numeroLogos = 0;
					if (certificado.getPoseeLogo1() != null && certificado.getPoseeLogo1().equals("S")) {
						numeroLogos++;
						cuales.add("1");
					}

					if (certificado.getPoseeLogo2() != null && certificado.getPoseeLogo2().equals("S")) {
						numeroLogos++;
						cuales.add("2");
					}

					if (certificado.getPoseeLogo3() != null && certificado.getPoseeLogo3().equals("S")) {
						numeroLogos++;
						cuales.add("3");
					}

					if (certificado.getPoseeCapacitador() != null && certificado.getPoseeCapacitador().equals("S")) {
						pars.put("pCapacitador", "S");
						pars.put("pNombreCapacitador", certificado.getCapacitador());
						pars.put("pCargoCapacitador", certificado.getCargoCapacitador());
						pars.put("pEmpresaCapacitador", certificado.getEmpresaCapacitador());

					} else {

						pars.put("pCapacitador", "N");
					}

					pars.put("pNumeroLogos", "" + numeroLogos);

					pars.put("pRuta", "" + logo);

					pars.put("pFirma1", logo + "/firma1.png");
					pars.put("pFirma2", logo + "/firma2.png");

					int cuenta = 0;
					if (numeroLogos > 0) {

						for (String p : cuales) {
							cuenta++;

							if (p.equals("1")) {
								if (certificado.getArchivo() != null) {
									new AdministrarPublicaciones().guardarArchivoDisco(logo + "/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg", certificado.getArchivo());
								}

							} else if (p.equals("2")) {
								if (certificado.getArchivo2() != null) {
									new AdministrarPublicaciones().guardarArchivoDisco(logo + "/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg", certificado.getArchivo2());
								}

							} else if (p.equals("3")) {
								if (certificado.getArchivo3() != null) {
									new AdministrarPublicaciones().guardarArchivoDisco(logo + "/logosFinanciadores/logo_financiador_"+certificado.getIdCliente()+"-"+p+".jpg", certificado.getArchivo3());
								}
							}

							if (cuenta == 1) {

								pars.put("pLogo", logo + "/logosFinanciadores/logo_financiador_" + certificado.getIdCliente() + "-" + p + ".jpg");

							} else {

								pars.put("pLogo" + cuenta, logo + "/logosFinanciadores/logo_financiador_" + certificado.getIdCliente() + "-" + p + ".jpg");

							}

						}

					}

					pars.put("pNombre", certificado.getNombre());

					String ciudad = "";

					if (certificado.getCiudadDocumento() != null && !certificado.getCiudadDocumento().trim().equals("")) {
						ciudad = " de " + certificado.getCiudadDocumento();
					}

					if (certificado.getTipoDocumento().equals("C.E.") || certificado.getTipoDocumento().equals("T.I.")) {

						pars.put("pDocumento", "Identificado(a) con " + certificado.getTipoDocumento() + " No. " + certificado.getDocumento());
					} else {
						pars.put("pDocumento", "Identificado(a) con " + certificado.getTipoDocumento() + " No. " + formateador.format(certificado.getDocumento()));
					}

					String con = "" + certificado.getConsecutivoCompleto();

					if (certificado.getEmpresaProviene() != null && !certificado.getEmpresaProviene().trim().equals("")) {

						pars.put("pEmpresa", "(" + certificado.getEmpresaProviene().trim().toUpperCase() + ")");

					} else {
						pars.put("pEmpresa", "");

					}

					pars.put("pCurso", certificado.getFechaFin().trim() + " " + certificado.getTipoCertificado().trim());

					pars.put("pHoras", "Intensidad " + certificado.getNumeroHoras() + " horas");

					pars.put("pFechas", con);

					pars.put("pId", certificado.getIdCliente());

					if (certificado.getCiudadDepartamentoCurso() != null && !certificado.getCiudadDepartamentoCurso().trim().equals("")) {

						pars.put("pLeyenda", certificado.getCiudadDepartamentoCurso() + ", " + fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0]);

					} else {

						pars.put("pLeyenda", fechaInicio[2] + " de " + meses[Integer.parseInt(fechaInicio[1])] + " de " + fechaInicio[0]);

					}

					//

					// Cuando se quiere usar un listado
					// A la linea de bytes el ultimo parametro se cambia por datasource
					// y se descomentarea la siguiente linea y se le pasa el listado
					// armado un List<>
					// JRBeanCollectionDataSource dataSource = new
					// JRBeanCollectionDataSource(listado);

					// Si se quiere usar una conexion se pasa como parmetro un objeto de
					// conexion this.con ó
					// Connection conexion algo asi
					// y el ultimo parametro se de bytes se cambia por la conexion

					// Si solo son parametros, sin conexion ni lista solo como ultimo
					// parametro en la
					// linea de bytes lo siguiente: new JREmptyDataSource()

					byte[] bytes = JasperRunManager.runReportToPdf(ruta_servidor_plantilla + "/" + reporte, pars, new JREmptyDataSource());

					response.setContentType("application/pdf");
					response.setContentLength(bytes.length);
					ServletOutputStream ouputStream = response.getOutputStream();
					ouputStream.write(bytes, 0, bytes.length);

					ouputStream.flush();
					ouputStream.close();

					// facesContext.responseComplete();
					// facesContext.renderResponse();

				} else {

					// out.println("NO SE PUEDE MOSTRAR EL CERTIFICADO");
				}

			} else {

				// out.println("NO SE PUEDE MOSTRAR EL CERTIFICADO");
			}

		} catch (Exception e) {
			// out.println(e.toString());
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
}
