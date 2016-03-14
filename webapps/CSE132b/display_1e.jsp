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
                        ("jdbc:postgresql://localhost:5433/postgres", 
                            "postgres", "cse132b");

            %>
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT s.* FROM curr_student_enrollment cse, student s, graduates g WHERE g.ssn = cse.ssn AND s.ssn = cse.ssn order by ssn;");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>        
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_1e.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>

                            <th><input type="submit" value="Get Students"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
                            <td>
                            <input value="<%= rs.getString("FIRSTNAME") %>" 
                                    name="FIRSTNAME" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("MIDDLENAME") %>" 
                                    name="MIDDLENAME" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("LASTNAME") %>" 
                                    name="LASTNAME" size="10">
                            </td>
                    </tr>
            <%
                    }
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
                            "SELECT g.concentration, g.ssn from graduates g, student s where s.ssn = g.ssn and s.ssn=?");

                        
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
                    <tr>
                        <th>SSN </th>
                        <th>Concentration Completed</th>
                    </tr>                    

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN" size="10">
                            </td>

                             <td>
                                <input value="<%= rs.getString("CONCENTRATION") %>" 
                                    name="CONCENTRATION" size="10">
                            </td>

                    </tr>

            <%
                    }
            %>

            </table>

            <%
                    action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        /*PreparedStatement pstmt = conn.prepareStatement(
                            "SELECT FROM degree d, major m, undergraduates ugrad, student s WHERE d.degree_name = ? AND d.degree_id = m.degree_id AND m.major_title = ugrad.major_title AND s.ssn = ? AND ugrad.ssn = s.ssn");
                            */
                        PreparedStatement pstmt = conn.prepareStatement(
                           "g.concentration, g.ssn from graduates g, student s where s.ssn = g.ssn and s.ssn=?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));



                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
            <tr>
                <th>SSN</th>
                <th>Concentration Completed</th>
                <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
                    %>
                    <tr>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN" size="20">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("CONCENTRATION") %>"
                                    name="CONCENTRATION" size="10">
                            </td>

                    </tr>

            <%
                    }
            %>
            </tr>
            </table>

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
