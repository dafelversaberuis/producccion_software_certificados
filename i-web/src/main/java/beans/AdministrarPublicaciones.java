package beans;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.csvreader.CsvReader;

public class AdministrarPublicaciones {

	public boolean validateEmail(String email) {

		// Compiles the given regular expression into a pattern.
		Pattern pattern = Pattern
				.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
						+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");

		// Match the given input against this pattern
		Matcher matcher = pattern.matcher(email);
		return matcher.matches();

	}

	public void enviarCorreoMasivo(List<String> aCorreos) {

		Parametro parametro = new Parametro();
		Email email = new Email();

		String[] parametros = parametro.getarametros();

		String asunto = "Certificación disponible";
		String mensaje = "<table width='100%' border='0'>"
				+ "<tr>"
				+ "<td colspan='2' align='left' valign='middle'><strong>Sistema de informaci&oacute;n de certificaciones - Isoluciones </strong></td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td colspan='2'>&nbsp;</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td colspan='2'><p>Estimado amigo, Isoluciones ya generó certificado y memorias de la(s) capacitación(es) recibida(s), ingrese a nuestra plataforma y descargue esta información. "
				+ "</p>"
				+ "<p>&nbsp; </p></td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td colspan='2'><span class='Estilo6'>* Puedes visitar nuestro software en cualquier momento dirigi&eacute;ndote a la direcci&oacute;n de internet: <a href='"
				+ parametros[0] + "'>" + parametros[0]
				+ "</a> &oacute; contactarnos a nuestro correo: "
				+ parametros[1] + " </span></td>" + "</tr>" + "</table>";

		try {
			email.enviarCorreoMasivo(mensaje, asunto, aCorreos);
		} catch (Exception e) {

			// e.printStackTrace();
		}
	}

