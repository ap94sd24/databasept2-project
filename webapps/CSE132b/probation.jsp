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
                            "INSERT INTO Probation VALUES (?, ?, ?, ?, ?, ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SID")));
                        pstmt.setString(2, request.getParameter("START_QUARTER"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("START_YEAR")));
                        pstmt.setString(4, request.getParameter("END_QUARTER"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("END_YEAR")));
                        pstmt.setBoolean(6, request.getParameter("REASON"));
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
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Probation SET SID = ?,START_QUARTER = ?, START_YEAR = ?, " +
                            "END_QUARTER= ?, END_YEAR = ?, REASON = ? WHERE SID = ?, START_QUARTER ?, START_YEAR = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SID")));
                        pstmt.setString(2, request.getParameter("START_QUARTER"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("START_YEAR")));
                        pstmt.setString(4, request.getParameter("END_QUARTER"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("END_YEAR")));
                        pstmt.setBoolean(6, request.getParameter("REASON"));
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
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Probation WHERE SID = ?, START_QUARTER = ?, START_YEAR = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SID")));
                        pstmt.setString(2, request.getParameter("START_QUARTER"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("START_YEAR")));
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
                        ("SELECT * FROM Probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SID</th>
                        <th>START_QUARTER</th>
                        <th>START_YEAR</th>
                        <th>END_QUARTER</th>
                        <th>END_YEAR</th>
                        <th>Reason</th>
                    </tr>
                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SID" size="12"></th>
                            <th><input value="" name="START_QUARTER" size="35"></th>
                             <th><input value="" name="START_YEAR" size="35"></th>
                            <th><input value="" name="END_QUARTER" size="35"></th>
                             <th><input value="" name="END_YEAR" size="35"></th>
                            <th><input value="" name="Reason" size="35"></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SID") %>" 
                                    name="SSN" size="10">
                            </td>

                             <%-- Get the start qtr, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("START_QUARTER") %>" 
                                    name="START_QUARTER" size="10">
                            </td>

                             <%-- Get the start yr, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("START_YEAR") %>" 
                                    name="START_YEAR" size="10">
                            </td>

                              <%-- Get the end qtr, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("END_QUARTER") %>" 
                                    name="END_QUARTER" size="10">
                            </td>

                             <%-- Get the start yr, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("END_YEAR") %>" 
                                    name="END_YEAR" size="10">
                            </td>
    
                            <%-- Get the Reason --%>
                            <td>
                                <input value="<%= rs.getString("Reason") %>"
                                    name="Reason" size="35">
                            </td>
                      <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("SID,START_QARTER,START_YEAR") %>" name="PROBATSTUDENT">
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
