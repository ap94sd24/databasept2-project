<html>

<body>
    <table border="1"style="background-color:rgba(0,0,0,0.5);">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    // Load Oracle Driver class file
                    DriverManager.registerDriver
                        (new org.postgresql.Driver());
    
                    // Make a connection to the Oracle datasource "cse132b"
                    Connection conn = DriverManager.getConnection
 
                        ("jdbc:postgresql://localhost:5432/postgres", 
 
 
                            "postgres", "cse132b");

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Courses VALUES (?, ?)");

 
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("R_ID")));
 
                        pstmt.setString(2, request.getParameter("SUBJECTS"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Research");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>R_ID</th>
                        <th>SUBJECTS</th>
                        
                    </tr>
                    <tr>
                        <form action="research.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="R_ID" size="10"></th>
                            <th><input value="" name="SUBJECTS" size="10"></th>
       
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="research.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the Research ID, which is a number --%>
                            <td>
 
                                <input value="<%= rs.getInt("R_ID") %>" 
 
 
                                    name="R_ID" size="10">
                            </td>
    
                            <%-- Get the SUBJECTS --%>
                            <td>
                                <input value="<%= rs.getString("SUBJECTS") %>" 
                                    name="SUBJECTS" size="10">
                            </td>
    
                           
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="research.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 

                                value="<%= rs.getInt("R_ID") %>" name="R_ID">
 
 
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
