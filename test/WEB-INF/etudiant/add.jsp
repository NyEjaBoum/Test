<!-- filepath: test/WEB-INF/etudiant/add.jsp -->
<!DOCTYPE html>
<html>
<head><meta charset="utf-8"><title>Ajout Etudiant</title></head>
<body>
  <h2>Ajouter un étudiant</h2>
  <!-- action utilise le context path pour être portable -->
  <form action="${pageContext.request.contextPath}/etudiant/add" method="post">
    <label>Nom: <input type="text" name="nom" /></label><br/>
    <label>Age: <input type="number" name="age" /></label><br/>
    <button type="submit">Ajouter</button>
  </form>
  <% String msg = (String) request.getAttribute("message"); %>
  <% if (msg != null) { %>
      <div class="alert"><%= msg %></div>
  <% } %>
</body>
</html>