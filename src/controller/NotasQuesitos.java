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
       
    public NotasQuesitos() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String botao = request.getParameter("botao");
		//Realiza busca por quesito
		if ("buscaQuesito".equals(botao)) {
			String quesito = request.getParameter("combobox");
			List<Notas> lista = listaNotas(Integer.parseInt(quesito));
			request.getSession().setAttribute("NOTASQUESITO", lista);
			response.sendRedirect("./quesito.jsp");
		}
	}

	public List<Quesito> recebeQuesitos(){
		ApuracaoDAOImpl dao = new ApuracaoDAOImpl();
		return dao.buscaQuesitos();
	}
	
	public List<Notas> listaNotas(int quesito){
		ApuracaoDAOImpl dao = new ApuracaoDAOImpl();
		return dao.ntPorQuesito(quesito);
	}
	public List<TotalNotas> recebeTotal() {
		ApuracaoDAOImpl dao = new ApuracaoDAOImpl();
		return dao.recebeTotal();
	}
}
