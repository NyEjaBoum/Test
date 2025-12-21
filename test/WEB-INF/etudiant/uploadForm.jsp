<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Upload Fichier</title>
</head>
<body>
    <h2>Test Upload Fichier</h2>
    <form action="${pageContext.request.contextPath}/etudiant/upload" method="post" enctype="multipart/form-data">
        <label>Choisir un fichier : <input type="file" name="monFichier" /></label><br/>
        <button type="submit">Envoyer</button>
    </form>
    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
        <div class="info"><%= msg %></div>
    <% } %>
</body>
</html>