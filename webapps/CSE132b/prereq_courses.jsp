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
                            "INSERT INTO PREREQ VALUES (?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("PREREQID")));
                        pstmt.setString(3, request.getParameter("P_COURSES"));
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
                            "UPDATE Prereq_courses SET PID = ?, PREREQID = ?, " +
                            "P_COURSES WHERE PID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("PREREQID")));
                        pstmt.setString(3, request.getParameter("P_COURSES"));
                  
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
                            "DELETE FROM Prereq_courses WHERE PID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PID")));
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
                        ("SELECT * FROM PREREQ_COURSES");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>PID</th>
                        <th>PREREQID</th>
                        <th>P_COURSES</th> 
                    </tr>
                    <tr>
                        <form action="prereq_courses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PID" size="10"></th>
                            <th><input value="" name="PREREQID" size="10"></th>
                            <th><input value="" name="P_COURSES" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="prereq_courses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the PID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PID") %>" 
                                    name="PID" size="10">
                            </td>
    
                            <%-- Get the PREREQID --%>
                            <td>
                                <input value="<%= rs.getInt("PREREQID") %>" 
                                    name="PREREQID" size="10">
                            </td>

                             <%-- Get the P_COURSES --%>
                            <td>
                                <input value="<%= rs.getString("P_COURSES") %>" 
                                    name="PREREQID" size="10">
                            </td>
    
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="prereq_courses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("PID") %>" name="PID">
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
