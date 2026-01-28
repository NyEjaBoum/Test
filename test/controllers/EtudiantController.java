package controllers;

import framework.annotation.*;
import java.util.ArrayList;
import java.util.List;
import framework.view.ModelView;
import java.util.Map;
import models.Etudiant;
import models.Departement;
import framework.servlet.FileUploadUtil;

@Controller(value = "/etudiant")
public class EtudiantController {

    @GetMethod("/test-session")
    public ModelView testSession(@Session Map<String, Object> session) {
        // Ajout d'une variable de session
        session.put("testKey", "valeur test");

        // Suppression d'une variable de session (exemple)
        session.remove("toRemove");

        // Lecture d'une variable de session
        Object user = session.get("user");

        ModelView mv = new ModelView();
        mv.setView("WEB-INF/etudiant/result.jsp");
        mv.setMessage("Session testée. user=" + user + ", testKey=" + session.get("testKey"));
        mv.addAttribute("session", session); // Pour afficher tout le contenu si besoin
        return mv;
    }

    @GetMethod("/upload-form")
    public ModelView uploadForm() {
        ModelView mv = new ModelView();
        mv.setView("WEB-INF/etudiant/uploadForm.jsp");
        return mv;
    }

@PostMethod("/upload")
public ModelView upload(Map<String, byte[]> fileMap, jakarta.servlet.http.HttpServletRequest request) {
    ModelView mv = new ModelView();
    mv.setView("WEB-INF/etudiant/result.jsp");
    if (fileMap != null && !fileMap.isEmpty()) {
        try {
            String uploadDir = "WEB-INF/upload";
            String realPath = request.getServletContext().getRealPath("/" + uploadDir);
            System.out.println("DEBUG realPath = " + realPath); // <-- Ajoute ce log
            int nb = framework.servlet.FileUploadUtil.saveFiles(fileMap, realPath);
            mv.setMessage(nb + " fichier(s) enregistré(s) dans " + uploadDir);
        } catch (Exception ex) {
            ex.printStackTrace();
            mv.setMessage("Erreur lors de l'enregistrement : " + ex.getMessage());
        }
    } else {
        mv.setMessage("Aucun fichier reçu");
    }
    return mv;
}

    @PostMethod("/save")
    public ModelView save(Etudiant etudiant, Departement departement) {
        ModelView mv = new ModelView();
        mv.setView("WEB-INF/etudiant/result.jsp");
        mv.addAttribute("etudiant", etudiant);
        mv.addAttribute("departement", departement);
        return mv;
    }

    @GetMethod("/save-form")
    public ModelView saveForm() {
        ModelView mv = new ModelView();
        mv.setView("WEB-INF/etudiant/saveForm.jsp");
        return mv;
    }

    @GetMethod("/api/etudiants")
    @Json
    public List<String> listApi() {
        // retourne une liste d'objets Etudiant
        List<String> etudiants = new ArrayList<>();
        etudiants.add("Etudiant 1");
        etudiants.add("Etudiant 2");
        etudiants.add("Etudiant 3");
        return etudiants;
    }

    // @GetMethod("/map-form")
    // public ModelView mapForm() {
    //     ModelView mv = new ModelView();
    //     mv.setView("WEB-INF/etudiant/mapForm.jsp"); // Crée mapForm.jsp avec le formulaire
    //     return mv;
    // }

    // @GetMethod("/map/{idTest}")
    // public ModelView testMap(
    //     Map<String, Object> allParams,
    //     @VariableChemin("idTest") Integer id
    // ) {
    //     ModelView mv = new ModelView();
    //     mv.setView("WEB-INF/etudiant/testMap.jsp");
    //     mv.setMessage("idTest=" + id);
    //     mv.addAttribute("params", allParams); // Pour affichage dans la JSP
    //     mv.addAttribute("idTest", id); // Ajouté : afficher aussi le path param dans la vue
    //     return mv;
    // }

    // @GetMethod("/form")
    // public ModelView form() {
    //     ModelView mv = new ModelView();
    //     mv.setView("WEB-INF/etudiant/add.jsp");
    //     return mv;
    // }

    // @PostMethod("/add")
    // public ModelView add(
    //     @ParametreRequete("nom") String nom,
    //     @ParametreRequete("age") int age
    // ) {
    //     // traiter (sauvegarde, validation, etc.)
    //     ModelView mv = new ModelView();
    //     mv.setView("WEB-INF/etudiant/add.jsp"); // revient sur le formulaire
    //     mv.setMessage("Ajout OK: " + nom + " (" + age + ")");
    //     return mv;
    // }

    // @GetMethod("/{id}/note/{noteId}")
    // public String detail(
    //     @VariableChemin("id") Integer idEtudiant,
    //     @VariableChemin(value = "noteId", required = false) Integer idNote
    // ) {
    //     return "idEtudiant=" + idEtudiant + ", idNote=" + idNote;
    // }

    // @GetMethod("/{id}")
    // public String get(
    //     @VariableChemin("id") int id,
    //     @ParametreRequete(value = "format", required = false) String format
    // ) {
    //     return "id=" + id + ", format=" + format;
    // }

    // @GetMethod("/list")
    // public ModelView list() {
    //     List<String> etudiants = new ArrayList<>();
    //     etudiants.add("Etudiant 1");
    //     etudiants.add("Etudiant 2");
    //     etudiants.add("Etudiant 3");

    //     ModelView mv = new ModelView();
    //     mv.setView("WEB-INF/etudiant/list.jsp");
    //     mv.addAttribute("etudiants", etudiants);
    //     return mv;
    // }


}