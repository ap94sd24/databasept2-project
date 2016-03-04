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
                        ("SELECT c.title FROM classes c");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CLASS TITLE</th>
                                           
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_1b.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="TITLE" size="10"></th>

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
                                <input value="<%= rs.getString("TITLE") %>" 
                                    name="TITLE" size="10">
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
                            "SELECT DISTINCT c.course_no, s.*, co.units, r.grade_opt from courses co, classes c, student s, register r, section sect, past_student_enrollment pse WHERE c.title = ? AND c.course_no = sect.course_no AND sect.sect_id = r.sect_id AND s.ssn = r.ssn AND co.course_no = c.course_no");

                        
                        pstmt.setString(1, request.getParameter("TITLE"));
                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
                    <tr>
                        <th>Course No</th>
                        <th>SSN</th>
                        <th>SID</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
                        <th>Units</th>
                        <th>Grade Option</th>
                                        

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_NO") %>" 
                                    name="COURSE_NO" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SID") %>" 
                                    name="SID" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
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

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("UNITS") %>" 
                                    name="UNITS" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("GRADE_OPT") %>" 
                                    name="GRADE_OPT" size="10">
                            </td>

                    </tr>
            <%
                    }
            %>
            <%        
                    action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "SELECT DISTINCT c.course_no, s.*, co.units, pse.grade_opt from courses co, classes c, student s, section sect, past_student_enrollment pse WHERE c.title = ? AND c.course_no = sect.course_no AND sect.sect_id = pse.sect_id AND s.ssn = pse.ssn AND co.course_no = c.course_no");

                        
                        pstmt.setString(1, request.getParameter("TITLE"));
                        rs = pstmt.executeQuery();
                    }
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_NO") %>" 
                                    name="COURSE_NO" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SID") %>" 
                                    name="SID" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
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

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("UNITS") %>" 
                                    name="UNITS" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("GRADE_OPT") %>" 
                                    name="GRADE_OPT" size="10">
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
