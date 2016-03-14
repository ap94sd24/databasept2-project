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
                        ("SELECT s.*, ugrad.major_title FROM curr_student_enrollment cse, student s, undergraduates ugrad WHERE ugrad.ssn = cse.ssn AND s.ssn = cse.ssn order by ssn;");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>Degree Name</th>          
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_1d.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="DEGREE_NAME" size="20"></th>

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
                            <td>
                                <input value="<%= rs.getString("MAJOR_TITLE") %>" 
                                    name="MAJOR_TITLE" size="40">
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
                            "SELECT d.total_units FROM degree d, major m, undergraduates ugrad, student s WHERE d.degree_name = ? AND d.degree_id = m.degree_id AND m.major_title = ugrad.major_title AND s.ssn = ? AND ugrad.ssn = s.ssn");

                        
                        pstmt.setString(1, request.getParameter("DEGREE_NAME"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SSN")));
                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
                    <tr>
                        <th>Total Units</th>
                    </tr>                    

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("TOTAL_UNITS") %>" 
                                    name="TOTAL_UNITS" size="10">
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
                           "select cc.categ_name, cc.min_units as min_unit from category_classes cc, student s, undergraduates ug where s.ssn = ? AND ug.ssn = ?");

                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));



                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
            <tr>
                <th>Category</th>
                <th>Min Units</th>
                <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
                    %>
                    <tr>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("CATEG_NAME") %>" 
                                    name="CATEG_NAME" size="20">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("MIN_UNIT") %>"
                                    name="MIN_UNIT" size="10">
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
