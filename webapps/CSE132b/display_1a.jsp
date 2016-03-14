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
                        ("SELECT s.* FROM curr_student_enrollment c, student s WHERE s.ssn = c.ssn");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>First</th>
                      <th>Middle</th>
                        <th>Last</th>
                                           
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_1a.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ssn" size="10"></th>

                            <th><input type="submit" value="Get Classes"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="curr_student_enroll.jsp" method="get">
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("ssn") %>" 
                                    name="ssn" size="10">
                            </td>
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FIRSTNAME") %>"
                                    name="FIRSTNAME" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("MIDDLENAME") %>" 
                                    name="MIDDLENAME" size="15">
                            </td>
    
                             <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LASTNAME") %>" 
                                    name="LASTNAME" size="15">
                            </td>
    
                        </form>
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
                            "SELECT s.*, r.units, r.grade_opt , sect.*, c.* from Student s, Section sect, classes c, register r WHERE s.ssn = ? AND r.ssn = ? AND sect.sect_id = r.sect_id AND sect.title = c.title");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ssn")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ssn")));
                        rs = pstmt.executeQuery();
                    }

            %>

            <table border="1">
                    <tr>
                         <th>SSN</th>
                        <th>First</th>
                      <th>Middle</th>
                        <th>Last</th>
                        <th>Units</th>
                        <th>Grade Option</th>
                        <th>SECT_ID</th>
                        <th>TITLE</th>
                        <th>COURSE NO</th>
                        <th>LECTURE DATE</th>
                        <th>DISS DATE</th>
                        <th>BUILDING</th>
                        <th>ROOM</th>
                        <th>MAXCAP</th>
                        <th>LECT_TIME_START</th>
                        <th>LECT_TIME_END</th>
                        <th>DIS_TIME_START</th>
                        <th>DIS_TIME_END</th>
                        <th>QUARTER</th> 
                        <th>YEAR</th> 
                    </tr>
                       <h2>Report</h2>                 

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
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FIRSTNAME") %>"
                                    name="FIRSTNAME" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("MIDDLENAME") %>" 
                                    name="MIDDLENAME" size="15">
                            </td>
    
                             <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LASTNAME") %>" 
                                    name="LASTNAME" size="15">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("UNITS") %>" 
                                    name="UNITS" size="10">
                            </td>
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("GRADE_OPT") %>" 
                                    name="GRADE_OPT" size="10">
                            </td>

                            <%-- Get the SECT_ID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SECT_ID") %>" 
                                    name="SECT_ID" size="10">
                            </td>
                             <%-- Get the TITLE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("TITLE") %>" 
                                    name="TITLE" size="10">
                            </td>

                            <%-- Get the TITLE, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_NO") %>" 
                                    name="COURSE_NO" size="10">
                            </td>

                            <%-- Get the LECTDATE, which is a date --%>
                            <td>
                                <input value="<%= rs.getString("LECT_DATE_ID") %>" 
                                    name="LECT_DATE_ID" size="10">
                            </td>

                             <%-- Get the DIS_DATE_ID, which is a date --%>
                            <td>
                                <input value="<%= rs.getString("DIS_DATE_ID") %>" 
                                    name="DIS_DATE_ID" size="10">
                            </td>
    
                            <%-- Get the BUILDING, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("BUILDING") %>" 
                                    name="BUILDING" size="10">
                            </td>

                            <%-- Get the ROOM, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("ROOM") %>" 
                                    name="ROOM" size="10">
                            </td>
                             <%-- Get the maxcap, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("MAXCAP") %>" 
                                    name="MAXCAP" size="10">
                            </td>

                            <%-- Get the lecture start time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("LEC_TIME_START") %>" 
                                    name="LECT_TIME_START" size="10">
                            </td>

                            <%-- Get the lecture end time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("LECT_TIME_END") %>" 
                                    name="LECT_TIME_END" size="10">
                            </td>

                             <%-- Get the discussion start time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("DIS_TIME_START") %>" 
                                    name="DIS_TIME_START" size="10">
                            </td>

                            <%-- Get the discussion end time, which is a time --%>
                            <td>
                                <input value="<%= rs.getTime("DIS_TIME_END") %>" 
                                    name="DIS_TIME_END" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("QUARTER") %>" 
                                    name="QUARTER" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("YEAR") %>" 
                                    name="YEAR" size="10">
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
