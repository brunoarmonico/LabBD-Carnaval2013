package model;

public class NovaNota {

	private double nota;
	private int id_jurado;
	private int id_escola;
	private int id_quesito;
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
	public int getId_escola() {
		return id_escola;
	}
	public void setId_escola(int id_escola) {
		this.id_escola = id_escola;
	}
	public int getId_quesito() {
		return id_quesito;
	}
	public void setId_quesito(int id_quesito) {
		this.id_quesito = id_quesito;
	}

}
