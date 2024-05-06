<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage MongoDB Instances</title>
</head>
<style>
    body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
}

.container {
    width: 50%;
    margin: 0 auto;
}

h1 {
    text-align: center;
    margin-top: 50px;
}

ul {
    list-style-type: none;
    padding: 0;
}

li {
    margin-bottom: 10px;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

form input[type="text"],
form input[type="number"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
}

form input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

form input[type="submit"]:hover {
    background-color: #0056b3;
}

</style>
<body>
    <h1>Connected MongoDB Instances</h1>
    <ul>
        <% 
        List<MongoDBInstance> instances = (List<MongoDBInstance>) request.getAttribute("instances");
        if (instances != null) {
            for (MongoDBInstance instance : instances) {
        %>
            <li><%= instance.getHost() %>:<%= instance.getPort() %></li>
        <%
            }
        }
        %>
    </ul>
    <form action="ManageInstanceServlet" method="post">
        Host: <input type="text" name="host" required><br>
        Port: <input type="number" name="port" required><br>
        <input type="submit" value="Add Instance">
    </form>
</body>
</html>
