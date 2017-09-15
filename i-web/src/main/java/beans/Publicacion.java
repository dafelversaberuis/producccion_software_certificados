package beans;

public class Publicacion {
  
	private int			idPublicacion;
	private int			idEgresado;
	private int			idAdministrador;
	private int			privacidadPublicacion;
	private String	tituloPublicacion;
	private String	contenidoPublicacion;
	private String	direccionFotoPublicacion;
	private String	fecha;
	private int			receptor;
	private String	nombre;

	public Publicacion() {

	}

	public int getIdPublicacion() {
		return idPublicacion;
	}

	public void setIdPublicacion(int idPublicacion) {
		this.idPublicacion = idPublicacion;
	}

	public int getIdEgresado() {
		return idEgresado;
	}

	public void setIdEgresado(int idEgresado) {
		this.idEgresado = idEgresado;
	}

	public int getIdAdministrador() {
		return idAdministrador;
	}

	public void setIdAdministrador(int idAdministrador) {
		this.idAdministrador = idAdministrador;
	}

	public int getPrivacidadPublicacion() {
		return privacidadPublicacion;
	}

	public void setPrivacidadPublicacion(int privacidadPublicacion) {
		this.privacidadPublicacion = privacidadPublicacion;
	}

	public String getTituloPublicacion() {
		return tituloPublicacion;
	}

	public void setTituloPublicacion(String tituloPublicacion) {
		this.tituloPublicacion = tituloPublicacion;
	}

	public String getContenidoPublicacion() {
		return contenidoPublicacion;
	}

	public void setContenidoPublicacion(String contenidoPublicacion) {
		this.contenidoPublicacion = contenidoPublicacion;
	}

	public String getDireccionFotoPublicacion() {
		return direccionFotoPublicacion;
	}

	public void setDireccionFotoPublicacion(String direccionFotoPublicacion) {
		this.direccionFotoPublicacion = direccionFotoPublicacion;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public int getReceptor() {
		return receptor;
	}

	public void setReceptor(int receptor) {
		this.receptor = receptor;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

}
