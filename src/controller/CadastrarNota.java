package controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Notas;
import model.NovaNota;
import model.Quesito;
import persistence.ApuracaoDAOImpl;

/**
 * Servlet implementation class CadastrarNota
 */
@WebServlet("/CadastrarNota")
public class CadastrarNota extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CadastrarNota() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opc =  request.getParameter("prButton");
		
		if ("enviarNota".equals(opc)) {
			String idEscola = request.getParameter("escola");
			String idQuesito = request.getParameter("quesito");
			String idJurado = request.getParameter("jurado");
			String nNota = request.getParameter("nota");
			
			NovaNota nota = new NovaNota();
			nota.setId_escola(Integer.parseInt(idEscola));
			nota.setId_quesito(Integer.parseInt(idQuesito));
			nota.setId_jurado(Integer.parseInt(idJurado));
			try {
			nota.setNota(Double.parseDouble(nNota));
			ApuracaoDAOImpl ap = new ApuracaoDAOImpl();
			ap.enviaNota(nota);
			response.sendRedirect("./Pagina.jsp");
			} catch (NumberFormatException e) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("./Pagina.jsp");
				dispatcher.forward(request, response);
			}
		}
		
		if ("verQuesito".equals(opc)) {
			response.sendRedirect("./quesito.jsp");
		}
		if ("verTotal".equals(opc)) {
			response.sendRedirect("./total.jsp");
		}
	}
	
	public List<Notas> recebeNotas() {
		ApuracaoDAOImpl ap = new ApuracaoDAOImpl();
		return ap.recebeNotas();	
	}
	
	public String[] proximaNota(int que, int esc, int jur) {
		ApuracaoDAOImpl ap = new ApuracaoDAOImpl();
		return ap.proximaNota(que, esc, jur);
		
	}

}
