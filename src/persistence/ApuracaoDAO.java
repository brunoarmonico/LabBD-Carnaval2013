package persistence;

import java.util.List;
import model.Notas;
import model.NovaNota;
import model.Quesito;
import model.TotalNotas;

public interface ApuracaoDAO {
	
	public String enviaNota(NovaNota nota);
	public List <Notas> recebeNotas();
	public String[] proximaNota(int que, int esc, int jur);
	public List<Quesito> buscaQuesitos();
	public List<Notas> ntPorQuesito(int quesito);
	public List<TotalNotas> recebeTotal();
}
