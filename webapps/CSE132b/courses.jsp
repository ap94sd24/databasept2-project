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
                            "INSERT INTO Courses VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("CID"));
                        pstmt.setString(2, request.getParameter("PREREQID"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("Units")));
                        pstmt.setString(4, request.getParameter("Type"));
                        pstmt.setString(5, request.getParameter("Grade"));
                        pstmt.setBoolean(6, request.getParameter("Lab_Req"));
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
                            "UPDATE Courses SET Units = ?, Type = ?, " +
                            "Grade = ?, Lab_Req = ?, prereqid = ? WHERE CID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("Units")));
                        pstmt.setString(2, request.getParameter("Type"));
                        pstmt.setString(3, request.getParameter("Grade"));
                        pstmt.setBoolean(4, request.getParameter("Lab_Req"));
                        pstmt.setString(5, request.getParameter("prereqid"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("CID")));
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
                            "DELETE FROM Courses WHERE CID = ?");

                        pstmt.setString(
                            1, request.getParameter("CID"));
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
                        ("SELECT * FROM Courses");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course Id</th>
                        <th>Pre Req Id</th>
                        <th>Units</th>
                        <th>Type</th>
                        <th>Grade</th>
                        <th>Lab Required</th>
                    </tr>
                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CID" size="10"></th>
                            <th><input value="" name="PREREQID" size="10"></th>
                            <th><input value="" name="Units" size="10"></th>
                            <th><input value="" name="Type" size="15"></th>
                            <th><input value="" name="Grade" size="15"></th>
                            <th><input value="" name="Lab_Req" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the Course Number, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("CID") %>" 
                                    name="CID" size="10">
                            </td>

                             <%-- Get the PREREQID, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("CID") %>" 
                                    name="CID" size="10">
                            </td>
    
    
                            <%-- Get the Units --%>
                            <td>
                                <input value="<%= rs.getInt("Units") %>" 
                                    name="Units" size="10">
                            </td>
    
                            <%-- Get the Type --%>
                            <td>
                                <input value="<%= rs.getString("Type") %>"
                                    name="Type" size="15">
                            </td>
    
                            <%-- Get the Grade --%>
                            <td>
                                <input value="<%= rs.getString("Grade") %>" 
                                    name="Grade" size="15">
                            </td>
    
                             <%-- Get the Lab_Req --%>
                            <td>
                                <input value="<%= rs.getBoolean("Lab_Req") %>" 
                                    name="Lab_Req" size="15">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("CID") %>" name="CID">
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