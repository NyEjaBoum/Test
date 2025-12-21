<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Formulaire Etudiant/Departement</title>
</head>
<body>
    <h2>Formulaire Etudiant/Departement</h2>
    <form action="${pageContext.request.contextPath}/etudiant/save" method="post">
        <label>Nom: <input type="text" name="Etudiant.nom" /></label><br/>
        <label>Age: <input type="number" name="Etudiant.age" /></label><br/>
        <label>Sexe ID: <input type="number" name="Etudiant.s.id" /></label><br/>
        <label>Sexe Label: <input type="text" name="Etudiant.s.label" /></label><br/>
        <label>Hobbies: 
            <input type="checkbox" name="Etudiant.hobbies" value="sport" /> Sport
            <input type="checkbox" name="Etudiant.hobbies" value="musique" /> Musique
            <input type="checkbox" name="Etudiant.hobbies" value="lecture" /> Lecture
        </label><br/>
        <label>Département: <input type="text" name="Departement.nom" /></label><br/>
        <label>Code département: <input type="number" name="Departement.code" /></label><br/>
        <button type="submit">Envoyer</button>
    </form>
</body>
</html>