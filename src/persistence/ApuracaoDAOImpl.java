package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Notas;
import model.NovaNota;
import model.Quesito;
import model.TotalNotas;

public class ApuracaoDAOImpl implements ApuracaoDAO {

	@Override
	public String enviaNota(NovaNota nota) {
		
		Connection con = GenericDAOImpl.getInstance().getConnection();
		String query = "{call adiciona_nota (?, ?, ?, ?, ?)}";
		String saida = null;
		try {
			
			CallableStatement ps = con.prepareCall(query);
			
			ps.setDouble(1, nota.getNota());
			ps.setInt(2, nota.getId_quesito());
			ps.setInt(3, nota.getId_jurado());
			ps.setInt(4, nota.getId_escola());
			ps.registerOutParameter(5, Types.VARCHAR);
			ps.execute();
			saida = (ps.getString(5));
			ps.close();
		}
		catch (Exception e) {
			
			e.printStackTrace();
		}
		//System.out.println(saida);
		return saida;
	}

	@Override
	public List<Notas> recebeNotas() {
		// TODO Auto-generated method stub
		List<Notas> lista =  new ArrayList<Notas>();
		Connection con = GenericDAOImpl.getInstance().getConnection();
		String query = "{call recebe_notas}";
		try {
			CallableStatement ps = con.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Notas notas = new Notas();
				notas.setId(rs.getInt("id_nota"));
				notas.setNota(rs.getDouble("nota"));
				notas.setId_escola(rs.getInt("id_escola"));
				notas.setNome_escola(rs.getString("nome_escola"));
				notas.setId_jurado(rs.getInt("id_jurado"));
				notas.setNome_jurado(rs.getString("nome_jurado"));
				notas.setId_quesito(rs.getInt("id_quesito"));
				notas.setNome_quesito(rs.getString("nome_quesito"));
				lista.add(notas);
			}
		} catch (SQLException e) {

		}
		
		return lista;
	}

	@Override
	public String[] proximaNota(int que, int esc, int jur) {
		Connection con = GenericDAOImpl.getInstance().getConnection();
		String query = "select * from fn_prnota (?, ?, ?)";
		String nomes[] = new String [3];
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, esc);
			ps.setInt(2, que);
			ps.setInt(3, jur);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				nomes[0] = rs.getString("quesito");
				nomes[1] = rs.getString("escola");
				nomes[2] = rs.getString("jurado");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return nomes;
	}

	@Override
	public List<Quesito> buscaQuesitos() {
		Connection con = GenericDAOImpl.getInstance().getConnection();
		String query = "select * from fn_pegar_quesitos ()";
		List<Quesito> lista = new ArrayList<Quesito>();
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Quesito q = new Quesito();
				q.setId(rs.getInt("id"));
				q.setNome(rs.getString("nome_quesito"));
				lista.add(q);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lista;
	}

	@Override
	public List<Notas> ntPorQuesito(int quesito) {
		Connection con = GenericDAOImpl.getInstance().getConnection();
		String query = "select * from fn_pesquisa_quesito (?)";
		List<Notas> lista = new ArrayList<Notas>();
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, quesito);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Notas nt = new Notas();
				nt.setNome_quesito(rs.getString("quesito"));
				nt.setNome_escola(rs.getString("escola"));
				nt.setNome_jurado(rs.getString("jurado"));
				nt.setNota(rs.getDouble("nota"));
				if (rs.getDouble("descarte") > 0){
					nt.setDescarte(true);
				} else {
					nt.setDescarte(false);
				}
				lista.add(nt);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lista;
	}

	@Override
	public List<TotalNotas> recebeTotal() {
		Connection con = GenericDAOImpl.getInstance().getConnection();
		String query = "select * from fn_pega_total()";
		List<TotalNotas> lista = new ArrayList<TotalNotas>();
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				TotalNotas nt = new TotalNotas();
				nt.setEscola(rs.getString("nome"));
				nt.setTotal(rs.getDouble("total"));
				lista.add(nt);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lista;
	}
	
}
