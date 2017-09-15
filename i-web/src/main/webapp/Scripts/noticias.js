var mensaje3 = "";

function cambiarFirmas(){
	if(document.getElementById('numero_firmas').value!="S"){
		document.getElementById('label_nombre_capacitador').style.display = "none";
		document.getElementById('nombre_capacitador').style.display = "none";
		document.getElementById('label_cargo_capacitador').style.display = "none";
		document.getElementById('cargo_capacitador').style.display = "none";
		document.getElementById('label_empresa_capacitador').style.display = "none";
		document.getElementById('empresa_capacitador').style.display = "none";

		}else{

			document.getElementById('label_nombre_capacitador').style.display = "block";
			document.getElementById('nombre_capacitador').style.display = "block";
			document.getElementById('label_cargo_capacitador').style.display = "block";
			document.getElementById('cargo_capacitador').style.display = "block";
			document.getElementById('label_empresa_capacitador').style.display = "block";
			document.getElementById('empresa_capacitador').style.display = "block";



			}
}


function enviarMasivo(admin) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/avisarCertificados.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleCorreos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Enviando correos espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleCorreos').innerHTML = "";
					document.getElementById('detalleCorreos').style.background = "";
					document.getElementById('detalleCorreos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnEnvio').value) == 1) {
						alert('CORREOS DE NOTIFICACION ENVIADOS CORRECTAMENTE');
						

					} else {
						alert('NO SE ENVIO CORREOS, PUEDE SER QUE NO EXITA DESTINATARIOS CON CORREOS VALIDOS');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleCorreos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleCorreos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	
}


