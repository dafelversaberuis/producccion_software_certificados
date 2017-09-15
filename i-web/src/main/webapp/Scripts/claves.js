function validarDocumento(correo) {
	if (document.getElementById('txtDocumentoI').value
			.replace(/^\s*|\s*$/g, "") == "") {
		alert('Digite primero su documento');
	} else {
		cargarAjaxEnvioClave(correo);

	}
}

	function nuevoAjax() {
		var xmlhttp = false;
		try {
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); // Creacion del
			// objeto
			// AJAX para navegadores
			// no IE.
		} catch (e) {
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); // Creacion
				// del
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

	function cargarAjaxEnvioClave(correo) {
		ajax = nuevoAjax();
		parametros = "d=" + document.getElementById('txtDocumentoI').value;
		url = "/i-web/claves/enviarClave.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleEnvio').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleEnvio').innerHTML = "";
					document.getElementById('detalleEnvio').style.background = "";
					document.getElementById('detalleEnvio').innerHTML = ajax.responseText;
					if (parseInt(document.getElementById('hdnExitoEnvio').value) == 1) {
						alert('SE HA ENVIADO UNA NUEVA CLAVE A SU CORREO ELECTRONICO. SI NO LO ENCUENTRA REVISE CARPETA SPAM O NO DESEADO.');
						if (confirm('DESEA IR  LA PAGINA PRINCIPAL?')) {
							document.form1.submit();
						}
					} else {
						alert('EL DOCUMENTO DIGITADO NO EXISTE EN LA BASE DE DATOS O PUEDE QUE USTED NO SE HAYA REGISTRADO EN NUESTRO SITIO');
					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleEnvio').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleEnvio').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded');
		ajax.send(parametros);
	}   
	
	function resetearClaveAdmin(correo,id) {
		
		
		if(confirm('VA A RESETEAR LA CLAVE DEL ADMINISTRADOR SELECCIONADO. SE LE PRESENTARAN DOS OPCIONES:CLAVE AUTOMATICA DE 4 DIGITOS O CREADA MANUALMENTE. SI DESE CONTINUAR HAGA CLIC EN ACEPTAR')){
		
			var claveManual = prompt(
					'SI DESEA ASIGNAR UNA CLAVE MANUAL, ESCRIBALA Y HAGA CLIC EN ACEPTAR. SI DESEA QUE SEA AUTOMATICA HAGA CLIC EN CANCELAR Y EL SISTEMA LO HACE DE FORMA ALEATORIA', '');	
		var m = 0;
		
		if(claveManual!=null && claveManual.replace(/^\s*|\s*$/g, "") != ""){
			m=1;
		}
			
		ajax = nuevoAjax();
		parametros = "correo=" + correo+"&id="+id+"&m="+m+"&c="+claveManual;
		url = "/i-web/enviarClaveAdministrador.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
					if (parseInt(document.getElementById('hdnExitoEnvio').value) == 1) {
						alert('SE HA ENVIADO UNA NUEVA CLAVE AL CORREO ELECTRONICO DEL ADMINISTRADOR. SI NO LO ENCUENTRA REVISE CARPETA SPAM O NO DESEADO.');
						
					} else {
						alert('ha ocurrido un error intente mas tarde');
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
				'application/x-www-form-urlencoded');
		ajax.send(parametros);
		
		}
	}	
