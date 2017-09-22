package beans;

import java.io.IOException;
import java.sql.Connection;

public class Parametro {
  
	/**
	 * Este método obtiene la ruta absoluta de un archivo, a partir de un nombre
	 * de una carpeta o archivo
	 * 
	 * @param aPosibleRuta
	 * @return path
	 * @throws IOException
	 */

	private String getPath() {
		String path = null;
		try {
			path = new java.io.File(".").getCanonicalPath();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return path;
	}

	public String[] getarametros() {  
		String a = getPath();
		String[] parametros = new String[6];

		// dirección web del portal(ojo sin / al final tanto linux como windows)
		parametros[0] = "http://certificadosisoluciones.com";

		// correo uis del portal egresados EISI UIS parametros[1] =
		parametros[1] = "directorcomercial@isolucionesltda.com";   //multiemergenciassas@gmail.com  //jefenixon.zambrano@gmail.com

		// repositorio de imagenes ( con \\ al final si es windows o / al final si
		// // es linux) parametros[2] =
		parametros[2] = "C:\\tomcat6\\webapps\\multiemergencias\\images\\repositorio\\";

		// fotos de las publicaciones ( con \\ al final si es windows o / al final
		// // si es linux) parametros[3] =
		parametros[3] = "C:\\tomcat6\\webapps\\multiemergencias\\images\\publicaciones\\";

		parametros[4] = "C:\\tomcat6\\webapps\\multiemergencias\\images\\eisilogo.png";

		parametros[5] = "C:\\tomcat6\\webapps\\multiemergencias\\archivosplanos\\archivos\\";

		// // dirección web del portal(ojo sin / al final tanto linux como windows)
		// parametros[0] = "http://xxxxxxxxxxxxxxxxxxx";
		//
		// // correo uis del portal egresados EISI UIS
		// parametros[1] = "egresados.eisi@uis.edu.co";
		//
		// // repositorio de imagenes ( con \\ al final si es windows o / al final
		// si
		// // es linux)
		// parametros[2] = "/opt/tomcat5.5/webapps/egresado/images/repositorio/";
		//
		// // fotos de las publicaciones ( con \\ al final si es windows o / al
		// final
		// // si es linux)
		// parametros[3] = "/opt/tomcat5.5/webapps/egresado/images/publicaciones/";
		//
		// parametros[4] = "/opt/tomcat5.5/webapps/egresado/images/eisilogo.png";
		//
		// parametros[5] =
		// "/opt/tomcat5.5/webapps/egresado/archivosplanos/archivos/";

		return parametros;

	}

	public Connection fConexionActual() {
		Connection conexion = null;
		try {
			try {
				try {
					Class.forName("com.informix.jdbc.IfxDriver").newInstance();

				} catch (IllegalAccessException ile) {
					//System.out.println("Instancia ilegal!");
				}
			} catch (InstantiationException ine) {
				//System.out.println("No se puede hacer una instancia del driver!");
			}
		} catch (ClassNotFoundException cnfx) {
			//System.out.println("No se pudo cargar el Driver Correctamente!");
		}

		try {
			//conexion = DriverManager.getConnection("dbc:informix-sqli://192.168.19.9:12010/cintrop:INFORMIXSERVER=DB_UIS", "acintrop", "Ac1ntr0p-%=");
			// con.setTransactionIsolation(8);
		} catch (Exception ex) {
			//ex.printStackTrace();
		}
		return conexion;
	}

	public static void main(String[] args) {
	}
}
