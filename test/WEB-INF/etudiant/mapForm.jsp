<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Test Map - Formulaire</title>
</head>
<body>
    <h2>Formulaire de test (Map<String,Object>)</h2>
    <form action="${pageContext.request.contextPath}/etudiant/map/123" method="get">
        <label>Nom: <input type="text" name="nom" value="Jean" /></label><br/>
        <label>Age: <input type="number" name="age" value="25" /></label><br/>
        <label>Hobbies: 
            <input type="checkbox" name="hobbies" value="lecture" checked /> Lecture
            <input type="checkbox" name="hobbies" value="sport" /> Sport
            <input type="checkbox" name="hobbies" value="musique" /> Musique
        </label><br/>
        <button type="submit">Envoyer</button>
    </form>
    <p>
        <b>URL cible :</b> <code>/etudiant/map/123</code> (idTest = 123)<br>
        <i>Les paramètres seront injectés dans le Map <code>allParams</code> du contrôleur.</i>
    </p>
</body>
</html>