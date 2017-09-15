package beans;

import java.sql.ResultSet;
import java.sql.SQLException;
  
public class Seguridad {

	public Usuario registrarSesion(String aDocumento, String aClave, int aTipoUsuario) {
		Conexion conexion = new Conexion();
		Usuario usuario = new Usuario();
		if (aTipoUsuario == 1) {
			ResultSet rs = conexion.consultarBD("SELECT * FROM egresados WHERE documento ='" + aDocumento + "' AND clave=(\"" + aClave + "\") AND registrado_actualmente=1");
			try {
				if (rs.next()) {
					usuario.setCodigo(rs.getString(2));
					usuario.setDocumento(rs.getString(7));
					usuario.setIdUsuario(rs.getInt(1));

					usuario.setPrimerApellido(rs.getString(5));
					usuario.setPrimerNombre(rs.getString(3));
					usuario.setSegundoApellido(rs.getString(6));
					usuario.setSegundoNombre(rs.getString(4));
					usuario.setTipoUsuario(aTipoUsuario);

				}
				rs.close();
			} catch (SQLException e) {
				//e.printStackTrace();
			} finally {
				conexion.cerrarConexion();
			}
		} else {
			ResultSet rs = conexion.consultarBD("SELECT * FROM administradores WHERE documento ='" + aDocumento + "' AND clave=(\"" + aClave + "\")");
			try {
				if (rs.next()) {
					usuario.setCodigo(null);
					usuario.setDocumento(rs.getString(6));
					usuario.setIdUsuario(rs.getInt(1));
					usuario.setPrimerApellido(rs.getString(4));
					usuario.setPrimerNombre(rs.getString(2));
					usuario.setSegundoApellido(rs.getString(5));
					usuario.setSegundoNombre(rs.getString(3));
					usuario.setTipoUsuario(aTipoUsuario);

				}
				rs.close();
			} catch (SQLException e) {
				//e.printStackTrace();
			} finally {
				conexion.cerrarConexion();
			}
		}
		return usuario;

	}

	public Integer consultarExistenciaUsuario(String aDocumento, String aClave, String aRol) {
		Integer sw = 0; // 0: no existe usuario, 1:solo egresado, 2:admin
		Conexion conexion = new Conexion();
		try {
		
				ResultSet rs2 = conexion.consultarBD("SELECT documento FROM administradores WHERE documento='" + aDocumento + "' AND clave=(\"" + aClave + "\")");
				try {
					if (rs2.next()) {
						sw = 2;
					}
					rs2.close();
				} catch (Exception e) {
					//e.printStackTrace();
				}
		

		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return sw;
	}

	public static void main(String[] args) {

	}
}
