package etudiant;

import framework.annotation.*;
import java.util.ArrayList;
import java.util.List;
import framework.view.ModelView;

@Controller(value = "/etudiant")
public class EtudiantController {
    @Url(value = "/{id}")
    public String get(int id) {
        return "Etudiant id = " + id;
    }

    @Url(value = "/form")
    public ModelView form(){
        ModelView mv = new ModelView();
        mv.setView("WEB-INF/etudiant/add.jsp");
        return mv;
    }

    @Url(value = "/add")
    public String add(@ParametreRequete("nom") String nom,
                      @ParametreRequete("age") int age) {
        // traiter (sauvegarde, validation, etc.)
        return "Ajout OK: " + nom + " (" + age + ")"; // renvoie texte simple
    }


    @Url(value = "/list")
    public ModelView list() {
        List<String> etudiants = new ArrayList<>();
        etudiants.add("Etudiant 1");
        etudiants.add("Etudiant 2");
        etudiants.add("Etudiant 3");

        ModelView mv = new ModelView();
        mv.setView("WEB-INF/etudiant/list.jsp");
        mv.addAttribute("etudiants", etudiants); // "etudiants" sera l'attribut dans la requête
        return mv;
    }
}