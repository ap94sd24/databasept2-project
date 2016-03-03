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
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("prereq_list_id")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("Units")));
                        pstmt.setString(4, request.getParameter("Type"));
                        pstmt.setString(5, request.getParameter("grade_opt"));

                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("Lab_Req")));
 
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
                        <th>Course Type</th>
                        <th>Grade Option</th>
                        <th>Lab Required</th>
                         <th>Action</th>
                    </tr>
                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CID" size="10"></th>
                            <th><input value="" name="prereq_list_id" size="10"></th>
                            <th><input value="" name="Units" size="10"></th>
                            <th><input value="" name="Type" size="15"></th>
                            <th><input value="" name="grade_opt" size="15"></th>
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
                                <input value="<%= rs.getString("course_no") %>" 
                                    name="course_no" size="10">
                            </td>

                             <%-- Get the prereq_list_id, which is a string --%>
                            <td>
                                <input value="<%= rs.getInt("Prereq_list_id") %>" 
                                    name="prereq_list_id" size="10">
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
    
                            <%-- Get the grade_opt --%>
                            <td>
                                <input value="<%= rs.getString("grade_opt") %>" 
                                    name="grade_opt" size="15">
                            </td>
    
                             <%-- Get the Lab_Req --%>
                            <td>
                                <input value="<%= rs.getBoolean("Lab_Req") %>" 
                                    name="Lab_Req" size="15">
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