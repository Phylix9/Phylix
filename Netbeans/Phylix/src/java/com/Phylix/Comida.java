/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Phylix;

/**
 *
 * @author Abraham
 */
public class Comida {
    private int idComida;
    private String proteina;
    private String carbohidrato;
    private String vitamina;
    private String grasa;
    private int porcionProteina;
    private int porcionCarbohidrato;
    private int porcionVitamina;
    private int porcionGrasa;
    private String nombreDieta;
    private String diaComida;
    private int idUsuario;

    // Constructor
    public Comida(int idComida, String proteina, String carbohidrato, String vitamina, String grasa,
                  int porcionProteina, int porcionCarbohidrato, int porcionVitamina, int porcionGrasa,
                  String nombreDieta, String diaComida, int idUsuario) {
        this.idComida = idComida;
        this.proteina = proteina;
        this.carbohidrato = carbohidrato;
        this.vitamina = vitamina;
        this.grasa = grasa;
        this.porcionProteina = porcionProteina;
        this.porcionCarbohidrato = porcionCarbohidrato;
        this.porcionVitamina = porcionVitamina;
        this.porcionGrasa = porcionGrasa;
        this.nombreDieta = nombreDieta;
        this.diaComida = diaComida;
        this.idUsuario = idUsuario;
    }

    // Getters y setters (puedes generarlos automáticamente)
    public int getIdComida() { return idComida; }
    public String getProteina() { return proteina; }
    public String getCarbohidrato() { return carbohidrato; }
    public String getVitamina() { return vitamina; }
    public String getGrasa() { return grasa; }
    public int getPorcionProteina() { return porcionProteina; }
    public int getPorcionCarbohidrato() { return porcionCarbohidrato; }
    public int getPorcionVitamina() { return porcionVitamina; }
    public int getPorcionGrasa() { return porcionGrasa; }
    public String getNombreDieta() { return nombreDieta; }
    public String getDiaComida() { return diaComida; }
    public int getIdUsuario() { return idUsuario; }
}

