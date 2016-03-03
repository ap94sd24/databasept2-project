<html>

<body>
    <table border="1" style="background-color:rgba(0,0,0,0.5);">
        <tr>
            <td valign="top" background: linear-gradient(to bottom, blue, white);>
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
                            "INSERT INTO Prereq_list VALUES (?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PREREQ_LIST_ID")));
                      
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

             <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the section attributes in the Section table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Prereq_LIST SET PREREQ_LIST_ID = ? WHERE PREREQ_LIST_ID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PREREQ_LIST_ID")));
                    
                        int rowCount = pstmt.executeUpdate();
                        
                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the section FROM the Section table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM PREREQ_LIST WHERE PREREQ_LIST_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PREREQ_LIST_ID")));
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
                    // the student attributes FROM the prereq table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM PREREQ_LIST");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Prereq ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="prereq_list.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PREREQ_LIST_ID" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="prereq_list.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the PREREQ_LIST_ID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PREREQ_LIST_ID") %>" 
                                    name="PREREQ_LIST_ID" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="prereq_list.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("PREREQ_LIST_ID") %>" name="PREREQ_LIST_ID">
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
