package beans;

public class RepositorioFotos {
  
	private int			idFoto;
	private String	fechaPublicacion;
	private String	direccionFoto;
	private int			idEgresado;
	private int			idAdministrador;
	private String	nombre;

	public RepositorioFotos() {

	}

	public int getIdFoto() {
		return this.idFoto;
	}

	public void setIdFoto(int idFoto) {
		this.idFoto = idFoto;
	}

	public String getFechaPublicacion() {
		return fechaPublicacion;
	}

	public void setFechaPublicacion(String fechaPublicacion) {
		this.fechaPublicacion = fechaPublicacion;
	}

	public String getDireccionFoto() {
		return this.direccionFoto;
	}

	public void setDireccionFoto(String direccionFoto) {
		this.direccionFoto = direccionFoto;
	}

	public int getIdEgresado() {
		return this.idEgresado;
	}

	public void setIdEgresado(int idEgresado) {
		this.idEgresado = idEgresado;
	}

	public int getIdAdministrador() {
		return this.idAdministrador;
	}

	public void setIdAdministrador(int idAdministrador) {
		this.idAdministrador = idAdministrador;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

}
