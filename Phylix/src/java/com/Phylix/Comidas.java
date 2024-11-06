package com.Phylix;

public class Comidas {
    private int idComida;
    private String proteina;
    private String carbohidrato;
    private String vitamina;
    private String grasa;
    private int porcionProteina;
    private int porcionCarbohidrato;
    private int porcionVitamina;
    private int porcionGrasa;

    // Constructor
    public Comidas(int idComida, String proteina, String carbohidrato, String vitamina, String grasa, int porcionProteina, int porcionCarbohidrato, int porcionVitamina, int porcionGrasa) {
        this.idComida = idComida;
        this.proteina = proteina;
        this.carbohidrato = carbohidrato;
        this.vitamina = vitamina;
        this.grasa = grasa;
        this.porcionProteina = porcionProteina;
        this.porcionCarbohidrato = porcionCarbohidrato;
        this.porcionVitamina = porcionVitamina;
        this.porcionGrasa = porcionGrasa;
    }

    // Getters
    public int getIdComida() { return idComida; }
    public String getProteina() { return proteina; }
    public String getCarbohidrato() { return carbohidrato; }
    public String getVitamina() { return vitamina; }
    public String getGrasa() { return grasa; }
    public int getPorcionProteina() { return porcionProteina; }
    public int getPorcionCarbohidrato() { return porcionCarbohidrato; }
    public int getPorcionVitamina() { return porcionVitamina; }
    public int getPorcionGrasa() { return porcionGrasa; }
    
    
}
