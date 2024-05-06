<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="com.mongodb.client.model.Filters" %>
<%@ page import="com.mongodb.client.model.Updates" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>

<%
String username = request.getParameter("first");
String enteredPassword = request.getParameter("password");

// Hash the entered password (you can use your hashPassword method if needed)
String hashedPassword = hashPassword(enteredPassword);

// MongoDB connection parameters
String connectionString = "mongodb://localhost:27017";
String dbName = "userManage";
String collectionName = "login";

try {
    // Connect to MongoDB
    MongoClient mongoClient = MongoClients.create(connectionString);
    MongoDatabase database = mongoClient.getDatabase(dbName);
    MongoCollection<Document> collection = database.getCollection(collectionName);

    // Find user in MongoDB
    Document query = new Document("username", username).append("password", hashedPassword);
    Document user = collection.find(query).first();

    if (user != null) {
        int enabled = user.getInteger("Enabled");
        String name = user.getString("name");

        if (enabled == 0) {
            System.out.println("User is not enabled.");
            response.sendRedirect("index.html");
        } else {
            // Authentication successful, set session attributes
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("name", name);

            // Redirect based on user role
            String role = user.getString("role");
            if ("admin".equals(role)) {
                response.sendRedirect("admin_dashboard.jsp");
            } else if ("student".equals(role)) {
                response.sendRedirect("User.jsp");
            } else {
                response.sendRedirect("index.html");
            }
        }
    } else {
        System.out.println("User not found or password does not match.");
        response.sendRedirect("index.html");
    }

    // Close MongoDB resources
    mongoClient.close();
} catch (Exception e) {
    // Handle exceptions (e.g., database errors)
    e.printStackTrace();
}
%>
<%!
private String hashPassword(String password) {
    try {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] bytes = md.digest(password.getBytes());

        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }

        return sb.toString();
    } catch (NoSuchAlgorithmException e) {
        return null;
    }
}
%>
