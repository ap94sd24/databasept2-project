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

            <%-- -------- INSERT Code -------- --%>
            <%
                    Statement statement = conn.createStatement();
                    ResultSet rs = null;
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                        "select count (case when pse.grade in ('A+', 'A', 'A-') THEN 1 END) AS numA,"
                            +"count(case when pse.grade in ('B+', 'B', 'B-') THEN 1 END) AS numB,"
                            +"count(case when pse.grade in ('C+', 'C', 'C-') THEN 1 END) AS numC,"
                            +"count(case when pse.grade in ('D+', 'D', 'D-') THEN 1 END) AS numD,"
                            +"count(case when pse.grade in ('F') THEN 1 END) AS numF"
                            +" FROM past_student_enrollment pse, section s"
                            +" WHERE pse.course_no=?"
                            +" AND s.faculty =?"
                            +" AND pse.sect_id = s.sect_id;");

                        
                    pstmt.setString(1, request.getParameter("COURSE_NO"));
                    pstmt.setString(2, request.getParameter("FACULTY"));
                    rs = pstmt.executeQuery();
                    }

            %>
                <table border="1">
                    <tr>
                        <th>Course No</th>
                        <th>Faculty</th>                                           
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="display_3a_ii.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="COURSE_NO" size="10"></th>
                            <th><input value="" name="FACULTY" size="10"></th>
                            <th><input type="submit" value="insert"></th>
                        </form>
                    </tr>

            <table border="1">
                    <tr>
                        <th># As</th>
                        <th># Bs</th>
                        <th># Cs</th>
                        <th># Ds</th>
                        <th># Others</th>
                                        

             <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>

                            <%-- Get the SSN, which is a number --%>
                            <td><%= rs.getInt("numA") %></td>
                            <%-- Get the SSN, which is a number --%>
                            <td><%= rs.getInt("numB") %></td>
                            <td><%= rs.getInt("numC") %></td>
                            <td><%= rs.getInt("numD") %></td>

                            <td><%= rs.getInt("numF") %></td>
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
