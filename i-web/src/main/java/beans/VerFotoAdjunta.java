package beans;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ver_foto_adjunta.jsp")
public class VerFotoAdjunta extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3419085511956753102L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {

			String id = request.getParameter("id");
			String n = request.getParameter("n");
			Object[] financiador = new AdministrarPublicaciones().getFinanciador(Integer.parseInt(id));

			byte[] bytes = null;
			if (n != null && n.equals("1")) {
				bytes = (byte[]) financiador[5];
			} else if (n != null && n.equals("2")) {
				bytes = (byte[]) financiador[6];
			} else if (n != null && n.equals("3")) {
				bytes = (byte[]) financiador[7];
			}

			/* Indicamos que la respuesta va a ser en formato PDF */

			response.setContentType("image/jpeg"); //siemrpe guardamos jpg
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);

			ouputStream.flush();
			ouputStream.close();

		} catch (Exception e) {
			// out.println("NO SE PUEDE MOSTRAR EL CERTIFICADO");
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
}
