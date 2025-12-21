package models;

import java.util.List;
import models.Sexe;

public class Etudiant {
    private String nom;
    private int age;
    private Sexe s;
    private List<String> hobbies;

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    public Sexe getS() { return s; }
    public void setS(Sexe s) { this.s = s; }
    public List<String> getHobbies() { return hobbies; }
    public void setHobbies(List<String> hobbies) { this.hobbies = hobbies; }
}