package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Notas;
import model.Quesito;
import model.TotalNotas;
import persistence.ApuracaoDAOImpl;

/**
 * Servlet implementation class NotasQuesitos
 */
@WebServlet("/NotasQuesitos")
public class NotasQuesitos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NotasQuesitos() {
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
		// TODO Auto-generated method stub
		String botao = request.getParameter("botao");
		
		if ("buscaQuesito".equals(botao)) {
			String quesito = request.getParameter("combobox");
			List<Notas> lista = listaNotas(Integer.parseInt(quesito));
			request.getSession().setAttribute("NOTASQUESITO", lista);
			response.sendRedirect("./quesito.jsp");
		}
	}

	public List<Quesito> recebeQuesitos(){
		ApuracaoDAOImpl ap = new ApuracaoDAOImpl();
		return ap.buscaQuesitos();
	}
	
	public List<Notas> listaNotas(int quesito){
		ApuracaoDAOImpl ap = new ApuracaoDAOImpl();
		return ap.ntPorQuesito(quesito);
	}
	public List<TotalNotas> recebeTotal() {
		ApuracaoDAOImpl ap = new ApuracaoDAOImpl();
		return ap.recebeTotal();
	}
}
