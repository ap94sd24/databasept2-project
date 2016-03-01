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
                            "INSERT INTO degree VALUES (?, ?, ?, ?, ? ,?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("DEGREEID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("TOTAL_UNITS")));
                        pstmt.setString(3, request.getParameter("DEGREE_NAME"));
                        pstmt.setString(4, request.getParameter("DEGREE_LVL"));
                        pstmt.setString(5, request.getParameter("CONCENTRATION_REQ"));
                        pstmt.setString(6, request.getParameter("DEPTNAME"));
                        pstmt.setString(7, request.getParameter("CATEG_LIST"));
                

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
                            "UPDATE Degree SET DEGREEID= ?, TOTAL_UNITS = ?, " +  "DEGREE_NAME = ?, " + 
                            "DEGREE_LVL = ?, CONCENTRATION_REQ = ?, DEPTNAME = ?, " + "CATEG_LIST = ? WHERE DEGREEID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("DEGREEID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("TOTAL_UNITS")));
                        pstmt.setString(3, request.getParameter("DEGREE_NAME"));
                        pstmt.setString(4, request.getParameter("DEGREE_LVL"));
                        pstmt.setString(5, request.getParameter("CONCENTRATION_REQ"));
                        pstmt.setString(6, request.getParameter("DEPTNAME"));
                        pstmt.setString(7,request.getParameter("CATEG_LIST"));
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
                        ("SELECT * FROM degree");
            %>

            <!-- Add an HTML table header row to format the results --> 
                <table border="1">
                    <tr>
                        <th>Degree ID</th>
                        <th>Total Units</th>
                        <th>Degree Name</th>
                        <th>Degree Level</th>
                        <th>Concentration Req.</th>
                        <th>Dept Name</th>
                        <th>Catagory List</th>
                    </tr>
                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="DEGREEID" size="12"></th>
                            <th><input value="" name="TOTAL_UNITS" size="35"></th>
                            <th><input value="" name="DEGREE_NAME" size="35"></th>
                            <th><input value="" name="DEGREE_LVL" size="15"></th>
                            <th><input value="" name="CONCENTRATION_REQ" size="12"></th>
                            <th><input value="" name="DEPTNAME" size="35"></th>
                            <th><input value="" name="CATEG_LIST" size="12"></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the degreeid, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("DEGREEID") %>" 
                                    name="DEGREEID" size="10">
                            </td>
    
                            <%-- Get the total units, which a number --%>
                            <td>
                                <input value="<%= rs.getInt("TOTAL_UNITS") %>" 
                                    name="TOTAL_UNITS" size="35">
                            </td>
    
                            <%-- Get the degree name, a string  --%>
                            <td>
                                <input value="<%= rs.getString("DEGREE_NAME") %>"
                                    name="DEGREE_NAME" size="35">
                            </td>

                            <%-- Get the degree level, a string type --%>
                            <td>
                                <input value="<%= rs.getString("degree_lvl") %>" 
                                    name="degree_lvl" size="35">
                            </td>
    
                            <%-- Get the concentration requirements --%>
                            <td>
                                <input value="<%= rs.getString("concentration_req") %>"
                                    name="concentration_req" size="35">
                            </td>

                            <%-- Get the dept name --%>
                            <td>
                                <input value="<%= rs.getString("deptname") %>" 
                                    name="deptname" size="35">
                            </td>
    
                            <%-- Get the category list--%>
                            <td>
                                <input value="<%= rs.getInt("categ_list") %>"
                                    name="catagory_list" size="35">
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
