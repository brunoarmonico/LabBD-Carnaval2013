package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDAOImpl { 
	
	private static GenericDAOImpl instancia;
	private Connection con;
	
	public GenericDAOImpl() {
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:jtds:sqlserver://127.0.0.1:1433;DatabaseName=Carnaval2013;namedPipes=true;user=teste123;password=123456");
			System.out.println("logado");
		} 
		catch (SQLException e) {
			
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
	}
	public static GenericDAOImpl getInstance() {
		
		if (instancia == null) {
			
			instancia = new GenericDAOImpl();
		}
		return instancia;
	}
	public Connection getConnection() {
		
		return con;
	}
}
