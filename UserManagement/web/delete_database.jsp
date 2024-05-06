<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>

<%
    String dbName = request.getParameter("dbName");

    try {
        // Connect to MongoDB
        MongoClient mongoClient = MongoClients.create();
        // Drop database
        mongoClient.dropDatabase(dbName);
        // Close MongoDB connection
        mongoClient.close();

        response.sendRedirect("manage-databases.jsp");
    } catch (Exception e) {
        // Handle exception
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
%>
