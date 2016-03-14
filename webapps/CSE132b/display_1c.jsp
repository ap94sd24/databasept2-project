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
                        ("SELECT distinct s.* FROM past_student_enrollment pse, student s WHERE s.ssn = pse.ssn order by s.ssn");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>First Name</th>
                        <th>Middle Name</th>
                        <th>Last Name</th>
                                           
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_1c.jsp" method="get">
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
                            <td><%= rs.getInt("SSN") %>
                            </td>

                            <td>
                            <%= rs.getString("FIRSTNAME") %>
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td> <%= rs.getString("MIDDLENAME") %>
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <%= rs.getString("LASTNAME") %>
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
                            "select pse.quarter, pse.year, c.course_no, c.title from past_student_enrollment pse, courses co, classes c, student s where s.ssn = ? AND s.ssn = pse.ssn AND pse.course_no = co.course_no AND co.course_no = c.course_no GROUP BY pse.quarter, pse.year, c.course_no, c.title;");

                        
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
                    <tr>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Course No</th>
                        <th>Title</th>
                                        

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("QUARTER") %>" 
                                    name="QUARTER" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("YEAR") %>" 
                                    name="YEAR" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_NO") %>" 
                                    name="COURSE_NO" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("TITLE") %>" 
                                    name="TITLE" size="40">
                            </td>
                    </tr>
            <%
                    }
            %>

            <%-- -------- GPA BY TERM -------- --%>
            <%
                    action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "select pse.quarter, pse.year, avg(gc.number_grade) AS TOTAL_GPA FROM grade_conversion gc, past_student_enrollment pse WHERE pse.ssn = ? AND pse.grade = gc.letter_grade GROUP BY pse.quarter, pse.year;");

                        
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
                    <tr>
                        <th>Total GPA</th>
                                        

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                    <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("QUARTER") %>" 
                                    name="QUARTER" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("YEAR") %>" 
                                    name="YEAR" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getDouble("TOTAL_GPA") %>" 
                                    name="TOTAL_GPA" size="10">
                            </td>
                    </tr>
            <%
                    }
            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "select avg(gc.number_grade) AS TOTAL_GPA FROM grade_conversion gc, past_student_enrollment pse WHERE pse.ssn = ? AND pse.grade = gc.letter_grade;");

                        
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
                    <tr>
                        <th>Total GPA</th>
                                        

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getDouble("TOTAL_GPA") %>" 
                                    name="TOTAL_GPA" size="10">
                            </td>
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
