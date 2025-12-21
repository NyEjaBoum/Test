<%@ page import="java.util.Map, java.util.Set" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Résultat Upload</title>
    <style>
        body{font-family:Arial, sans-serif;margin:20px}
        .info{background:#eef;padding:12px;border-radius:6px;margin-bottom:10px}
        .error{color:#a00}
        ul.files{list-style:none;padding:0}
        ul.files li{padding:6px 0;border-bottom:1px solid #ddd}
    </style>
</head>
<body>
    <h2>Résultat de l'upload</h2>

    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
        <div class="info"><%= msg %></div>
    <% } %>

    <% 
        Map fileMap = (Map) request.getAttribute("fileMap");
        if (fileMap == null) { 
            // parfois le contrôleur met uniquement message ; tenter aussi de récupérer depuis l'attribut "files"
            fileMap = (Map) request.getAttribute("files");
        }
        if (fileMap != null && !fileMap.isEmpty()) { 
    %>
        <h3>Fichiers reçus :</h3>
        <ul class="files">
        <% for (Object k : fileMap.keySet()) { 
               Object v = fileMap.get(k);
               int size = -1;
               if (v instanceof byte[]) size = ((byte[])v).length;
        %>
            <li><b><%= k %></b> — taille : <%= (size >= 0 ? size + " octets" : "inconnue") %></li>
        <% } %>
        </ul>
    <% } else { %>
        <p>Aucun fichier détaillé disponible. Si vous souhaitez afficher les fichiers, retournez le Map depuis le contrôleur via <code>mv.addAttribute("fileMap", fileMap)</code>.</p>
    <% } %>

    <p>
        <a href="<%= request.getContextPath() %>/etudiant/upload-form">Retour au formulaire d'upload</a>
        &nbsp;|&nbsp;
        <a href="<%= request.getContextPath() %>/etudiant/save-form">Retour au formulaire save</a>
    </p>
</body>
</html>