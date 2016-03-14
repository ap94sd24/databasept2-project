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
                            "INSERT INTO CATEGORY_CLASSES VALUES (?, ?, ?, ?, ?,?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CATEG_CLASS_ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MIN_UNITS")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("POSSIBLE_CLASSES_ID")));
                        pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("IS_CONCENT")));
                        pstmt.setFloat(5, Float.parseFloat(request.getParameter("GPA_MIN")));
                        pstmt.setString(6, request.getParameter("CATEG_NAME"));

                      
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
                        ("SELECT * FROM CATEGORY_CLASSES");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Category Class ID</th>
                        <th>Min Units</th>
                        <th>Possible Classes ID</th>
                        <th>Is a Concentration</th>
                        <th>Min GPA</th>
                        <th>Category Name</th>
                                           
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="category_classes.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CATEG_CLASS_ID" size="10"></th>
                            <th><input value="" name="MIN_UNITS" size="10"></th>
                            <th><input value="" name="POSSIBLE_CLASSES_ID" size="15"></th>
                            <th><input value="" name="IS_CONCENT" size="15"></th>
                            <th><input value="" name="GPA_MIN" size="15"></th>
                            <th><input value="" name="CATEG_NAME" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="category_classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                             <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("CATEG_CLASS_ID") %>" 
                                    name="CATEG_CLASS_ID" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("MIN_UNITS") %>" 
                                    name="MIN_UNITS" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("POSSIBLE_CLASSES_ID") %>" 
                                    name="SSN" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getBoolean("IS_CONCENT") %>" 
                                    name="IS_CONCENT" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getDouble("GPA_MIN") %>" 
                                    name="GPA_MIN" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("CATEG_NAME") %>" 
                                    name="CATEG_NAME" size="20">
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