	public String guardarCertificadoExcel(File archivo, String ciudad_curso,
			String fecha_maxima, String etiqueta_capacitacion,
			String fecha_inicio, String horas_certificadas, String certificado,
			String cliente, String numero_firmas, String nombre_capacitador, String cargo_capacitador, String empresa_capacitador) throws Exception {
		Conexion conexion = new Conexion();
		String error = "ok";
		InputStream input = null;
		CsvReader archivoLeido = null;
		Integer cuentaFilas = 0;
		int g = 0;
		int sw = 0;

		try {

			byte[] array = Files.readAllBytes(archivo.toPath());

			input = new ByteArrayInputStream(array);

			Charset inputCharset = Charset.forName("ISO-8859-1");

			archivoLeido = new CsvReader(new InputStreamReader(input,
					inputCharset), ';');

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

							String[] nuevo = new String[16];

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
							
							
							nuevo[11] = archivoLeido.get(4); // empresa proveniente

							if (nuevo[11] == null) {
								nuevo[11] = "";
							}
							
							nuevo[12] = numero_firmas; 
							nuevo[13] = nombre_capacitador; 
							nuevo[14] = cargo_capacitador; 
							nuevo[15] = empresa_capacitador; 

							datosLista.add(nuevo);

						} else {

							sw = 1;
							break;
						}

					}

				}
			}

			if (sw == 0 && datosLista.size() > 0) {

				String[][] datos = new String[datosLista.size()][16];
				int cuenta = 0;
				for (String[] d : datosLista) {
					for (int j = 0; j <= 15; j++) {
						datos[cuenta][j] = d[j];
					}

					cuenta++;
				}

				String[] fechaPartida = datos[0][5].split("-");

				String base = "RCA/" + fechaPartida[2] + "" + fechaPartida[1]
						+ "" + fechaPartida[0];

				String sartaConsecutivo = "";

				int maximo = 0;
				ResultSet rs = conexion
						.consultarBD("SELECT MAX(consecutivo) FROM certificados WHERE fecha_inicio= '"
								+ datos[0][5] + "'");

				try {
					if (rs.next()) {
						maximo = rs.getInt(1);
					}
					rs.close();

				} catch (SQLException e) {
					// e.printStackTrace();
				}

				maximo++;

				for (int i = 0; i <= cuenta - 1; i++) {

					sartaConsecutivo = base + maximo;

					if (datos[i][10] == null
							|| (datos[i][10] != null && ("" + datos[i][10])
									.trim().equals(""))) {
						conexion.actualizarBD("INSERT INTO certificados(tipo_documento,documento,correo,nombre_completo,fecha_inicio,etiqueta,fecha_disponibilidad,tipo_certificado,ciudad_depto_curso,numero_horas,consecutivo,consecutivo_completo,empresa_proveniente, posee_capacitador, capacitador, cargo_capacitador, empresa_capacitador) VALUES ('"
								+ datos[i][9]
								+ "','"
								+ datos[i][2]
								+ "','"
								+ datos[i][1]
								+ "','"
								+ datos[i][6]
								+ "','"
								+ datos[i][5]
								+ "','"
								+ datos[i][4]
								+ "','"
								+ datos[i][3]
								+ "','"
								+ datos[i][8]
								+ "','"
								+ datos[i][0]
								+ "','"
								+ datos[i][7]
								+ "','"
								+ maximo + "','" + sartaConsecutivo + "','"+datos[i][11]+"','"+datos[i][12]+"','"+datos[i][13]+"','"+datos[i][14]+"','"+datos[i][15]+"')");
					} else {

						conexion.actualizarBD("INSERT INTO certificados(tipo_documento,documento,correo,nombre_completo,fecha_inicio,etiqueta,fecha_disponibilidad,tipo_certificado,ciudad_depto_curso,numero_horas,id_cliente,consecutivo,consecutivo_completo,empresa_proveniente, posee_capacitador, capacitador, cargo_capacitador, empresa_capacitador) VALUES ('"
								+ datos[i][9]
								+ "','"
								+ datos[i][2]
								+ "','"
								+ datos[i][1]
								+ "','"
								+ datos[i][6]
								+ "','"
								+ datos[i][5]
								+ "','"
								+ datos[i][4]
								+ "','"
								+ datos[i][3]
								+ "','"
								+ datos[i][8]
								+ "','"
								+ datos[i][0]
								+ "','"
								+ datos[i][7]
								+ "','"
								+ datos[i][10]
								+ "','"
								+ maximo
								+ "','"
								+ sartaConsecutivo + "','"+datos[i][11]+"','"+datos[i][12]+"','"+datos[i][13]+"','"+datos[i][14]+"','"+datos[i][15]+"')");

					}

					maximo++;

				}

				g = 1;
				error = "ok2";

			}

		} catch (Exception e) {
			error = e.toString();
		}

		return error;

	}

	public int actualizarArchivoTema(String id, String nombreArchivo) {

		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("UPDATE temas SET archivo ='"
							+ nombreArchivo.toLowerCase() + "' WHERE id =" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int eliminarArchivoTema(String id, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = conexion
				.actualizarBD("UPDATE temas SET archivo = NULL WHERE id =" + id);

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}

	public int editarTema(String nombre, String idTema) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("UPDATE temas SET nombre='" + nombre.trim()
							+ "' WHERE id=" + idTema);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearTema(String nombre, String idCurso) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("INSERT INTO temas(nombre,id_curso) VALUES('"
							+ nombre.trim() + "'," + idCurso + ")");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int eliminarTema(String idAdministrador, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM temas WHERE id="
				+ Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();

		if (actualizo) {
			java.io.File archivo = new java.io.File(ruta);

			if (archivo.exists()) {
				archivo.delete();
			}
		}

		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public Object[] getTema(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "   SELECT *  FROM temas WHERE id=" + id;
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[4];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public List<Object[]> getTemas(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM temas a WHERE a.id_curso=" + id
				+ " ORDER BY a.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[4];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public int eliminarFinanciador(String idAdministrador, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM financiadores WHERE id="
				+ Integer.parseInt(idAdministrador));

		if (actualizo) {
			java.io.File archivo = new java.io.File(ruta + "-1.jpg");

			if (archivo.exists()) {
				archivo.delete();
			}

			java.io.File archivo2 = new java.io.File(ruta + "-2.jpg");

			if (archivo2.exists()) {
				archivo2.delete();
			}

			java.io.File archivo3 = new java.io.File(ruta + "-3.jpg");

			if (archivo3.exists()) {
				archivo3.delete();
			}
		}

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarLogoFinanciador2(String id, String ruta, String n) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = false;
		if (n != null && !n.equals("1")) {
			actualizo = conexion
					.actualizarBD("UPDATE financiadores SET posee_logo" + n
							+ " ='N' WHERE id =" + id);

		} else {

			actualizo = conexion
					.actualizarBD("UPDATE financiadores SET posee_logo='N' WHERE id ="
							+ id);

		}

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}

	public int eliminarLogoFinanciador(String id, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = conexion
				.actualizarBD("UPDATE financiadores SET posee_logo ='N' WHERE id ="
						+ id);

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}

	public int crearFinanciador(String financiador) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("INSERT INTO financiadores(nombre) VALUES('"
							+ financiador.trim() + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int actualizarFinanciador(String financiador) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("UPDATE financiadores SET posee_logo ='S' WHERE id ="
							+ financiador);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int actualizarFinanciadorNuevo(String financiador, String numero) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = false;

			if (numero != null && numero.equals("2")) {

				actualizo = conexion
						.actualizarBD("UPDATE financiadores SET posee_logo2 ='S' WHERE id ="
								+ financiador);

			} else if (numero != null && numero.equals("3")) {

				actualizo = conexion
						.actualizarBD("UPDATE financiadores SET posee_logo3 ='S' WHERE id ="
								+ financiador);

			} else {
				actualizo = conexion
						.actualizarBD("UPDATE financiadores SET posee_logo ='S' WHERE id ="
								+ financiador);

			}

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public List<Object[]> getFinanciadores() {

		List<Object[]> financiadores = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM financiadores a ORDER BY a.nombre";
		Object[] financiador = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				financiador = new Object[5];

				financiador[0] = rs.getObject(1);
				financiador[1] = rs.getObject(2);
				financiador[2] = rs.getObject(3);
				financiador[3] = rs.getObject(4);
				financiador[4] = rs.getObject(5);

				financiadores.add(financiador);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return financiadores;
	}

	public int eliminarCurso(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion
				.actualizarBD("DELETE FROM tipo_certificacion WHERE id="
						+ Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int editarCurso(String id, String curso, String proyecto) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("UPDATE tipo_certificacion SET nombre_certificacion='"
							+ curso.trim() + "' WHERE id=" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearCurso(String curso, String proyecto) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("INSERT INTO tipo_certificacion(nombre_certificacion) VALUES('"
							+ curso.trim() + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public List<Object[]> getCursos() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "   SELECT * FROM tipo_certificacion a"
				+ " ORDER BY a.nombre_certificacion";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[2];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public Object[] getCursoCompleto(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "   SELECT *  FROM tipo_certificacion a"
				+ " WHERE a.id=" + id + " ORDER BY a.nombre_certificacion";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[2];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public int crearPortafolio(String titulo, String contenido) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion
					.actualizarBD("INSERT INTO portafolio(titulo_portafolio,contenido_portafolio) VALUES('"
							+ titulo + "','" + contenido + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearAdmin(String pn, String sn, String pa, String sa, int doc,
			String correo, String clave) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			Parametro parametro = new Parametro();
			Email email = new Email();

			String[] parametros = parametro.getarametros();
			int c = 0;

			ResultSet rs = conexion
					.consultarBD("SELECT COUNT(*) FROM administradores WHERE documento= "
							+ doc);
			try {
				if (rs.next()) {
					c = rs.getInt(1);
				}
				rs.close();

			} catch (SQLException e) {
				// e.printStackTrace();
			}

			String asunto = "";
			String mensaje = "";

			if (c == 0) {
				asunto = "Nueva cuenta en software de certificaciones Isoluciones";
				mensaje = "<table width='100%' border='0'>"
						+ "<tr>"
						+ "<td colspan='2' align='left' valign='middle'><strong>Sistema de informaci&oacute;n de certificaciones - Isoluciones </strong></td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td colspan='2'>&nbsp;</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td colspan='2'><p>Estimado administrador(a) <strong>"
						+ pn
						+ " "
						+ sn
						+ " "
						+ pa
						+ " "
						+ sa
						+ "</strong>, se le ha creado una nueva cuenta en el software de certificaciones de Isoluciones. Le recordamos su nueva contraseña, cámbiela cuando desee desde el menú administrador. La contraseña es: "
						+ clave
						+ ".</p>"
						+ "<p>&nbsp; </p></td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td colspan='2'><span class='Estilo6'>* Puedes visitar nuestro software en cualquier momento dirigi&eacute;ndote a la direcci&oacute;n de internet: <a href='"
						+ parametros[0]
						+ "'>"
						+ parametros[0]
						+ "</a> &oacute; contactarnos a nuestro correo: "
						+ parametros[1]
						+ " </span></td>"
						+ "</tr>"
						+ "</table>";

				try {
					email.enviarEmail(mensaje, asunto, correo);
				} catch (Exception e) {

					// e.printStackTrace();
				}

				boolean actualizo = conexion
						.actualizarBD("INSERT INTO administradores(primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,documento,clave,correo) VALUES('"
								+ pn
								+ "','"
								+ sn
								+ "','"
								+ pa
								+ "','"
								+ sa
								+ "',"
								+ doc
								+ ",\""
								+ clave
								+ "\",'"
								+ correo
								+ "')");
				if (actualizo) {
					exito = 1;
				}
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int getEnviarNuevaClaveAdmin(String correo, int id, String m,
			String clave) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			Parametro parametro = new Parametro();
			Email email = new Email();

			String[] parametros = parametro.getarametros();
			Administrador admin = new Administrador();

			String asunto = "";
			String mensaje = "";

			if (m.equals("0")) {
				admin.setClave(this.getClaveAleatoria());
			} else {
				admin.setClave(clave);
			}
			asunto = "Nueva clave para el software de certificaciones-Isoluciones";
			mensaje = "<table width='100%' border='0'>"
					+ "<tr>"
					+ "<td colspan='2' align='left' valign='middle'><strong>Sistema de informaci&oacute;n de certificaciones-Isoluciones</strong></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td colspan='2'>&nbsp;</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td colspan='2'><p>Estimado administrador(a), se le ha asignado una nueva contraseña. Cámbiela cuando desee. La contraseña es: "
					+ admin.getClave()
					+ "</p>"
					+ "<p>&nbsp; </p></td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td colspan='2'><span class='Estilo6'>* Puedes visitar nuestro software en cualquier momento dirigi&eacute;ndote a la direcci&oacute;n de internet: <a href='"
					+ parametros[0] + "'>" + parametros[0]
					+ "</a> &oacute; contactarnos a nuestro correo: "
					+ parametros[1] + " </span></td></tr>" + "</table>";

			try {
				email.enviarEmail(mensaje, asunto, correo);
			} catch (Exception e) {

				// e.printStackTrace();
			}

			boolean actualizo = conexion
					.actualizarBD("UPDATE administradores SET clave=(\""
							+ admin.getClave() + "\") WHERE id_administrador="
							+ id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	private String getClaveAleatoria() {
		String clave = "";
		for (int i = 0; i <= 3; i++) {
			int n = (int) (10.0 * Math.random()) + 0;
			clave = clave + String.valueOf(n);

		}
		return clave;

	}

	public int eliminarArchivoPlano(String pArchivo, String idArchivo) {
		Parametro parametro = new Parametro();
		String[] parametros = parametro.getarametros();
		java.io.File directorio = new java.io.File(parametros[5] + pArchivo);
		directorio.delete();

		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;
		actualizo = conexion
				.actualizarBD("DELETE FROM archivos_planos WHERE id_archivo="
						+ Integer.parseInt(idArchivo));
		// conexion.commitBD();
		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarPortafolio(String idPortafolio) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion
				.actualizarBD("DELETE FROM portafolio WHERE id_portafolio="
						+ Integer.parseInt(idPortafolio));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarAdministrador(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		ResultSet rs = conexion
				.consultarBD("SELECT COUNT(*) FROM administradores");
		int c = 0;
		try {
			while (rs.next()) {
				c = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		}

		if (c > 1) {
			actualizo = conexion
					.actualizarBD("DELETE FROM administradores WHERE id_administrador="
							+ Integer.parseInt(idAdministrador));
		}

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarCertificado(String id) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion
				.actualizarBD("DELETE FROM certificados WHERE id_certificado="
						+ Integer.parseInt(id));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarArchivo(String pArchivo, String idFoto, String ruta) {
		Parametro parametro = new Parametro();
		String[] parametros = parametro.getarametros();
		java.io.File directorio = new java.io.File(pArchivo);
		// java.io.File directorio = new java.io.File(parametros[2] + pArchivo);
		// //antes
		directorio.delete();

		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;
		actualizo = conexion
				.actualizarBD("DELETE FROM repositorio_fotos WHERE id_foto="
						+ Integer.parseInt(idFoto));
		// conexion.commitBD();

		if (actualizo) {
			g = 1;
		}

		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();

		String sentencia = "";

		sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado"
				+ " UNION ALL"
				+ " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre, id_foto FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";

		RepositorioFotos foto2 = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			while (rs.next()) {
				foto2 = new RepositorioFotos();
				foto2.setIdFoto(rs.getInt(4));
				foto2.setNombre(rs.getString(3));
				foto2.setFechaPublicacion(rs.getString(1));
				foto2.setDireccionFoto(rs.getString(2));

				fotos.add(foto2);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {

		}

		int cuenta = 0;
		if (fotos != null && fotos.size() > 0) {
			for (RepositorioFotos p : fotos) {
				actualizo = false;
				cuenta++;
				g = cuenta;
				File f1 = new File(ruta + "/cursos/" + p.getDireccionFoto());
				f1.renameTo(new File(ruta + "/cursos/T" + p.getDireccionFoto()));

				if (!f1.exists()) {
					f1 = new File(ruta + "\\cursos\\" + p.getDireccionFoto());
					f1.renameTo(new File(ruta + "\\cursos\\T"
							+ p.getDireccionFoto()));
				}

				actualizo = conexion
						.actualizarBD("UPDATE repositorio_fotos SET direccion_foto='curso_"
								+ cuenta
								+ ".jpg' WHERE id_foto="
								+ p.getIdFoto());
			}

			cuenta = 0;
			for (RepositorioFotos p : fotos) {

				cuenta++;

				File f3 = new File(ruta + "/cursos/T" + p.getDireccionFoto());
				f3.renameTo(new File(ruta + "/cursos/curso_" + cuenta + ".jpg"));

				if (!f3.exists()) {
					f3 = new File(ruta + "\\cursos\\T" + p.getDireccionFoto());
					f3.renameTo(new File(ruta + "\\cursos\\curso_" + cuenta
							+ ".jpg"));
				}

			}

		}

		conexion.cerrarConexion();

		return g;
	}

	public List<RepositorioFotos> getRepositorioFotosEliminar(
			String tipoUsuario, String usuario) {
		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();
		Conexion conexion = new Conexion();
		String sentencia = "";
		if (tipoUsuario.equals("1")) {
			sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado AND eg.id_egresado="
					+ usuario;
		} else {
			sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado"
					+ " UNION ALL"
					+ " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre, id_foto FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";
		}
		RepositorioFotos foto = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				foto = new RepositorioFotos();
				foto.setIdFoto(rs.getInt(4));
				foto.setNombre(rs.getString(3));
				foto.setFechaPublicacion(rs.getString(1));
				foto.setDireccionFoto(rs.getString(2));
				fotos.add(foto);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return fotos;
	}

	public List<RepositorioFotos> getRepositorioFotos() {
		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado"
				+ " UNION ALL"
				+ " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";
		RepositorioFotos foto = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				foto = new RepositorioFotos();
				foto.setNombre(rs.getString(3));
				foto.setFechaPublicacion(rs.getString(1));
				foto.setDireccionFoto(rs.getString(2));
				fotos.add(foto);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return fotos;
	}

	public int guardarArchivoPlano(String usuario, String archivo) {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;
		actualizo = conexion
				.actualizarBD("INSERT INTO archivos_planos(archivo, id_administrador, fecha) VALUES('"
						+ archivo
						+ "',"
						+ usuario
						+ ",'"
						+ formato.format(new Date()) + "' )");
		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;

	}

	public int guardarRepositorio(String tipoEgresado, String usuario,
			String foto) {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion
				.actualizarBD("INSERT INTO repositorio_fotos(direccion_foto, id_administrador, fecha_publicacion) VALUES('"
						+ foto + "',1,'" + formato.format(new Date()) + "')");

		if (actualizo) {
			g = 1;
		}

		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();

		String sentencia = "";

		sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado"
				+ " UNION ALL"
				+ " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre, id_foto FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";

		RepositorioFotos foto2 = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			while (rs.next()) {
				foto2 = new RepositorioFotos();
				foto2.setIdFoto(rs.getInt(4));
				foto2.setNombre(rs.getString(3));
				foto2.setFechaPublicacion(rs.getString(1));
				foto2.setDireccionFoto(rs.getString(2));
				fotos.add(foto2);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {

		}

		int cuenta = 0;
		if (fotos != null && fotos.size() > 0) {
			for (RepositorioFotos p : fotos) {
				actualizo = false;
				cuenta++;
				g = cuenta;
				actualizo = conexion
						.actualizarBD("UPDATE repositorio_fotos SET direccion_foto='curso_"
								+ cuenta
								+ ".jpg' WHERE id_foto="
								+ p.getIdFoto());
			}

		}

		conexion.cerrarConexion();

		return g;

	}

	public int guardarCertificado(String[][] datos, int longitud)
			throws Exception {
		Conexion conexion = new Conexion();

		String[] fechaPartida = datos[0][5].split("-");

		String base = "RCA/" + fechaPartida[2] + "" + fechaPartida[1] + ""
				+ fechaPartida[0];

		String sartaConsecutivo = "";

		int maximo = 0;
		ResultSet rs = conexion
				.consultarBD("SELECT MAX(consecutivo) FROM certificados WHERE fecha_inicio= '"
						+ datos[0][5] + "'");

		try {
			if (rs.next()) {
				maximo = rs.getInt(1);
			}
			rs.close();

		} catch (SQLException e) {
			// e.printStackTrace();
		}

		maximo++;

		int g = 0;

		for (int i = 0; i <= longitud - 1; i++) {

			sartaConsecutivo = base + maximo;

			if (datos[i][10] == null
					|| (datos[i][10] != null && ("" + datos[i][10]).trim()
							.equals(""))) {
				conexion.actualizarBD("INSERT INTO certificados(tipo_documento,documento,correo,nombre_completo,fecha_inicio,etiqueta,fecha_disponibilidad,tipo_certificado,ciudad_depto_curso,numero_horas,consecutivo,consecutivo_completo,empresa_proveniente, posee_capacitador, capacitador, cargo_capacitador, empresa_capacitador) VALUES ('"
						+ datos[i][9]
						+ "','"
						+ datos[i][2]
						+ "','"
						+ datos[i][1]
						+ "','"
						+ datos[i][6]
						+ "','"
						+ datos[i][5]
						+ "','"
						+ datos[i][4]
						+ "','"
						+ datos[i][3]
						+ "','"
						+ datos[i][8]
						+ "','"
						+ datos[i][0]
						+ "','"
						+ datos[i][7]
						+ "','"
						+ maximo
						+ "','" + sartaConsecutivo + "','"+datos[i][11]+"','"+datos[i][12]+"','"+datos[i][13]+"','"+datos[i][14]+"','"+datos[i][15]+"')");
			} else {

				conexion.actualizarBD("INSERT INTO certificados(tipo_documento,documento,correo,nombre_completo,fecha_inicio,etiqueta,fecha_disponibilidad,tipo_certificado,ciudad_depto_curso,numero_horas,id_cliente,consecutivo,consecutivo_completo,empresa_proveniente, posee_capacitador, capacitador, cargo_capacitador, empresa_capacitador) VALUES ('"
						+ datos[i][9]
						+ "','"
						+ datos[i][2]
						+ "','"
						+ datos[i][1]
						+ "','"
						+ datos[i][6]
						+ "','"
						+ datos[i][5]
						+ "','"
						+ datos[i][4]
						+ "','"
						+ datos[i][3]
						+ "','"
						+ datos[i][8]
						+ "','"
						+ datos[i][0]
						+ "','"
						+ datos[i][7]
						+ "','"
						+ datos[i][10]
						+ "','"
						+ maximo
						+ "','"
						+ sartaConsecutivo + "','"+datos[i][11]+"','"+datos[i][12]+"','"+datos[i][13]+"','"+datos[i][14]+"','"+datos[i][15]+"')");

			}

			maximo++;

		}

		g = 1;

		return g;

	}

	public int guardarSeccion(String titulo, String contenido, String foto,
			String receptor) throws Exception {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;
		if (foto == null || foto.equals("null")) {
			foto = "";
		}
		actualizo = conexion
				.actualizarBD("UPDATE secciones SET titulo_seccion = '"
						+ titulo + "',  direccion_foto_seccion = '" + foto
						+ "', fecha = '" + formato.format(new Date())
						+ "', contenido_seccion ='" + contenido
						+ "' WHERE id_seccion =" + Integer.parseInt(receptor));

		if (actualizo) {
			g = 1;

		}
		return g;

	}

	public int guardarPublicacion(int tipoUsuario, int administrador,
			int egresado, int privacidad, String titulo, String contenido,
			String foto, String receptor) throws Exception {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;
		if (receptor.equals("0")) {
			receptor = null;
		}

		Object[] objeto = new Object[7];

		objeto[0] = administrador;
		objeto[1] = privacidad;
		titulo = titulo.replace("“", "\'");
		titulo = titulo.replace("”", "\'");
		objeto[2] = titulo;
		contenido = contenido.replace("“", "\'");
		contenido = contenido.replace("”", "\'");
		objeto[3] = contenido;
		objeto[4] = foto;
		objeto[5] = receptor;
		objeto[6] = formato.format(new Date());

		String[] campos = { "id_administrador", "privacidad_publicacion",
				"titulo_publicacion", "contenido_publicacion",
				"direccion_foto_publicacion", "receptor", "fecha" };

		actualizo = conexion.insertarBD2("publicaciones", campos, objeto);

		if (actualizo) {
			g = 1;

		}
		return g;

	}

	public int eliminarPublicacion(int aIdPublicacion) {
		Conexion conexion = new Conexion();
		boolean actualizo = false;
		int g = 0;
		actualizo = conexion
				.actualizarBD("DELETE FROM publicaciones WHERE id_publicacion='"
						+ aIdPublicacion + "'");

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;

	}

	public List<Publicacion> getPublicaciones(int aEgresado) {
		List<Publicacion> publicaciones = new ArrayList<Publicacion>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu LEFT JOIN egresados eg  ON  pu.id_egresado = eg.id_egresado WHERE privacidad_publicacion = 1 UNION ALL"
				+ " SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion FROM publicaciones pu, egresados eg WHERE privacidad_publicacion =3 AND receptor = "
				+ aEgresado
				+ " AND pu.id_egresado = eg.id_egresado"
				+ " ORDER BY fecha DESC, id_publicacion DESC FIRST 10";
		Publicacion publicacion = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null
						|| rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				if (publicacion.getIdAdministrador() != 0) {
					publicacion.setNombre("Administrador");

				}

				publicaciones.add(publicacion);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicaciones;
	}

	public List<Publicacion> getPublicacionesEgresado(int aEgresado,
			int tipoUsuario) {
		List<Publicacion> publicaciones = new ArrayList<Publicacion>();
		Conexion conexion = new Conexion();
		String sentencia = "";
		if (tipoUsuario == 2) {
			sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu, egresados eg  WHERE  pu.id_egresado = eg.id_egresado AND (receptor IS NULL OR receptor = 0) ORDER BY fecha DESC, id_publicacion DESC";
		} else {
			sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu, egresados eg  WHERE  pu.id_egresado = eg.id_egresado AND eg.id_egresado="
					+ aEgresado
					+ " ORDER BY fecha DESC, id_publicacion DESC FIRST 10";
		}
		Publicacion publicacion = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null
						|| rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				publicaciones.add(publicacion);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicaciones;
	}

	public Publicacion getNotaPublica(int id) {
		Conexion conexion = new Conexion();
		String sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu LEFT JOIN egresados eg ON pu.id_egresado = eg.id_egresado WHERE privacidad_publicacion = 2 AND pu.id_publicacion="
				+ id;
		Publicacion publicacion = new Publicacion();
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			if (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null
						|| rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				if (publicacion.getIdAdministrador() != 0) {
					publicacion.setNombre("Administrador");
				}

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicacion;
	}

	public String getTextoCortado(String aTexto) {
		String texto = "";
		int longitud = 220;
		if (aTexto != null) {
			if (aTexto.trim().length() >= longitud) {
				String[] vector = aTexto.split("");
				for (int i = 0; i < longitud; i++) {
					texto += vector[i];
				}
				texto += " ...";
			} else {
				texto = aTexto.trim();
			}
		}

		return texto;

	}

	public Seccion getSeccion(int id) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM secciones s WHERE s.id_seccion=" + id;

		Seccion seccion = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			if (rs.next()) {
				seccion = new Seccion();
				seccion.setSeccion(rs.getInt(1));

				seccion.setTitulo(rs.getString(2));
				seccion.setContenido(rs.getString(3));

				if (rs.getString(4) == null
						|| rs.getString(4).trim().equals("")) {

				} else {
					seccion.setDireccionFoto(rs.getString(4));
				}
				seccion.setFecha(rs.getString(5));

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return seccion;
	}

	public List<Seccion> getSecciones() {
		List<Seccion> secciones = new ArrayList<Seccion>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM secciones s ORDER BY s.id_seccion";

		Seccion seccion = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			while (rs.next()) {
				seccion = new Seccion();
				seccion.setSeccion(rs.getInt(1));

				seccion.setTitulo(rs.getString(2));
				seccion.setContenido(rs.getString(3));

				if (rs.getString(4) == null
						|| rs.getString(4).trim().equals("")) {

				} else {
					seccion.setDireccionFoto(rs.getString(4));
				}
				seccion.setFecha(rs.getString(5));

				secciones.add(seccion);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return secciones;
	}

	public List<Publicacion> getNotasPublicas() {
		List<Publicacion> publicaciones = new ArrayList<Publicacion>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu LEFT JOIN egresados eg ON pu.id_egresado = eg.id_egresado WHERE privacidad_publicacion = 2 ORDER BY fecha DESC, id_publicacion DESC";
		// " DESC, id_publicacion DESC";
		Publicacion publicacion = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null
						|| rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				if (publicacion.getIdAdministrador() != 0) {
					publicacion.setNombre("Administrador");
				}

				publicaciones.add(publicacion);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicaciones;
	}

	public List<ArchivoPlano> getArchivosPlanos() {
		List<ArchivoPlano> archivos = new ArrayList<ArchivoPlano>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT *  FROM archivos_planos a ORDER BY a.fecha DESC, a.id_archivo DESC";
		ArchivoPlano archivo = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				archivo = new ArchivoPlano();
				archivo.setIdArchivo(rs.getInt(1));
				archivo.setArchivo(rs.getString(2));
				archivo.setFecha(rs.getString(3));
				archivos.add(archivo);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return archivos;
	}

	public List<Portafolio> getPortafolios() {
		List<Portafolio> portafolios = new ArrayList<Portafolio>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM portafolio a ORDER BY id_portafolio DESC";
		Portafolio portafolio = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				portafolio = new Portafolio();
				portafolio.setIdPortafolio(rs.getInt("id_portafolio"));
				portafolio.setTitulo(rs.getString("titulo_portafolio"));
				portafolio.setContenido(rs.getString("contenido_portafolio"));

				portafolios.add(portafolio);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return portafolios;
	}

	public List<Certificado> getTiposCertificados() {
		List<Certificado> tipos = new ArrayList<Certificado>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM tipo_certificacion a ORDER BY nombre_certificacion";
		Certificado tipo = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				tipo = new Certificado();
				tipo.setId(rs.getInt("id"));
				tipo.setNombre(rs.getString("nombre_certificacion"));

				tipos.add(tipo);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return tipos;
	}

	public List<Administrador> getAdministradores() {
		List<Administrador> administradores = new ArrayList<Administrador>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM administradores a ORDER BY primer_nombre, segundo_nombre, primer_apellido, segundo_apellido";
		Administrador admin = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				admin = new Administrador();
				admin.setIdAdministrador(rs.getInt("id_administrador"));
				admin.setPrimerApellido(rs.getString("primer_apellido"));
				admin.setCorreo(rs.getString("correo"));
				admin.setDocumento(rs.getInt("documento"));
				admin.setPrimerNombre(rs.getString("primer_nombre"));
				admin.setSegundoApellido(rs.getString("segundo_apellido"));
				admin.setSegundoNombre(rs.getString("segundo_nombre"));

				administradores.add(admin);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return administradores;
	}

	public List<Certificado> getCertificados(String tipoCertificado,
			String documento, String nombre, String fechaI, String fechaF,
			String consecutivo, String cliente) {
		List<Certificado> certificados = new ArrayList<Certificado>();
		Certificado certificado = null;
		Conexion conexion = new Conexion();
		String sentencia = "SELECT c .* , t.nombre_certificacion, f.nombre nombre_cliente, posee_logo, posee_logo2, posee_logo3, posee_capacitador, capacitador, cargo_capacitador, empresa_capacitador FROM certificados c INNER JOIN tipo_certificacion t ON c.tipo_certificado = t.id LEFT JOIN financiadores f ON c.id_cliente = f.id WHERE 1=1";

		if (tipoCertificado != null && !tipoCertificado.trim().equals("0")) {

			sentencia += " AND c.tipo_certificado='" + tipoCertificado + "'";
		}

		if (cliente != null && !cliente.trim().equals("")) {

			sentencia += " AND c.id_cliente='" + cliente + "'";
		}

		if (documento != null && !documento.trim().equals("")) {

			sentencia += " AND c.documento='" + documento + "'";
		}

		if (nombre != null && !nombre.trim().equals("")) {

			sentencia += " AND UPPER(c.nombre_completo) LIKE '%"
					+ nombre.trim().toUpperCase() + "%'";
		}

		if (consecutivo != null && !consecutivo.trim().equals("")) {

			sentencia += " AND UPPER(c.consecutivo_completo) LIKE '%"
					+ consecutivo.trim().toUpperCase() + "%'";
		}

		if (fechaI != null && !fechaI.trim().equals("")) {

			sentencia += " AND c.fecha_inicio >='" + fechaI + "'";
		}

		if (fechaF != null && !fechaF.trim().equals("")) {

			sentencia += " AND c.fecha_inicio <='" + fechaF + "'";
		}

		sentencia += " ORDER BY c.consecutivo, c.nombre_completo";

		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				certificado = new Certificado();
				certificado.setCiudadDepartamentoCurso(rs
						.getString("ciudad_depto_curso"));
				certificado.setCiudadDocumento(rs.getString("correo"));
				certificado.setDocumento(rs.getLong("documento"));
				certificado.setFechaDisponibilidad(rs
						.getString("fecha_disponibilidad"));
				certificado.setFechaFin(rs.getString("etiqueta"));
				certificado.setFechaInicio(rs.getString("fecha_inicio"));
				certificado.setId(rs.getInt("id_certificado"));
				certificado.setNombre(rs.getString("nombre_completo"));
				certificado.setTipoCertificado(rs
						.getString("nombre_certificacion"));
				certificado.setTipoDocumento(rs.getString("tipo_documento"));
				certificado.setNumeroHoras(rs.getInt("numero_horas"));
				certificado.setIdCliente(rs.getString("id_cliente"));

				certificado.setIdTipoCertificado(rs.getInt("tipo_certificado"));

				certificado.setNombreCliente(rs.getString("nombre_cliente"));

				certificado.setConsecutivoCompleto(rs
						.getString("consecutivo_completo"));

				certificado.setPoseeLogo1(rs.getString("posee_logo"));
				certificado.setPoseeLogo2(rs.getString("posee_logo2"));
				certificado.setPoseeLogo3(rs.getString("posee_logo3"));
				
				
				certificado.setEmpresaProviene(rs.getString("empresa_proveniente"));
				
				
				certificado.setPoseeCapacitador(rs.getString("posee_capacitador"));
				certificado.setCapacitador(rs.getString("capacitador"));
				certificado.setCargoCapacitador(rs.getString("cargo_capacitador"));
				certificado.setEmpresaCapacitador(rs.getString("empresa_capacitador"));

				certificados.add(certificado);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return certificados;
	}

	public Certificado getCertificado(int id) {
		Certificado certificado = null;
		Conexion conexion = new Conexion();
		String sentencia = "SELECT c .* , t.nombre_certificacion, posee_logo, posee_logo2, posee_logo3, posee_capacitador, capacitador, cargo_capacitador, empresa_capacitador FROM certificados c INNER JOIN tipo_certificacion t ON c.tipo_certificado = t.id LEFT JOIN financiadores f ON c.id_cliente=f.id   WHERE c.id_certificado ="
				+ id;

		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				certificado = new Certificado();
				certificado.setCiudadDepartamentoCurso(rs
						.getString("ciudad_depto_curso"));
				certificado.setCiudadDocumento(rs.getString("correo"));
				certificado.setDocumento(rs.getLong("documento"));
				certificado.setFechaDisponibilidad(rs
						.getString("fecha_disponibilidad"));
				certificado.setFechaFin(rs.getString("etiqueta"));
				certificado.setFechaInicio(rs.getString("fecha_inicio"));
				certificado.setId(rs.getInt("id_certificado"));
				certificado.setNombre(rs.getString("nombre_completo"));
				certificado.setTipoCertificado(rs
						.getString("nombre_certificacion"));
				certificado.setTipoDocumento(rs.getString("tipo_documento"));
				certificado.setNumeroHoras(rs.getInt("numero_horas"));
				certificado.setIdCliente(rs.getString("id_cliente"));

				certificado.setPoseeLogo1(rs.getString("posee_logo"));
				certificado.setPoseeLogo2(rs.getString("posee_logo2"));
				certificado.setPoseeLogo3(rs.getString("posee_logo3"));

				certificado.setConsecutivoCompleto(rs
						.getString("consecutivo_completo"));
				
				certificado.setEmpresaProviene(rs.getString("empresa_proveniente"));
				
				certificado.setPoseeCapacitador(rs.getString("posee_capacitador"));
				certificado.setCapacitador(rs.getString("capacitador"));
				certificado.setCargoCapacitador(rs.getString("cargo_capacitador"));
				certificado.setEmpresaCapacitador(rs.getString("empresa_capacitador"));

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return certificado;
	}

}
