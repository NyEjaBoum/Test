<%@ page import="java.util.Map" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Paramètres reçus</title>
</head>
<body>
    <h2>Paramètres reçus</h2>
    <%
        Map params = (Map) request.getAttribute("params");
        if (params != null && !params.isEmpty()) {
    %>
        <ul>
        <% for (Object k : params.keySet()) {
            Object v = params.get(k);
            if (v != null && v.getClass().isArray()) {
        %>
            <li><b><%= k %></b> : <%= Arrays.toString((Object[]) v) %></li>
        <%  } else { %>
            <li><b><%= k %></b> : <%= v %></li>
        <%  }
        } %>
        </ul>
    <%
        } else {
    %>
        <p style="color:red;">Aucun paramètre transmis</p>
    <%
        }
    %>
</body>
</html>