package model;

public class Notas {
	private int id;
	private double nota;
	private int id_jurado;
	private String nome_jurado;
	private int id_escola;
	private String nome_escola;
	private int id_quesito;
	private String nome_quesito;
	private boolean descarte;
	
	public boolean getDescarte() {
		return descarte;
	}
	public void setDescarte(boolean descarte) {
		this.descarte = descarte;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getNota() {
		return nota;
	}
	public void setNota(double nota) {
		this.nota = nota;
	}
	public int getId_jurado() {
		return id_jurado;
	}
	public void setId_jurado(int id_jurado) {
		this.id_jurado = id_jurado;
	}
	public String getNome_jurado() {
		return nome_jurado;
	}
	public void setNome_jurado(String nome_jurado) {
		this.nome_jurado = nome_jurado;
	}
	public int getId_escola() {
		return id_escola;
	}
	public void setId_escola(int id_escola) {
		this.id_escola = id_escola;
	}
	public String getNome_escola() {
		return nome_escola;
	}
	public void setNome_escola(String nome_escola) {
		this.nome_escola = nome_escola;
	}
	public int getId_quesito() {
		return id_quesito;
	}
	public void setId_quesito(int id_quesito) {
		this.id_quesito = id_quesito;
	}
	public String getNome_quesito() {
		return nome_quesito;
	}
	public void setNome_quesito(String nome_quesito) {
		this.nome_quesito = nome_quesito;
	}

}
