package beans;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
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

import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@WebServlet("/imprimir_tratamiento_datos.jsp")
public class ImprimirTratamientoDatos extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1782984524819793537L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {

			SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
			String tipoCertificado = request.getParameter("tc");
			String documento = request.getParameter("d");
			String nombre = request.getParameter("n");
			String fechaI = request.getParameter("fi");
			String fechaF = request.getParameter("ff");
			int sw = 0;

			String meses[] = { " ", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

			DecimalFormatSymbols simbolo = new DecimalFormatSymbols();
			simbolo.setDecimalSeparator(',');
			simbolo.setGroupingSeparator('.');

			DecimalFormat formateador = new DecimalFormat("###,###.##", simbolo);
			String reporte = new String();
			reporte = "tratamientoDatos.jasper";

			String id = request.getParameter("i");
			if (id != null && !id.equals("")) {

				// Ruta donde se encuentra la plantilla que diseña el admin del IPRED
				String ruta_servidor_plantilla = request.getRealPath("/reportes/");

				//
				String logo = request.getRealPath("/imagenes/");

				Map pars = new HashMap();
				pars.put("pLogo", logo);
				pars.put("SUBREPORT_DIR", ruta_servidor_plantilla + "/");

				List<Certificado> certificados = new AdministrarPublicaciones().getCertificados(tipoCertificado, documento, nombre, fechaI, fechaF, null, null);
				List<Certificado> certificados2 = new ArrayList<Certificado>();
				if (certificados != null && certificados.size() > 0) {

					for (Certificado certificado : certificados) {

						if (certificado.getFechaDisponibilidad().compareTo(formato.format(new java.util.Date())) >= 0) {

							if (certificado.getTipoDocumento().equals("C.E.") || certificado.getTipoDocumento().equals("T.I.")) {
								certificado.setTipoDocumento(certificado.getTipoDocumento() + " " + certificado.getDocumento());
							} else {
								certificado.setTipoDocumento(certificado.getTipoDocumento() + " " + formateador.format(certificado.getDocumento()));

							}

							if (certificados2 != null && certificados2.size() > 0) {
								sw = 0;
								for (Certificado c2 : certificados2) {
									if (c2.getTipoDocumento().trim().equals(certificado.getTipoDocumento()) && c2.getDocumento() == certificado.getDocumento()) {
										sw = 1;
										break;
									}

								}

								if (sw == 0) {
									certificados2.add(certificado);
								}

							} else {

								certificados2.add(certificado);

							}

						}

					}

					if (certificados2 != null && certificados2.size() > 0) {

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

						byte[] bytes = JasperRunManager.runReportToPdf(ruta_servidor_plantilla + "/" + reporte, pars, new JRBeanCollectionDataSource(certificados2));

						/* Indicamos que la respuesta va a ser en formato PDF */

						response.setContentType("application/pdf");
						response.setContentLength(bytes.length);
						ServletOutputStream ouputStream = response.getOutputStream();
						ouputStream.write(bytes, 0, bytes.length);

						/* Limpiamos y cerramos flujos de salida */

						ouputStream.flush();
						ouputStream.close();

					} else {

						// out.println("NO EXISTEN INFORMACION A GENERAR...");

					}

				} else {

					// out.println("NO EXISTEN INFORMACION A GENERAR..");
				}

			} else {

				// out.println("NO SE PUEDE MOSTRAR LA INFORMACION.");
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
