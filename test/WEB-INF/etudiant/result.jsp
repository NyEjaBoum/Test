<%@ page import="models.Etudiant,models.Departement,models.Sexe,java.util.List" %>
<%
    Etudiant etu = (Etudiant) request.getAttribute("etudiant");
    Departement dep = (Departement) request.getAttribute("departement");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Résultat</title>
</head>
<body>
    <h2>Résultat du binding automatique</h2>
    <h3>Etudiant</h3>
    <ul>
        <li>Nom: <%= etu != null ? etu.getNom() : "" %></li>
        <li>Age: <%= etu != null ? etu.getAge() : "" %></li>
        <li>Sexe: <%= (etu != null && etu.getS() != null) ? etu.getS().getLabel() : "" %> (id: <%= (etu != null && etu.getS() != null) ? etu.getS().getId() : "" %>)</li>
        <li>Hobbies: <%= (etu != null && etu.getHobbies() != null) ? etu.getHobbies() : "" %></li>
    </ul>
    <h3>Département</h3>
    <ul>
        <li>Nom: <%= dep != null ? dep.getNom() : "" %></li>
        <li>Code: <%= dep != null ? dep.getCode() : "" %></li>
    </ul>
</body>
</html>