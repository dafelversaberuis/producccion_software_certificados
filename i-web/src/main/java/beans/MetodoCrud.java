package beans;

import java.sql.ResultSet;

public class MetodoCrud {
  
	public MetodoCrud() {

	}

	// INSERT
	public boolean fInsertar(String sentencia) {
		Conexion base = new Conexion();
		boolean resultado = false;
		try {

			resultado = base.actualizarBD(sentencia);
			base.cerrarConexion();

		} finally {
			base.cerrarConexion();
		}
		return resultado;

	}

	// SELECT
	public ResultSet fConsultar(String sentencia) {
		Conexion base = new Conexion();
		ResultSet query = null;
		try {
			query = base.consultarBD(sentencia);
		} finally {
			base.cerrarConexion();
		}
		return query;
	}

	// UPDATE Y DELETE
	public boolean fActualizar(String sentencia) {
		Conexion base = new Conexion();
		boolean resultado = false;
		try {
			resultado = base.actualizarBD(sentencia);
		} finally {
			base.cerrarConexion();
		}
		return resultado;

	}

	public boolean fActualizar2(Conexion base, String sentencia) {

		boolean resultado = false;
		try {
			resultado = base.actualizarBD(sentencia);
		} catch (Exception e) {
			//e.printStackTrace();
		}
		return resultado;

	}

	public static void main(String[] args) {

		// MetodoCrud metodoCrud = new MetodoCrud();

		// metodoCrud.fActualizar("UPDATE administradores set clave = md5(\"meli0523\") WHERE id_administrador=1");

		//Seguridad seguridad = new Seguridad();
		//seguridad.consultarExistenciaUsuario("13177539", "meli0523");

		// seguridad.registrarSesion("13177539", "meli0523", 2);
	}

}
