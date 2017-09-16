package beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Conexion {

	// Configuracion de la conexion a la base de datos

	private String						DB_driver	= "";
	private String						url				= "";
	private String						username	= "";
	private String						password	= "";
	public Connection					con				= null;
	private Statement					stmt			= null;
	private PreparedStatement	pstmt			= null;
	private ResultSet					rs				= null;

	private String						query			= null;

	Conexion() {

		DB_driver = "com.mysql.jdbc.Driver";
//		url = "jdbc:mysql://localhost:3306/produccion_certificados";
//		username = "root";
//		password = "12345678";
		

		// openshift v3
		url = "jdbc:mysql://mysql:3306/produccion_certificados";
		username = "dannypipe_certificados";
		password = "meli0523_certificados";

		// openshift v2
		// url = "jdbc:mysql://127.8.115.130:3306/isoluciones";
		// username = "adminC31iRLU";
		// password = "1px-1md8nvWd";

		try {
			Class.forName(DB_driver);
		} catch (ClassNotFoundException cnfx) {
			// System.out.println("No se pudo cargar el Driver Correctamente!");
		}

		try {
			con = DriverManager.getConnection(url, username, password);
			con.setTransactionIsolation(8);

		} catch (Exception ex) {
			// ex.printStackTrace();
		}

	}

	// Constructor con parmetros
	Conexion(String driver, String url, String usuario, String passw) {
		this.DB_driver = driver;
		this.url = url;
		this.username = usuario;
		this.password = passw;

		// Asignacin del Driver
		try {
			Class.forName(DB_driver);
		} catch (ClassNotFoundException cnfx) {
			// System.out.println("No se pudo cargar el Driver Correctamente!");
		}
		// Realizar la conexin
		try {
			con = DriverManager.getConnection(url, username, password);
		} catch (Exception ex) {
			// ex.printStackTrace();
		}
	}

	// Retornar la conexin
	public Connection getConnection() {
		return con;
	}

	// Cerrar la conexin
	public void closeConnection(Connection con) {
		try {
			if (con != null) {
				con.close();
				// //System.out.println("cerró correctamente");
			}
		} catch (Exception ex) {
			// ex.printStackTrace();
		}
	}

	// Mtodo que devuelve un ResultSet de una consulta (tratamiento de SELECT)
	public ResultSet consultarBD(String sentencia) {
		try {
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sentencia);
		} catch (SQLException sqlex) {
			// sqlex.printStackTrace();
		} catch (RuntimeException rex) {
			// rex.printStackTrace();
		} catch (Exception ex) {
			// ex.printStackTrace();
		}

		return rs;
	}

	public ResultSet consultarBD2(String sentencia, String[] condiciones) {

		int numParam = condiciones.length;
		int posic = -1;
		int n = -1;
		pstmt = null;

		try {
			pstmt = con.prepareStatement(sentencia, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			// //System.out.println(sentencia);
			for (int i = 0; i <= numParam - 1; i++) {
				posic = sentencia.indexOf("?", posic + 1);
				n = sentencia.indexOf("LIKE", posic - 6);// Revisa si el operador es
				// like
				// //System.out.println("posic="+posic+" n="+n+" condicin:
				// "+condiciones[i]);
				if ((n < posic) && (n != -1)) {// ac es un 'like'
					pstmt.setString(i + 1, "%" + condiciones[i] + "%");
				} else {// ac es un '='
					pstmt.setString(i + 1, condiciones[i]);
				}
			}
			rs = pstmt.executeQuery();
		} catch (SQLException sqlex) {
			// sqlex.printStackTrace();
		} catch (RuntimeException rex) {
			// rex.printStackTrace();
		} catch (Exception ex) {
			// ex.printStackTrace();
		}
		return rs;
	}

	// Mtodo que realiza un INSERT y devuelve TRUE si la operacin fue existosa
	public boolean insertarBD(String sentencia) {
		try {
			stmt = con.createStatement();
			stmt.execute(sentencia);
		} catch (SQLException sqlex) {
			// System.out.println("ERROR RUTINA: " + sqlex);
			return false;
		} catch (RuntimeException rex) {
			// System.out.println("ERROR RUTINA: " + rex);
			return false;
		} catch (Exception ex) {
			// System.out.println("EXCEPCION: " + ex);
			return false;
		}
		return true;
	}

	public boolean insertarBD2(String tabla, Object[] valores) {

		String sentencia = new String();
		StringBuffer buffer = new StringBuffer();
		int numParam = valores.length;
		pstmt = null;

		buffer.append("INSERT INTO " + tabla + " VALUES (");
		for (int i = 0; i <= numParam - 2; i++) {
			buffer.append("?,");
		}
		buffer.append("?)");
		sentencia = buffer.toString();

		try {
			pstmt = con.prepareStatement(sentencia);
			for (int j = 0; j <= numParam - 1; j++) {
				if (valores[j] == null) { // El objeto es nulo
					pstmt.setNull(j + 1, 0);
				} else if (valores[j].getClass().getName().equals("java.lang.String")) {// Es
					String StringParam = (valores[j].toString());
					pstmt.setString(j + 1, StringParam);
				} else if (valores[j].getClass().getName().equals("java.lang.Integer")) {// Es
					Integer IntegerParam = new Integer(valores[j].toString());
					pstmt.setInt(j + 1, IntegerParam.intValue());
				} else if (valores[j].getClass().getName().equals("java.lang.Long")) {// Es
					pstmt.setLong(j + 1, ((Long) valores[j]).longValue());
				}
			}
			pstmt.executeUpdate();
		} catch (SQLException sqlex) {
			// System.out.println("ERROR RUTINA: " + sqlex);
			return false;
		} catch (RuntimeException rex) {
			// System.out.println("ERROR RUTINA: " + rex);
			return false;
		} catch (Exception ex) {
			// System.out.println("EXCEPCION: " + ex);
			return false;
		}
		return true;
	}

	// Insersin usando preparedStatements
	// caso especfico cuando se van a insertar algunos campos de una tabla
	public boolean insertarBD2(String tabla, String[] campos, Object[] valores) {

		String sentencia = new String();
		StringBuffer buffer = new StringBuffer();
		int n;
		int numParam = valores.length;
		pstmt = null;

		buffer.append("INSERT INTO " + tabla + " (");
		for (int j = 0; j <= numParam - 2; j++) {
			buffer.append(campos[j] + ",");
		}
		buffer.append(campos[numParam - 1] + ") values (");
		for (int i = 0; i <= numParam - 2; i++) {
			buffer.append("?,");
		}
		buffer.append("?);");
		sentencia = buffer.toString();

		try {
			pstmt = con.prepareStatement(sentencia);
			for (int j = 0; j <= numParam - 1; j++) {
				if (valores[j] == null) {
					pstmt.setNull(j + 1, 0);
				} else if (valores[j].getClass().getName().equals("java.lang.String")) {// Es

					pstmt.setString(j + 1, (String) valores[j]);
				} else if (valores[j].getClass().getName().equals("java.lang.Integer")) {// Es
					pstmt.setInt(j + 1, ((Integer) valores[j]).intValue());
				} else if (valores[j].getClass().getName().equals("java.lang.Long")) {// Es
					pstmt.setLong(j + 1, ((Long) valores[j]).longValue());
				}
			}
			n = pstmt.executeUpdate();
		} catch (SQLException sqlex) {
			// System.out.println("ERROR RUTINA: " + sqlex.getMessage());
			return false;
		} catch (RuntimeException rex) {
			// System.out.println("ERROR RUTINA: " + rex.getMessage());
			return false;
		} catch (Exception ex) {
			// System.out.println("EXCEPCION: " + ex.getMessage());
			return false;
		}
		return true;
	}

	public boolean actualizarBD(String sentencia) {
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sentencia);
		} catch (SQLException sqlex) {
			// System.out.println("ERROR RUTINA: " + sqlex);
			return false;
		} catch (RuntimeException rex) {
			// System.out.println("ERROR RUTINA: " + rex);
			return false;
		} catch (Exception ex) {
			// System.out.println("EXCEPCION: " + ex);
			return false;
		}
		return true;
	}

	public boolean actualizarBD2(String tabla, String[] campos, Object[] valores, String[][] condiciones) {

		String sentencia = new String();
		StringBuffer buffer = new StringBuffer();
		int numParam = valores.length;
		pstmt = null;
		buffer.append("UPDATE " + tabla + " SET ");
		for (int i = 0; i <= numParam - 1; i++) {
			if (i == 0) {
				buffer.append(campos[i] + "=?");
			} else {
				buffer.append("," + campos[i] + "=?");
			}
		}
		numParam = condiciones.length;
		for (int j = 0; j <= numParam - 1; j++) {
			if (j == 0) {
				buffer.append(" WHERE " + condiciones[j][0] + " = '" + condiciones[j][1] + "'");

			} else {
				buffer.append(" AND " + condiciones[j][0] + " = '" + condiciones[j][1] + "'");
			}
		}
		sentencia = buffer.toString();
		// System.out.println(sentencia);
		numParam = valores.length;
		try {
			pstmt = con.prepareStatement(sentencia);
			for (int j = 0; j <= numParam - 1; j++) {
				if (valores[j] == null) {
					pstmt.setNull(j + 1, 0);
				} else if (valores[j].getClass().getName().equals("java.lang.String")) {

					String StringParam = (valores[j].toString());
					pstmt.setString(j + 1, StringParam);
				} else if (valores[j].getClass().getName().equals("java.lang.Integer")) {
					Integer IntegerParam = new Integer(valores[j].toString());
					pstmt.setInt(j + 1, IntegerParam.intValue());
				} else if (valores[j].getClass().getName().equals("java.lang.Long")) {
					pstmt.setLong(j + 1, ((Long) valores[j]).longValue());
				}
			}
			if (pstmt.executeUpdate() == 0) {
				return false;
			}
		} catch (SQLException sqlex) {
			// System.out.println("ERROR RUTINA: " + sqlex);
			return false;
		} catch (RuntimeException rex) {
			// System.out.println("ERROR RUTINA: " + rex);
			return false;
		} catch (Exception ex) {
			// System.out.println("EXCEPCION: " + ex);
			return false;
		}
		return true;
	}

	public boolean executeBD(String sentencia) {
		try {
			stmt = con.createStatement();
			stmt.execute(sentencia);
		} catch (SQLException sqlex) {
			// System.out.println("ERROR RUTINA: " + sqlex);
			return false;
		} catch (RuntimeException rex) {
			// System.out.println("ERROR RUTINA: " + rex);
			return false;
		} catch (Exception ex) {
			// System.out.println("EXCEPCION: " + ex);
			return false;
		}
		return true;
	}

	public boolean setAutoCommitBD(boolean parametro) {
		try {
			con.setAutoCommit(parametro);
		} catch (SQLException sqlex) {
			// System.out.println("Error al configurar el autoCommit " +
			// sqlex.getMessage());
			return false;
		}
		return true;
	}

	public void cerrarConexion() {
		closeConnection(con);
	}

	public boolean commitBD() {
		try {
			con.commit();
			return true;
		} catch (SQLException sqlex) {
			// System.out.println("Error al hacer commit " + sqlex.getMessage());
			return false;
		}
	}

	public boolean rollbackBD() {
		try {
			con.rollback();
			return true;
		} catch (SQLException sqlex) {
			// System.out.println("Error al hacer rollback " + sqlex.getMessage());
			return false;
		}
	}

	public static void main(String[] args) {
		Conexion BD = new Conexion();
		ResultSet rs = BD.consultarBD("SELECT * FROM administradores");
		try {
			while (rs.next()) {
				// System.out.println(rs.getString(2));
			}
		} catch (Exception E) {
			// System.out.println(E.getMessage());
		}

	}
}