function cargarEliminarTema(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR LA MEMORIA ASOCIADA AL CURSO/TEMA/EVENTO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarTema.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando tema del curso espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('LA MEMORIA ASOCIADA AL CURSO/TEMA/EVENTO FUE ELIMINADA CON EXITO');
						cargarTemas(curso);

					} else {
						alert('NO SE PUEDE LA MEMORIA ASOCIADA AL CURSO/TEMA/EVENTO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarArchivoTema(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR EL ARCHIVO DE LA MEMORIA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarArchivoTema.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando archivo espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('ARCHIVO ELIMINADO CON EXITO');
						cargarTemas(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR EL ARCHIVO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEditarTema(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/i-web/nuevaEdicionTema.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('MEMORIA EDITADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE EDITAR LA MEMORIA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function editarTema(id) {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el t�tulo de la memoria\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarEditarTema(id);

	} else {
		alert(mensaje);
	}

}



function cargarTemas(curso) {
	ajax = nuevoAjax();

	url = "/i-web/resultadosTemas.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}



function cargarCrearTema(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/i-web/nuevaCreacionTema.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('MEMORIA CREADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR LA MEMORIA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}



function nuevoTema(id) {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el t�tulo de la memoria\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearTema(id);

	} else {
		alert(mensaje);
	}

}


function cargarEliminarLogoFinanciador2(admin,n) {  

	if (confirm('REALMENTE DESEA ELIMINAR EL LOGO DEL CLIENTE?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin+"&n="+n;
		url = "/i-web/eliminarLogo.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando logo espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('LOGO DEL CLIENTE ELIMINADO CON EXITO');
						document.form1.submit();

					} else {
						alert('NO SE PUEDE ELIMINAR EL LOGO');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					// document.getElementById('detalleProcesos').innerHTML =
					// "-Error, contacte administrador";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}


function cargarEliminarLogoFinanciador(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL LOGO DEL CLIENTE?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarLogo.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando logo espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('LOGO DEL CLIENTE ELIMINADO CON EXITO');
						document.form1.submit();

					} else {
						alert('NO SE PUEDE ELIMINAR EL LOGO');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					// document.getElementById('detalleProcesos').innerHTML =
					// "-Error, contacte administrador";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}


function cargarEliminarFinanciador(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL CLIENTE ?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarFinanciador.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('CLIENTE ELIMINADO CON EXITO');
						cargarFinanciadores();

					} else {
						alert('NO SE PUEDE ELIMINAR EL CLIENTE PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					// document.getElementById('detalleProcesos').innerHTML =
					// "-Error, contacte administrador";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarCrearFinanciador() {
	ajax = nuevoAjax();
	parametros = "c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/i-web/nuevaCreacionFinanciador.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('CLIENTE CREADO CON EXITO');
					window.opener.cargarFinanciadores();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL CLIENTE');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function nuevoFinanciador() {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre del cliente\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearFinanciador();

	} else {
		alert(mensaje);
	}

}


function cargarFinanciadores() {
	ajax = nuevoAjax();
	url = "/i-web/resultadosFinanciadores.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}


function isEmailAddress3(theElement, nombre_del_elemento) {
	mensaje3 = "";
	var s = theElement.value;
	//var filter = /^[A-Za-z][A-Za-z0-9_]*@[A-Za-z0-9_]+\.[A-Za-z0-9_.]+[A-za-z]$/;
	//var filter = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	var filter = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
	if (s.length == 0)
		return true;
	if (filter.test(s))
		return true;
	else
		mensaje3 = "* INGRESE UNA CORREO ELECTRONICO VALIDO\n";
	theElement.focus();
	return false;
}

function isEmailAddress2(theElement, nombre_del_elemento) {
	mensaje3 = "";
	var s = theElement.value;
	//var filter = /^[A-Za-z][A-Za-z0-9_]*@[A-Za-z0-9_]+\.[A-Za-z0-9_.]+[A-za-z]$/;
	//var filter = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	var filter = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
	if (s.length == 0)
		return true;
	if (filter.test(s))
		return true;
	else
		mensaje3 = "* INGRESE UNA CORREO ELECTRONICO VALIDO\n";
	theElement.focus();
	return false;
}







function nuevoPortafolio() {

	var mensaje = "";

	if (document.getElementById('txtTitulo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL TITULO DEL SERVICIO\n";
	}
	
	if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL CONTENIDO DEL SERVICIO\n";
	}

	
	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearPortafolio();

	} else {
		alert(mensaje);
	}

}


function cargarCrearPortafolio() {
	ajax = nuevoAjax();
	parametros="t="+document.getElementById("txtTitulo").value+"&c="+document.getElementById("txtContenido").value;
	url = "/i-web/nuevaCreacionPortafolio.jsp";
	ajax.onreadystatechange = function() {       
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";  
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;
				
				if(parseInt(document.getElementById("hdnExito").value)==1){
					alert('SERVICIO DEL PORTAFOLIO CREADO CON EXITO');
					window.opener.cargarPortafolios();  
					try{window.opener.document.form1.submit();}catch(e){}
					window.close();
				}else{
					alert('NO SE PUEDE CREAR EL SERVICIO');
				}
				
				
				

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}



function nuevoAdmin() {

	var mensaje = "";

	if (document.getElementById('txtDocumento').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL DOCUMENTO DE IDENTIFICACION\n";
	}
	
	if (document.getElementById('txtNombre1').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL PRIMER NOMBRE\n";
	}

	if (document.getElementById('txtApellido1').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL PRIMER APELLIDO\n";
	}

	

	if (document.getElementById('txtCorreo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL CORREO ELECTRONICO\n";
	} else {
		
	
		isEmailAddress3(document.getElementById('txtCorreo'), 'txtCorreo');
		mensaje = mensaje + mensaje3;
		
		
		
	}

	
	var claveIncorrecta = 0;
	if (document.getElementById("txtClave").value == "") {
		mensaje = mensaje + "* DIGITE UNA NUEVA CLAVE\n";
		claveIncorrecta = 1;
	}
	if (claveIncorrecta == 0 && document.getElementById("txtClave2").value == "") {
		mensaje = mensaje + "* DEBE DIGITAR NUEVAMENTE LA CLAVE\n";
		claveIncorrecta = 2;
	}
	if (claveIncorrecta == 0 && document.getElementById("txtClave").value != document.getElementById("txtClave2").value) {
		mensaje = mensaje + "* LAS CLAVES NO COINCIDEN\n";
	} else {
		if (claveIncorrecta == 0 && document.getElementById("txtClave").value.length < 4) {
			mensaje = mensaje + "* LA CLAVE DEBE TENER POR LO MENOS 4 CARACTERES\n";
		}
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearAdmin();

	} else {
		alert(mensaje);
	}

}


function cargarCrearAdmin() {
	ajax = nuevoAjax();
	parametros="pn="+document.getElementById("txtNombre1").value+"&sn="+document.getElementById("txtNombre2").value+"&pa="+document.getElementById("txtApellido1").value+"&sa="+document.getElementById("txtApellido2").value+"&correo="+document.getElementById("txtCorreo").value+"&clave="+document.getElementById("txtClave").value+"&doc="+document.getElementById("txtDocumento").value;
	url = "/i-web/nuevaCreacion.jsp";
	ajax.onreadystatechange = function() {       
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";  
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;
				
				if(parseInt(document.getElementById("hdnExito").value)==1){
					alert('ADMINISTRADOR(A) CREADO CON EXITO');
					window.opener.cargarAdministradores();  
					try{window.opener.document.form1.submit();}catch(e){}
					window.close();
				}else{
					alert('NO SE PUEDE CREAR EL ADMINISTRADOR CON ESE DOCUMENTO');
				}
				
				
				

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function cargarAjaxGuardar() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value + "&pt=" + document.getElementById('txtTitulo').value + "&pc="
			+ document.getElementById('txtContenido').value + "&pd=" + document.getElementById('sltDirigido').value + "&pe="
			+ document.getElementById('hdnEgresado').value + "&pf=" + document.getElementById('hdnFoto').value + "&tu="
			+ document.getElementById('hdnTipoUs').value;
	

	
	url = "/i-web/guardarPublicacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleGuardar').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleGuardar').innerHTML = "";
				document.getElementById('detalleGuardar').style.background = "";
				document.getElementById('detalleGuardar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnGuardarPublicacion').value == 1) {
					alert('PUBLICACION GUARDADA CON EXITO');
					cargarPropias();
					if (confirm('DESEA REALIZAR UNA NUEVA PUBLICACION ?, DE SER ASI HAGA CLIC EN ACEPTAR')) {
						document.getElementById('detalleEgresado').innerHTML = "";
						document.getElementById('detalleEgresado2').innerHTML = "";

						document.getElementById('txtTitulo').value = "";
						document.getElementById('txtContenido').value = "";
						document.getElementById('sltDirigido').value = "2";
						removerFoto();

					}
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleGuardar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleGuardar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function cargarAjaxGuardarSeccion() {
	ajax = nuevoAjax();
	
	
	parametros = "pt=" + document.getElementById('txtTitulo').value + "&pc="
			+ document.getElementById('txtContenido').value + "&pd=" + document.getElementById('sltDirigido').value +"&pf=" + document.getElementById('hdnFoto').value;
	

	
	url = "/i-web/guardarSeccion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleGuardar').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleGuardar').innerHTML = "";
				document.getElementById('detalleGuardar').style.background = "";
				document.getElementById('detalleGuardar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnGuardarPublicacion').value == 1) {
					alert('SECCION ACTUALIZADA CON EXITO');
					
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleGuardar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleGuardar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function guardarSeccion() {
	var mensajes = "";
	
		
	var contenido = document.getElementById('txtContenido').value;
	
	document.getElementById('hdnGuardarPublicacion').value = "0";
	if (document.getElementById('txtTitulo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensajes = mensajes + " * DIGITE EL TITULO.\n";
		alert(mensajes);
		return;
	}

//	if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g, "") == "") {
//		mensajes = mensajes + " * DIGITE EL CONTENIDO.\n";
//	}

	


	if (mensajes != "") {
		//alert(mensajes);
	} else {
		document.getElementById('txtContenido').value = contenido;
		document.getElementById('hdnGuardarPublicacion').value = "1";
		document.form1.submit();
		//cargarAjaxGuardarSeccion();
	}

}


function guardarPublicacion() {
	var mensajes = "";
	var contenido = document.getElementById('txtContenido').value;
	if (document.getElementById('txtTitulo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensajes = mensajes + " * DIGITE EL TITULO.\n";
		alert(mensajes);
	}

//	if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g, "") == "") {
//		mensajes = mensajes + " * DIGITE EL CONTENIDO.\n";
//	}

	


//	if (mensajes != "") {
//		alert(mensajes);
//	} else {
//		
//		cargarAjaxGuardar();
//	}
//	
	
	
	
	
	if (mensajes != "") {
		//alert(mensajes);
	} else {
		document.getElementById('txtContenido').value = contenido;
		document.getElementById('hdnGuardarPublicacion').value = "1";
		document.form1.submit();
		//cargarAjaxGuardarSeccion();
	}
	
	
	
	

}

function removerFoto() {
	document.getElementById('detalleFoto1').innerHTML = "";
	document.getElementById('detalleFoto2').innerHTML = "";
	document.getElementById('hdnFoto').value = "";

}

function agregarFoto(foto) {

	// alert(foto);
	// temporalmente
	// foto = "publicacion.jpg";
	window.opener.document.getElementById('detalleFoto1').innerHTML = "<img src='/i-web/images/publicaciones/" + foto
			+ "' width='317' height='187' />";
	window.opener.document.getElementById('detalleFoto2').innerHTML = "<a class='current' href='#' onclick='removerFoto(); return false;'>(Remover imagen)</a><br>";
	window.opener.document.getElementById('hdnFoto').value = foto;
	window.close();

}

function buscarFoto() {
	window.open('/i-web/subirFotoPublicacion.jsp', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=400, height=300');
}

function escogerEgresado(egresado, registrado, nombre) {
	document.getElementById('hdnEgresado').value = "0";

	if (registrado == 1) {
		document.getElementById('hdnEgresado').value = egresado;
		document.getElementById('hdnNombreEgresado').value = nombre;

	}

}

function escogerEgresado2(egresado, registrado, nombre) {
	document.getElementById('hdnEgresado').value = egresado;
}

function aceptar() {
	if (document.getElementById('hdnEgresado').value == "-1") {
		alert('Escoja primero un egresado');
	} else {
		if (document.getElementById('hdnEgresado').value == "0") {
			alert('EL egresado escogido no se encuentra registrado en el portal, escoja otro');
		} else {
			try {

				window.opener.document.getElementById('hdnEgresado').value = document.getElementById('hdnEgresado').value;
				window.opener.document.getElementById('txtEgresado').value = document.getElementById('hdnNombreEgresado').value;
				window.close();
			} catch (e) {
				alert('La ventana que abri� este buscador fue cerrada o se cambi� la opci�n de egresado particular a otra, en la opci�n dirigido a: . Por favor verifique');
			}

		}
	}
}

function aceptar2Sugerido() {
	if (document.getElementById('hdnEgresado').value == "-1") {
		alert('Escoja primero un egresado');
	} else {
		cargarAjaxInvitarSugerido();
	}
}

function cargarAjaxInvitarSugerido() {
	ajax = nuevoAjax();
	var correoSugerido = prompt(
			'Sugi�ranos un correo del egresado a invitar y clic en aceptar, sino digita nada o cancela se enviar� al predeterminado', '');
	var ti = 0;
	if (correoSugerido != null && correoSugerido.replace(/^\s*|\s*$/g, "") != "") {
		ti = 2;
	} else {
		ti = 1;
	}
	parametros = "us=" + document.getElementById('hdnUs').value + "&usd=" + document.getElementById('hdnEgresado').value + "&ti=" + ti + "&correo="
			+ correoSugerido;
	url = "/i-web/invitarEgresados/enviarInvitacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleInvitacion').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Invitando egresado...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleInvitacion').innerHTML = "";
				document.getElementById('detalleInvitacion').style.background = "";
				document.getElementById('detalleInvitacion').innerHTML = ajax.responseText;
				if (parseInt(document.getElementById('hdnInvito').value) == 1) {
					alert('Perfecto ya el egresado ha sido invitado o contactado. Para ello se le ha enviado un correo electr�nico con el mensaje correspondiente (antes descrito)');
				} else {
					alert('Lamentablemente no se puede contactar el egresado ya que no posee un correo electr�nico actualizado, donde pueda contactarse');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleInvitacion').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleInvitacion').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function aceptar2() {
	if (document.getElementById('hdnEgresado').value == "-1") {
		alert('Escoja primero un egresado');
	} else {
		cargarAjaxInvitar();
	}
}

function cargarAjaxInvitar() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value + "&usd=" + document.getElementById('hdnEgresado').value + "&ti=0&correo=vacio";
	url = "/i-web/invitarEgresados/enviarInvitacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleInvitacion').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Invitando egresado...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleInvitacion').innerHTML = "";
				document.getElementById('detalleInvitacion').style.background = "";
				document.getElementById('detalleInvitacion').innerHTML = ajax.responseText;
				if (parseInt(document.getElementById('hdnInvito').value) == 1) {
					alert('Perfecto ya el egresado ha sido invitado o contactado. Para ello se le ha enviado un correo electr�nico con el mensaje correspondiente (antes descrito)');
				} else {
					alert('Lamentablemente no se puede contactar el egresado ya que no posee un correo electr�nico actualizado, donde pueda contactarse');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleInvitacion').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleInvitacion').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function nuevoAjax() {
	var xmlhttp = false;
	try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); // Creacion del objeto
		// AJAX para navegadores
		// no IE.
	} catch (e) {
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); // Creacion del
			// objet AJAX
			// para IE.
		} catch (E) {
			xmlhttp = false;
		}
	}

	if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
		xmlhttp = new XMLHttpRequest();
	}
	return xmlhttp;
}

function cargarAjaxEgresados() {
	ajax = nuevoAjax();
	parametros = "pn=" + document.getElementById('txtNombre1').value + "&sn=" + document.getElementById('txtNombre2').value + "&pa="
			+ document.getElementById('txtApellido1').value + "&sa=" + document.getElementById('txtApellido2').value;
	url = "/i-web/buscadores/resultadosEgresados.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleBusqueda').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Buscando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleBusqueda').innerHTML = "";
				document.getElementById('detalleBusqueda').style.background = "";
				document.getElementById('detalleBusqueda').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleBusqueda').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleBusqueda').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarAjaxEgresados2() {
	ajax = nuevoAjax();
	parametros = "pn=" + document.getElementById('txtNombre1').value + "&sn=" + document.getElementById('txtNombre2').value + "&pa="
			+ document.getElementById('txtApellido1').value + "&sa=" + document.getElementById('txtApellido2').value;
	url = "/i-web/buscadores/resultadosEgresados2.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleBusqueda').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Buscando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleBusqueda').innerHTML = "";
				document.getElementById('detalleBusqueda').style.background = "";
				document.getElementById('detalleBusqueda').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleBusqueda').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleBusqueda').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarAjaxEgresados3() {
	var continuar = 1;
	var mensaje = "";
	if (document.getElementById('txtAno').value.replace(/^\s*|\s*$/g, "") != ""
			&& document.getElementById('txtAno2').value.replace(/^\s*|\s*$/g, "") != "") {

		try {

			if (parseInt(document.getElementById('txtAno').value) > parseInt(document.getElementById('txtAno2').value)) {
				mensaje = mensaje + "* El a�o comienzo debe ser menor o igual al a�o fin\n";
			}

		} catch (e) {
			mensaje = mensaje + "* Error en las fechas\n";
		}

	}

	if (document.getElementById('lstPeriodo').value != "0" && document.getElementById('lstPeriodo2').value != "0") {

		try {

			if (parseInt(document.getElementById('lstPeriodo').value) > parseInt(document.getElementById('lstPeriodo2').value)) {
				mensaje = mensaje + "* El periodo comienzo debe ser menor o igual al periodo fin\n";
			}

		} catch (e) {
			mensaje = mensaje + "* Error en los periodos\n";
		}
	}

	if (mensaje == "") {
		// alert(document.getElementById('lstTipoEgresado').value);
		ajax = nuevoAjax();
		parametros = "pn=" + document.getElementById('txtNombre1').value + "&sn=" + document.getElementById('txtNombre2').value + "&pa="
				+ document.getElementById('txtApellido1').value + "&sa=" + document.getElementById('txtApellido2').value + "&sexo="
				+ document.getElementById('lstSexo').value + "&periodo=" + document.getElementById('lstPeriodo').value + "&ano="
				+ document.getElementById('txtAno').value + "&ano2=" + document.getElementById('txtAno2').value + "&periodo2="
				+ document.getElementById('lstPeriodo2').value + "&correo=" + document.getElementById('lstCorreo').value + "&te="
				+ document.getElementById('lstTipoEgresado').value;
		url = "/i-web/buscadores/resultadosEgresados3.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleBusqueda').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Generando listado...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleBusqueda').innerHTML = "";
					document.getElementById('detalleBusqueda').style.background = "";
					document.getElementById('detalleBusqueda').innerHTML = ajax.responseText;

				} else if (ajax.status == 404) {
					document.getElementById('detalleBusqueda').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleBusqueda').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		alert(mensaje);
	}
}

function cambiarDirigido() {
	document.getElementById('hdnEgresado').value = "0";
	if (document.getElementById('sltDirigido').value == "3") {
		document.getElementById('detalleEgresado').innerHTML = "<input name='txtEgresado' type='text' disabled='disabled' class='searchfield' id='txtEgresado' style='text-align: center' value='Busque un egresado en el logo(lupa)' />";
		document.getElementById('detalleEgresado2').innerHTML = "<img src='/i-web/images/buscar.png' width='32' height='32' class='none' style='width: 27px; height: 26px; cursor: hand'	onclick='buscarEgresado(); return false;' />";

	} else {
		document.getElementById('detalleEgresado').innerHTML = "";
		document.getElementById('detalleEgresado2').innerHTML = "";
	}

}

function buscarEgresado() {
	window.open('/i-web/buscadores/buscarEgresado.jsp', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, height=500');
}

function cargarEliminarArchivos(archivo, idarchivo) {
	ajax = nuevoAjax();
	parametros = "archivo=" + archivo + "&idarchivo=" + idarchivo;
	url = "/i-web/archivosPlanos/eliminarArchivoPlano.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando archivo espere un momento...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleProcesos').innerHTML = "";
				document.getElementById('detalleProcesos').style.background = "";
				document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById('hdnElimino').value) == 1) {
					alert('archivo eliminado con �xito');
					cargarPlanos();

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarEliminarPortafolio(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL SERVICIO DE SU PORTAFOLIO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarPortafolio.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando servicio espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('SERVICIO ELIMINADO CON EXITO');
						cargarPortafolios();

					} else {
						alert('NO SE PUEDE ELIMINAR EL SERVICIO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}


function cargarEliminarCertificado(admin) { 

	if (confirm('REALMENTE DESEA ELIMINAR EL CAPACITADO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarCertificado.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleLote').innerHTML = "";
					document.getElementById('detalleLote').style.background = "";
					document.getElementById('detalleLote').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('REGISTRO ELIMINADO CON EXITO');
						validarLoteConsulta();

					} else {
						alert('NO SE PUEDE ELIMINAR EL REGISTRO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}


function cargarEliminarAdministrador(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL ADMINISTRADOR?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarAdministrador.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando administrador espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('ADMINISTRADOR ELIMINADO CON EXITO');
						cargarAdministradores();

					} else {
						alert('NO SE PUEDE ELIMINAR EL ADMINISTRADOR PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarMigrarPlanos(idarchivo) {
	ajax = nuevoAjax();
	parametros = "idarchivo=" + idarchivo;
	url = "/i-web/archivosPlanos/migrarArchivoPlano.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Migrando egresados EISI UIS a la base de datos espere un momento...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleProcesos').innerHTML = "";
				document.getElementById('detalleProcesos').style.background = "";
				document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById('hdnMigro').value) > 0) {
					alert('Se migraron ' + document.getElementById('hdnMigro').value + " egresados EISI UIS a la base de datos");

				} else {
					alert('No se mirg� ning�n egresado EISI UIS a la base de datos');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarPrivadas() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value;
	url = "/i-web/notasPrivadasRecientes.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detallePrivadas').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detallePrivadas').innerHTML = "";
				document.getElementById('detallePrivadas').style.background = "";
				document.getElementById('detallePrivadas').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detallePrivadas').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detallePrivadas').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarPlanos() {
	ajax = nuevoAjax();
	url = "/i-web/archivosPlanos/resultadosPlanos.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleArchivos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Cargando informaci�n...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleArchivos').innerHTML = "";
				document.getElementById('detalleArchivos').style.background = "";
				document.getElementById('detalleArchivos').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleArchivos').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleArchivos').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}


function cargarPortafolios() {
	ajax = nuevoAjax();
	url = "/i-web/resultadosPortafolios.jsp";
	ajax.onreadystatechange = function() {   
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}


function cargarEliminarCurso(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL CURSO/TEMA/EVENTO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/i-web/eliminarCurso.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando curso espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('CURSO/TEMA/EVENTO ELIMINADO CON EXITO');
						cargarCursos();

					} else {
						alert('NO SE PUEDE ELIMINAR EL CURSO/TEMA/EVENTO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}



function editarCurso(id) {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el t�tulon";
	}



	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarEditarCurso(id);

	} else {
		alert(mensaje);
	}

}


function cargarEditarCurso(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
			
	url = "/i-web/nuevaEdicionCurso.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('CURSO/TEMA/EVENTO EDITADO CON EXITO');
					window.opener.cargarCursos();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE EDITAR EL CURSO/TEMA/EVENTO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function nuevoCurso() {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el t�tulo\n";
	}

	

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearCurso();

	} else {
		alert(mensaje);
	}

}

function cargarCrearCurso() {
	ajax = nuevoAjax();
	parametros = "c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
			
	url = "/i-web/nuevaCreacionCurso.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('TEMA/CURSO/EVENTO CREADO CON EXITO');
					window.opener.cargarCursos();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL TEMA/CURSO/EVENTO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function cargarCursos() {
	ajax = nuevoAjax();
	url = "/i-web/resultadosCursos.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}


function validarLoteConsulta2(){
	

	sw=0;

texto="";

	
texto+="*AUTORIZACION PARA EL TRATAMIENTO DE DATOS PERSONALES*";

texto+="\n\nYO MANIFIESTO QUE HE SIDO INFORMADO (A) POR LA ORGANIZACION S.A.S DE LO SIGUIENTE:";

texto+="\n\n1.  NUESTRA ORGANIZACION. RECOLECTARA, USARA Y TRATARA DATOS PERSONALES, CONFORME LA POLITICA DE TRATAMIENTO DE DATOS PERSONALES QUE HA IMPLEMENTADO Y ACTUARA COMO RESPONSABLE DEL TRATAMIENTO DE DATOS PERSONALES DE LOS CUALES SOY TITULAR.";
 
texto+="\n\n2. LOS DATOS PERSONALES QUE SE UTILIZAN SON: NOMBRES Y APELLIDOS, DOCUMENTO DE IDENTIDAD, DIRECCION DE CORREO ELECTRONICO.";
 
texto+="\n\n3. LOS DATOS PERSONALES RECOGIDOS SE UTILIZAN CON EL PROPOSITO DE (I) GENERAR CERTIFICACIONES DE LOS CURSOS/DIPLOMADOS/CAPACITACIONES SOBRE LOS CUALES SE HA CAPACITADO. (II)INFORMAR SOBRE NUESTRAS PROMOCIONES, OFERTAS, NOVEDADES Y SERVICIOS SOBRE LOS DISTINTOS CURSOS. (III) DAR CUMPLIMIENTO A OBLIGACIONES CONTRAIDAS CON NUESTROS CLIENTES (IV) EVALUAR LA CALIDAD DEL SERVICIO (VII) GESTIONAR TAREAS BASICAS DE ADMINISTRACION.";
 
texto+="\n\n4. MIS DERECHOS COMO TITULAR DE LOS DATOS SON LOS PREVISTOS EN LA CONSTITUCION Y LA LEY 1581 DE 2012, ESPECIALMENTE EL DERECHO A CONOCER, ACTUALIZAR, RECTIFICAR Y SUPRIMIR MI INFORMACION PERSONAL, ASI COMO EL DERECHO A REVOCAR EL CONSENTIMIENTO OTORGADO PARA EL TRATAMIENTO DE DATOS PERSONALES. LOS DERECHOS PUEDEN SER EJERCIDOS A TRAVES DE CANALES COMO LINEAS TELEFONICAS, CORREO ELECTRONICO, PAGINA WEB, REDES SOCIALES.";
	 
texto+="\n\n5. NUESTRA ORGANIZACION. GARANTIZA LA CONFIDENCIALIDAD, LIBERTAD, SEGURIDAD, VERACIDAD, TRANSPARENCIA DE LA INFORMACION, TENIENDO EN CUENTA LO ANTERIOR, AUTORIZO DE MANERA VOLUNTARIA, PREVIA, EXPLICITA, INFORMADA E INEQUIVOCA A  NUESTRA ORGANIZACION. PARA TRATAR MIS DATOS PERSONALES. LA INFORMACION OBTENIDA PARA EL TRATAMIENTO DE MIS DATOS PERSONALES LA HE SUMINISTRADO DE FORMA VOLUNTARIA Y ES VERIDICA.";

texto+="\n\nSI ESTA DE ACUERDO PRESIONE ***ACEPTAR*** DE LO CONTRARIO CANCELAR.";


	
	if((document.getElementById("documento_certificado").value.replace(/^\s*|\s*$/g, "")!="")){
		
		if(!(es_numeroCERTIFICADO(document.getElementById("documento_certificado").value.replace(/^\s*|\s*$/g, "")))){
			alert('EL DOCUMENTO DEBE SER NUMERICO');
			return false;
		}else{
			
			sw = 1;
		}
	}
	

	
	
	if(sw==1){
		
		if(confirm(texto)){
			cargarLotes2();
		}
		
			
		
	}else{
		
		alert('DEBE ESCRIBIR UN NUMERO DE DOCUMENTO');
		
	}
	
		
	
}


function validarLoteConsulta(){
	

	sw=0;
	if(document.getElementById("certificado").value!="0"){
		sw=1;
	}
	
	if(document.getElementById("nombre").value.replace(/^\s*|\s*$/g, "")!=""){
		sw=1;
	}
	
	if(document.getElementById("cliente").value.replace(/^\s*|\s*$/g, "")!=""){
		sw=1;
	}
	
	
	if(document.getElementById("consecutivo").value.replace(/^\s*|\s*$/g, "")!=""){
		sw=1;
	}
	
	
	
	
	if((document.getElementById("documento").value.replace(/^\s*|\s*$/g, "")!="")){
		
		if(!(es_numeroCERTIFICADO(document.getElementById("documento").value.replace(/^\s*|\s*$/g, "")))){
			alert('EL DOCUMENTO DEBE SER NUMERICO');
			return false;
		}else{
			
			sw = 1;
		}
	}
	

	
	if(document.getElementById("fecha_inicio").value.replace(/^\s*|\s*$/g, "")!=""){
		sw=1;
	}
	
	if(document.getElementById("fecha_fin").value.replace(/^\s*|\s*$/g, "")!=""){
		sw=1;
	}
	

	if(sw==1){
		cargarLotes();
		
		
	}else{
		
		alert('DEBE SELECCIONAR O DIGITAR AL MENOS UN CRITERIO DE CONSULTA');
		
	}
	
		
	
}


function cargarLotes2() {
	ajax = nuevoAjax();
	url = "/i-web/resultadosLotes2.jsp?d="+document.getElementById("documento_certificado").value.replace(/^\s*|\s*$/g, "");
	
	ajax.onreadystatechange = function() {   
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Cargando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = "";
			} else {
				document.getElementById('detalleLote').innerHTML = "";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}



function cargarLotes() {
	ajax = nuevoAjax();
	url = "/i-web/resultadosLotes.jsp?tc="+document.getElementById("certificado").value+"&n="+document.getElementById("nombre").value.replace(/^\s*|\s*$/g, "")+"&d="+document.getElementById("documento").value.replace(/^\s*|\s*$/g, "")+"&cli="+document.getElementById("cliente").value+"&con="+document.getElementById("consecutivo").value.replace(/^\s*|\s*$/g, "")+"&fi="+document.getElementById("fecha_inicio").value+"&ff="+document.getElementById("fecha_fin").value;
	
	ajax.onreadystatechange = function() {   
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}


function validarLoteExcel(){
	
	
	
	mensaje="";
	
	if(document.getElementById("etiqueta_capacitacion").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA EL FORMALISMO O ETIQUETA QUE PRECEDE AL CURSO/EVENTO/CERTIFICACION/TEMA\n";
	}
	
	if(document.getElementById("certificado").value=="0"){
		mensaje+= "* DEBE SELECCIONAR EL CURSO/TEMA/EVENTO\n";
	}
	
	if(document.getElementById("ciudad_curso").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA CIUDAD/DEPARTAMENTO DONDE SE HIZO LA CAPACITACION\n";
	}
	
	
	if(document.getElementById("numero_firmas").value=="0"){
		
		mensaje+= "* DEBE SELECCIONAR EL NUMERO DE FIRMAS\n";
		
	}else{
		
		if(document.getElementById("numero_firmas").value=="S"){
			
			if(document.getElementById("nombre_capacitador").value.replace(/^\s*|\s*$/g, "")==""){
				mensaje+= "* EL NOMBRE DE LA PERSONA DE LA SEGUNDA FIRMA ESTA VACIO\n";
			}
			
			if(document.getElementById("cargo_capacitador").value.replace(/^\s*|\s*$/g, "")==""){
				mensaje+= "* EL CARGO DE LA PERSONA DE LA SEGUNDA FIRMA ESTA VACIO\n";
			}
			
			if(document.getElementById("empresa_capacitador").value.replace(/^\s*|\s*$/g, "")==""){
				mensaje+= "* LA EMPRESA DE LA PERSONA DE LA SEGUNDA FIRMA ESTA VACIA\n";
			}
			
			
		}else{
			
			document.getElementById("nombre_capacitador").value ="";
			document.getElementById("cargo_capacitador").value ="";
			document.getElementById("empresa_capacitador").value ="";
			
			
		}
		
		
		
	}
	
	
	
	if(document.getElementById("horas_certificadas").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA EL NUMERO DE HORAS A CERTIFICAR\n";
	}else{
		
		
		if(parseInt(document.getElementById("horas_certificadas").value)<=0){
			mensaje+= "* EL NUMERO DE HORAS CERTIFICADAS DEBE SER MINIMO 1\n";
		}
		
	}
	
	if(document.getElementById("fecha_inicio").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA LA FECHA INICIO DE LA CAPACITACION\n";
	}
	
	
	
	if(document.getElementById("fecha_maxima").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA LA FECHA MAXIMA QUE ESTARA DISPONIBLE LA CERTIFICACION\n";
	}
	
	
	if(mensaje!=null && mensaje!=""){
		
		alert(mensaje);
		
	}else{
		
		cadena="";
		cadena = "etiqueta_capacitacion="+(document.getElementById("etiqueta_capacitacion").value.replace(/^\s*|\s*$/g, ""))+"&certificado="+encodeURIComponent(document.getElementById("certificado").value.replace(/^\s*|\s*$/g, ""))+"&ciudad_curso="+document.getElementById("ciudad_curso").value.replace(/^\s*|\s*$/g, "")+"&horas_certificadas="+encodeURIComponent(document.getElementById("horas_certificadas").value.replace(/^\s*|\s*$/g, ""))+"&fecha_inicio="+encodeURIComponent(document.getElementById("fecha_inicio").value.replace(/^\s*|\s*$/g, ""))+"&fecha_maxima="+encodeURIComponent(document.getElementById("fecha_maxima").value.replace(/^\s*|\s*$/g, ""))+"&cliente="+encodeURIComponent(document.getElementById("cliente").value.replace(/^\s*|\s*$/g, ""))+"&numero_firmas="+encodeURIComponent(document.getElementById("numero_firmas").value.replace(/^\s*|\s*$/g, ""))+"&nombre_capacitador="+(document.getElementById("nombre_capacitador").value.replace(/^\s*|\s*$/g, ""))+"&cargo_capacitador="+(document.getElementById("cargo_capacitador").value.replace(/^\s*|\s*$/g, ""))+"&empresa_capacitador="+(document.getElementById("empresa_capacitador").value.replace(/^\s*|\s*$/g, ""));
		
		window.open('/i-web/subirArchivoExcel.jsp?'+cadena, 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); 
	
	}
	
		
	
}



function validarLote(){
	
	
	
	mensaje="";
	
	if(document.getElementById("etiqueta_capacitacion").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA EL FORMALISMO O ETIQUETA QUE PRECEDE AL CURSO/EVENTO/CERTIFICACION/TEMA\n";
	}
	
	if(document.getElementById("certificado").value=="0"){
		mensaje+= "* DEBE SELECCIONAR EL CURSO/TEMA/EVENTO\n";
	}
	
	if(document.getElementById("ciudad_curso").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA CIUDAD/DEPARTAMENTO DONDE SE HIZO LA CAPACITACION\n";
	}
	
	
	if(document.getElementById("numero_firmas").value=="0"){
		
		mensaje+= "* DEBE SELECCIONAR EL NUMERO DE FIRMAS\n";
		
	}else{
		
		if(document.getElementById("numero_firmas").value=="S"){
			
			if(document.getElementById("nombre_capacitador").value.replace(/^\s*|\s*$/g, "")==""){
				mensaje+= "* EL NOMBRE DE LA PERSONA DE LA SEGUNDA FIRMA ESTA VACIO\n";
			}
			
			if(document.getElementById("cargo_capacitador").value.replace(/^\s*|\s*$/g, "")==""){
				mensaje+= "* EL CARGO DE LA PERSONA DE LA SEGUNDA FIRMA ESTA VACIO\n";
			}
			
			if(document.getElementById("empresa_capacitador").value.replace(/^\s*|\s*$/g, "")==""){
				mensaje+= "* LA EMPRESA DE LA PERSONA DE LA SEGUNDA FIRMA ESTA VACIA\n";
			}
			
			
		}
		
		
		
	}
	
	
	
	
	
	if(document.getElementById("numero_personas").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA EL NUMERO DE PERSONAS QUE RECIBIO CAPACITACION\n";
	}else{
		
		if(parseInt(document.getElementById("numero_personas").value)<=0){
			mensaje+= "* EL NUMERO DE PERSONAS CAPACITADAS DEBE SER MINIMO 1\n";
		}
		
		
	}
	
	if(document.getElementById("horas_certificadas").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA EL NUMERO DE HORAS A CERTIFICAR\n";
	}else{
		
		
		if(parseInt(document.getElementById("horas_certificadas").value)<=0){
			mensaje+= "* EL NUMERO DE HORAS CERTIFICADAS DEBE SER MINIMO 1\n";
		}
		
	}
	
	if(document.getElementById("fecha_inicio").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA LA FECHA INICIO DE LA CAPACITACION\n";
	}
	
	
	
	if(document.getElementById("fecha_maxima").value.replace(/^\s*|\s*$/g, "")==""){
		mensaje+= "* ESCRIBA LA FECHA MAXIMA QUE ESTARA DISPONIBLE LA CERTIFICACION\n";
	}
	
	

	
		
	
	validarFechas(mensaje);
	
		
	
}


function es_numeroCERTIFICADO(cadena)
{
	var longit = cadena.length;
	
	for(k=0;k<longit;k++)
	{
		var car = cadena.charAt(k);
		if ((car!='1') && (car!='2') && (car!='3') && (car!='4') && (car!='5') && (car!='6') && (car!='7') && (car!='8') && (car!='9') && (car!='0'))
			return false;
	}
	if (longit>0) return true;
	else return false;
}

function validarFechas(mensaje) {
	document.getElementById('hdnGuardarPublicacion').value = "0";
	ajax = nuevoAjax();
	url = "/i-web/validarFechas.jsp?fi="+document.getElementById("fecha_inicio").value+"&fm="+document.getElementById("fecha_maxima").value;
	ajax.onreadystatechange = function() {   
		if (ajax.readyState == 1) {
			document.getElementById('detalleFechas').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleFechas').innerHTML = "";
				document.getElementById('detalleFechas').style.background = "";
				document.getElementById('detalleFechas').innerHTML = ajax.responseText;
				
				
				sw=0;
				for(var i=1; i<=parseInt(document.getElementById("numero_personas").value); i++){
					

					if(document.getElementById("documento"+i).value.replace(/^\s*|\s*$/g, "")==""){
						sw=1;
						break;
					}else{
						if(!(es_numeroCERTIFICADO(document.getElementById("documento"+i).value.replace(/^\s*|\s*$/g, "")))){
							sw=1;
							break;
						}
						
						
					}
					
					
					if(document.getElementById("nombre"+i).value.replace(/^\s*|\s*$/g, "")==""){
						sw=1;
						break;
					}
					
					
					
				}
				
				if(sw==0){
					
					if(document.getElementById("fechas").value!=""){
						sw=1;
					}
					
					if(mensaje!=""){
						sw=1;
					}
					
				}
				
				
				if(sw==1){
					mensaje+= "* LOS DATOS DE TODAS LAS PERSONAS CAPACITADAS ESTAN INCOMPLETOS O SU DOCUMENTO NO ES NUMERICO (SIN COMAS NI PUNTOS)\n";
					mensaje= "SE ENCONTRO LAS SIGUIENTES INCONSISTENCIAS:\n\n"+ mensaje+document.getElementById("fechas").value;
					alert(mensaje);
					
				}else{
				
								sw=0;
								for(var i=1; i<=parseInt(document.getElementById("numero_personas").value); i++){
									
				
									
									
									if(document.getElementById("ciudad"+i).value.replace(/^\s*|\s*$/g, "")==""){
										//sw=1;
										//break;
									}
									
																		
									
								}
								
								
								if(sw==0){
									document.getElementById('hdnGuardarPublicacion').value = "1";
									document.form1.submit();
									
								}else{
									
									if(confirm('EXISTEN CORREOS SIN DILIEGENCIAR, DESEA CONTINUAR Y GUARDAR EL CERTIFICADO SIN ESTE ?')){
												document.getElementById('hdnGuardarPublicacion').value = "1";
												document.form1.submit();
									}
									
								}
								
								
								
								
				
				}
				
				
				
				
				
				

			} else if (ajax.status == 404) {
				document.getElementById('detalleFechas').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleFechas').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}



function cargarNuevoLote() {
	ajax = nuevoAjax();
	url = "/i-web/crearNuevoLote.jsp?n="+document.getElementById("numero_personas").value;
	ajax.onreadystatechange = function() {   
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleLote').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}


function cargarAdministradores() {
	ajax = nuevoAjax();
	url = "/i-web/resultadosAdministradores.jsp";
	ajax.onreadystatechange = function() {   
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarPropias() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value + "&tu=" + document.getElementById('hdnTipoUs').value;
	url = "/i-web/notasRealizadasUsuario.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detallePropias').innerHTML = "<img src='/i-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detallePropias').innerHTML = "";
				document.getElementById('detallePropias').style.background = "";
				document.getElementById('detallePropias').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detallePropias').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detallePropias').innerHTML = "-Error, contacte administrador";
			}
		}
	}
   
	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function cargarSeccion() {
	ajax = nuevoAjax();
	parametros = "id=" + document.getElementById('hdnSimulador').value;
	url = "/i-web/actualizacionSeccion.jsp";
	
	document.getElementById('btnAceptar').style.display = "none";
	document.getElementById('txtContenido').value ="";
	document.getElementById('txtContenido').style.display = "none";
	

	
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('pub1').innerHTML = "<img src='/i-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('pub1').innerHTML = "";
				document.getElementById('pub1').style.background = "";
				document.getElementById('pub1').innerHTML = ajax.responseText;
			
				document.getElementById('hdnSimulador').value = document.getElementById('sltDirigido').value;
				
				if(parseInt(document.getElementById('hdnSimulador').value)!=0){
							document.getElementById('txtContenido').value = document.getElementById('txtContenidoOculto').value;
							
							document.getElementById('btnAceptar').style.display = "block";
							
							alert(document.getElementById('txtContenidoOculto').value);
				}
			
				
				

			} else if (ajax.status == 404) {
				document.getElementById('pub1').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('pub1').innerHTML = "-Error, contacte administrador";
			}
		}
	} 
   
	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function recargarSeccion(){
	
	
	
	document.getElementById('hdnSimulador').value = document.getElementById('sltDirigido').value;
	// cargarSeccion();
	document.form1.submit();
	
}



function eliminarPublicacion(idPublicacion) {
	if (confirm('REALMENTE DESEA ELIMINAR LA PUBLICACION?')) {
		eliminarPropia(idPublicacion);

	}

}

function eliminarPropia2(idPublicacion) {
	ajax = nuevoAjax();
	parametros = "pub=" + idPublicacion;
	url = "/i-web/noticias/eliminarPublicacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleEliminar').innerHTML = "<img src='/i-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleEliminar').innerHTML = "";
				document.getElementById('detalleEliminar').style.background = "";
				document.getElementById('detalleEliminar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnEliminoPublicacion').value == 1) {
					alert('PUBLICACION ELIMINADA CON EXITO');
					cargarPrivadas();
				} else {
					alert('No se ha podido eliminar la publicaci�n, intente mas tarde');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleEliminar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleEliminar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function eliminarPublicacion2(idPublicacion) {
	if (confirm('Realmente desea eliminar la publicaci�n?')) {
		eliminarPropia2(idPublicacion);

	}

}

function eliminarPropia(idPublicacion) {
	ajax = nuevoAjax();
	parametros = "pub=" + idPublicacion;
	url = "/i-web/eliminarPublicacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleEliminar').innerHTML = "<img src='/i-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleEliminar').innerHTML = "";
				document.getElementById('detalleEliminar').style.background = "";
				document.getElementById('detalleEliminar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnEliminoPublicacion').value == 1) {
					alert('PUBLICACION ELIMINADA CON EXITO');
					cargarPropias();
				} else {
					alert('No se ha podido eliminar la publicaci�n, intente mas tarde');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleEliminar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleEliminar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}
