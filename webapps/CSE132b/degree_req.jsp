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
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO degree_req VALUES (?, ?, ?, ?, ? ,?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("degree_id")));
                        pstmt.setString(2, request.getParameter("deptname"));
                        pstmt.setString(3, request.getParameter("degree_name"));
                        pstmt.setString(4, request.getParameter("degree_lvl"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("total_units")));
                        pstmt.setString(6, request.getParameter("degree_catagory"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("catagory_units")));
                        pstmt.setString(8, request.getParameter("course_no"));
                        pstmt.setString(9, request.getParameter("grad_concentration"));

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
                        ("SELECT * FROM degree_req");
            %>

            <!-- Add an HTML table header row to format the results --> 
                <table border="1">
                    <tr>
                        <th>Degree Id</th>
                        <th>Department</th>
                        <th>Degree Name</th>
                        <th>Degree Type</th>
                        <th>Degree Total Units</th>
                        <th>Course Catagory</th>
                        <th>Catagory Units Required</th>
                        <th>Course Number</th>
                        <th>Grad Concentration</th>
                    </tr>
                    <tr>
                        <form action="degree_req.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="degree_id" size="12"></th>
                            <th><input value="" name="deptname" size="35"></th>
                            <th><input value="" name="degree_name" size="35"></th>
                            <th><input value="" name="degree_lvl" size="15"></th>
                            <th><input value="" name="total_units" size="12"></th>
                            <th><input value="" name="degree_catagory" size="35"></th>
                            <th><input value="" name="catagory_units" size="12"></th>
                            <th><input value="" name="course_no" size="12"></th>
                            <th><input value="" name="grad_concentration" size="35"></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degree_req.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("degree_id") %>" 
                                    name="degree_id" size="10">
                            </td>
    
                            <%-- Get the Period --%>
                            <td>
                                <input value="<%= rs.getString("deptname") %>" 
                                    name="deptname" size="35">
                            </td>
    
                            <%-- Get the Reason --%>
                            <td>
                                <input value="<%= rs.getString("degree_name") %>"
                                    name="degree_name" size="35">
                            </td>

                            <%-- Get the Period --%>
                            <td>
                                <input value="<%= rs.getString("degree_lvl") %>" 
                                    name="degree_lvl" size="35">
                            </td>
    
                            <%-- Get the Reason --%>
                            <td>
                                <input value="<%= rs.getInt("total_units") %>"
                                    name="total_units" size="35">
                            </td>

                            <%-- Get the Period --%>
                            <td>
                                <input value="<%= rs.getString("degree_catagory") %>" 
                                    name="degree_catagory" size="35">
                            </td>
    
                            <%-- Get the Reason --%>
                            <td>
                                <input value="<%= rs.getInt("catagory_units") %>"
                                    name="catagory_units" size="35">
                            </td>

                            <%-- Get the Period --%>
                            <td>
                                <input value="<%= rs.getString("course_no") %>" 
                                    name="course_no" size="35">
                            </td>
    
                            <%-- Get the Reason --%>
                            <td>
                                <input value="<%= rs.getString("grad_concentration") %>"
                                    name="grad_concentration" size="35">
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
