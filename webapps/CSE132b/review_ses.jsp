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
            <%@ page language="java" import="java.text.*" %>
            <%@ page import="java.util.*" %>

            <%!
            public static java.sql.Time getCurrentJavaSqlTime(String time) {
                DATE date = new SimpleDateFormat("HH:mm", Locale.English).parse(time); 
                return new java.sql.Time(date.getTime());  //To time 
            }
           
    
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
                        conn.setAutoCommit(false);                       // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.

                        SimpleDateFormat reFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date startDate = reformat.parse(request.getParameter("R_DATE_START"));
                        java.sql.Date sqlDateStart = new java.sql.Date(startDate.getTime());
                        Date endDate = reformat.parse(request.getParameter("R_DATE_END"));
                        java.sql.Date sqlDateEnd = new java.sql.Date(startDate.getTime()); 
                        java.sql.Time tStart = getCurrentJavaSqlTime((String)request.getParameter("R_TIME_START"));
                        java.sql.Time tEnd = getCurrentJavaSqlTime((String)request.getParameter("R_TIME_END"));

                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO review_ses VALUES (?, ?, ?, ?,?,?)");
                        pstmt.setString(1, request.getParameter("REV_ID"));     
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("sectionid")));
                        pstmt.setDate(3, sqlDateStart);
                        pstmt.setDate(4, sqlDateEnd);
                        pstmt.setTime(5, tStart);
                        pstmt.setTime(6,tEnd);

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

                        SimpleDateFormat reFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date startDate = reformat.parse(request.getParameter("R_DATE_START"));
                        java.sql.Date sqlDateStart = new java.sql.Date(startDate.getTime());
                        Date endDate = reformat.parse(request.getParameter("R_DATE_END"));
                        java.sql.Date sqlDateEnd = new java.sql.Date(startDate.getTime()); 
                        java.sql.Time tStart = getCurrentJavaSqlTime((String)request.getParameter("R_TIME_START"));
                        java.sql.Time tEnd = getCurrentJavaSqlTime((String)request.getParameter("R_TIME_END"));

                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Review_ses SET REV_ID = ?, SECTIONID = ?, R_DATE_START = ?, " +
                            "R_DATE_END = ?, R_TIME_START = ?, R_TIME_END WHERE REV_ID = ?");

                        pstmt.setString(1, request.getParameter("REV_ID"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SECTIONID")));
                        pstmt.setDate(3, sqlDateStart);
                        pstmt.setDate(4, sqlDateEnd);
                        pstmt.setTime(5, tStart);
                        pstmt.setTime(6,tEnd);
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Review_ses WHERE REV_ID = ?");

                        pstmt.setString(
                            1, request.getParameter("REV_ID"));
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
                        ("SELECT * FROM review_ses");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                       <th>Review Sess ID</th>
                        <th>Section ID</th>
                        <th>Date Start</th>
                        <th>Date End</th>
                        <th>Time Start</th>
                       <th>Time End</th>
                    </tr>
                    <tr>
                        <form action="review_ses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="rev_id" size="12"></th>
                            <th><input value="" name="sectionid" size="12"></th>
                            <th><input value="" name="R_DATE_START" size="35"></th>
                            <th><input value="" name="R_DATE_END" size="12"></th>
                            <th><input value="" name="R_TIME_START" size="35"></th>
                            <th><input value="" name="R_TIME_END" size="35"></th>
                            <th><input type="submit" value="Insert"></th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="review_ses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the review_sess id, which is a string --%>
                            <td>
                                <input value="<%= rs.getString("rev_id") %>" 
                                    name="rev_id" size="10">
                            </td>

                            <%-- Get the sectionid, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("sectionid") %>" 
                                    name="sectionid" size="10">
                            </td>
    
                            <%-- Get the R_DATE_START --%>
                            <td>
                                <input value="<%= rs.getInt("R_DATE_START") %>" 
                                    name="R_DATE_START" size="35">
                            </td>

                            <%-- Get the R_DATE_END --%>
                            <td>
                                <input value="<%= rs.getInt("R_DATE_END") %>" 
                                    name="R_DATE_END" size="35">
                            </td>
                            
                             <%-- Get the R_TIME_START --%>
                            <td>
                                <input value="<%= rs.getInt("R_TIME_START") %>" 
                                    name="R_TIME_START" size="35">
                            </td>

                            <%-- Get the R_TIME_END --%>
                            <td>
                                <input value="<%= rs.getInt("R_TIME_END") %>"
                                    name="R_TIME_END" size="35">
                            </td>
                        
                      <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="review_ses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("REV_ID") %>" name="REV_ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
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
