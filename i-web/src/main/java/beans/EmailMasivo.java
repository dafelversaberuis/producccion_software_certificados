package beans;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailMasivo {
 
	private static final String	SMTP_HOST_NAME	= "smtp.gmail.com";
	private static final int		SMTP_HOST_PORT	= 465;
	private static final String	SMTP_AUTH_USER	= "cintrop.ginem@gmail.com";
	private static final String	SMTP_AUTH_PWD		= "meli0523";

	public static void main(String[] args) throws Exception {

	}

	public void enviarEmail(String asunto, String mensaje, List<Egresado> destinatarios) throws Exception {
		int total = 0;
		int cuenta = 0;
		String validador = new String();
		int totalidad = 0;
		if (destinatarios.size() < 90) {
			totalidad = destinatarios.size() - 1;
		} else {
			totalidad = 89;
		}

		while (total < destinatarios.size()) {

			List<Address> correos = new ArrayList<Address>();
			Properties props = new Properties();
			props.put("mail.transport.protocol", "smtps");
			props.put("mail.smtps.host", SMTP_HOST_NAME);
			props.put("mail.smtps.auth", "true");
			props.put("mail.smtps.quitwait", "false");
			Session mailSession = Session.getDefaultInstance(props);

			while (cuenta <= totalidad) {

				validador = destinatarios.get(total).getCorreo();
				if (validador == null || validador.equals("")) {
					validador = "destinoIncorrecto@incorrecto.com";
				}
				correos.add(new InternetAddress(validador));
				total++;
				cuenta++;

			}
			cuenta = 0;
			MimeMessage message = new MimeMessage(mailSession);
			message.setSubject(asunto, "UTF-8");

			// con texto html simple
			message.setContent(mensaje, "text/html; charset=UTF-8");

			message.setFrom(new InternetAddress(SMTP_AUTH_USER, "CINTROP-GINEM"));
			if (correos.size() > 0) {
				Address[] arrayDirecciones = correos.toArray(new Address[]{}); 
				
				message.addRecipients(Message.RecipientType.BCC, arrayDirecciones);
				mailSession.setDebug(true);
				Transport transport = mailSession.getTransport();

				transport.connect(SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);

				// transport.sendMessage(message,
				// message.getRecipients(Message.RecipientType.TO));

				transport.sendMessage(message, message.getRecipients(Message.RecipientType.BCC));

				transport.close();

			}

		}
	}

}