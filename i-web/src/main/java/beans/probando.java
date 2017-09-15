package beans;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.csvreader.CsvReader;

public class probando {

	public int guardarCertificadoExcel(File archivo, String ciudad_curso,
			String fecha_maxima, String etiqueta_capacitacion,
			String fecha_inicio, String horas_certificadas, String certificado,
			String cliente) throws Exception {
		Conexion conexion = new Conexion();
		InputStream input = null;
		CsvReader archivoLeido = null;
		Integer cuentaFilas = 0;
		int g = 0;
		int sw = 0;

		try {

			byte[] array = Files.readAllBytes(archivo.toPath());
			input = new ByteArrayInputStream(array);
			
			Charset inputCharset = Charset.forName("ISO-8859-1");
			
			archivoLeido = new CsvReader(new InputStreamReader(input,inputCharset), ';');

	

			List<String[]> datosLista = new ArrayList<String[]>();

			/**
			 * Si se quiere asigna un separador en particular se descomenta la
			 * siguiente línea
			 */
			archivoLeido.setDelimiter(';');

			/**
			 * Se recorren las filas del archivo
			 */
			while (archivoLeido.readRecord()) {

				cuentaFilas++;
				if (cuentaFilas.intValue() > 6) {

					// Valida que vengan llenos los campos de codigo estudiante
					// y
					// nota
					if (archivoLeido.get(0) != null
							&& archivoLeido.get(1) != null
							&& archivoLeido.get(2) != null) {
						if (!archivoLeido.get(0).trim().equals("")
								&& !archivoLeido.get(1).trim().equals("")
								&& !archivoLeido.get(2).trim().equals("")) {

							String[] nuevo = new String[11];

							nuevo[0] = ciudad_curso; // ciud_depto curso
							if (nuevo[0] == null) {
								nuevo[0] = "";
							}

							nuevo[1] = archivoLeido.get(3); // correo

							if (nuevo[1] == null) {
								nuevo[1] = "";
							}

							nuevo[2] = archivoLeido.get(2).trim(); // documento
							nuevo[3] = fecha_maxima; // fecha_disponibilidad
							nuevo[4] = etiqueta_capacitacion; // label etiqueta
							nuevo[5] = fecha_inicio; // fecha inicio
							nuevo[6] = archivoLeido.get(0).trim(); // nombre
																	// completo
							nuevo[7] = horas_certificadas; // horas
							nuevo[8] = certificado; // tipo certificado

							if (archivoLeido.get(1).trim().toUpperCase()
									.equals("CC")
									|| archivoLeido.get(1).trim().toUpperCase()
											.equals("CE")
									|| archivoLeido.get(1).trim().toUpperCase()
											.equals("TI")) {

								nuevo[9] = archivoLeido.get(1).trim()
										.toUpperCase(); // tipo doc

							} else {

								sw = 1;
								break;
							}

							nuevo[10] = cliente; // cliente
							if ((nuevo[10]).equals("0")) {
								nuevo[10] = null;
							}

							datosLista.add(nuevo);

						} else {

							sw = 1;
							break;
						}

					}

				}
			}

		} catch (Exception e) {
			// TODO: handle exception
		}

		return g;

	}

	public static void main(String[] args) {
		probando objeto = new probando();

		File archivo = new File("D:\\ejemplo1.csv");

		try {
			objeto.guardarCertificadoExcel(archivo, "bucara", "2017-09-09",
					"asistió", "2016-10-04", "9", "5", "0");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
