<%@ page import="java.util.List" %>
<%
    List etudiants = (List) request.getAttribute("etudiants");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    <p>Liste etudiant</p>
<%
    if (etudiants != null) {
        for (Object nom : etudiants) {
%>
            <p><%= nom %></p>
<%
        }
    } else {
%>
        <p style="color:red;">Aucun etudiant trouvé</p>
<%
    }
%>
</body>
</html>