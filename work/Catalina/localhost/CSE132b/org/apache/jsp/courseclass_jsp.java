/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.30
 * Generated at: 2016-02-25 23:56:46 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class courseclass_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<html>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("    <table border=\"1\"style=\"background-color:rgba(0,0,0,0.5);\">\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td valign=\"top\">\r\n");
      out.write("                ");
      out.write("\r\n");
      out.write("                ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "menu.html", out, false);
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("            <td>\r\n");
      out.write("\r\n");
      out.write("            ");
      out.write("\r\n");
      out.write("            ");
      out.write("\r\n");
      out.write("            \r\n");
      out.write("    \r\n");
      out.write("            ");
      out.write("\r\n");
      out.write("            ");

                try {
                    // Load Oracle Driver class file
                    DriverManager.registerDriver
                        (new org.postgresql.Driver());
    
                    // Make a connection to the Oracle datasource "cse132b"
                    Connection conn = DriverManager.getConnection
                        ("jdbc:postgresql://localhost:5432/postgres", 
                            "postgres", "cse132b");

            
      out.write("\r\n");
      out.write("\r\n");
      out.write("            ");
      out.write("\r\n");
      out.write("            ");

                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the CourseClasses table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO CLASSES VALUES (?,?)");

                       // pstmt.setString(1, request.getParameter("TITLE"));

                        pstmt.setString(1, request.getParameter("TITLE"));
                        pstmt.setString(2, request.getParameter("CID"));      
                        int rowCount = pstmt.executeUpdate();
                    

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            
      out.write("\r\n");
      out.write("\r\n");
      out.write("            ");
      out.write("\r\n");
      out.write("            ");

                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the class attributes FROM the Section table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM COURSECLASS");
            
      out.write("\r\n");
      out.write("\r\n");
      out.write("            <!-- Add an HTML table header row to format the results -->\r\n");
      out.write("                <table border=\"1\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <th>TITLE</th>\r\n");
      out.write("                        <th>CID </th> \r\n");
      out.write("\r\n");
      out.write("                        <th>Action</th>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <form action=\"courseclass.jsp\" method=\"get\">\r\n");
      out.write("                            <input type=\"hidden\" value=\"insert\" name=\"action\">\r\n");
      out.write("                            <th><input value=\"\" name=\"TITLE\" size=\"10\"></th>\r\n");
      out.write("                            <th><input value=\"\" name=\"CID\" size=\"10\"></th>\r\n");
      out.write("                           \r\n");
      out.write("                            <th><input type=\"submit\" value=\"Insert\"></th>\r\n");
      out.write("                        </form>\r\n");
      out.write("                    </tr>\r\n");
      out.write("\r\n");
      out.write("            ");
      out.write("\r\n");
      out.write("            ");

                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <form action=\"courseclass.jsp\" method=\"get\">\r\n");
      out.write("                            <input type=\"hidden\" value=\"update\" name=\"action\">\r\n");
      out.write("\r\n");
      out.write("                            ");
      out.write("\r\n");
      out.write("                            <td>\r\n");
      out.write("                                <input value=\"");
      out.print( rs.getString("TITLE") );
      out.write("\" \r\n");
      out.write("                                    name=\"TITLE\" size=\"10\">\r\n");
      out.write("                            </td>\r\n");
      out.write("                              ");
      out.write("\r\n");
      out.write("                            <td>\r\n");
      out.write("                                <input value=\"");
      out.print( rs.getString("CID") );
      out.write("\" \r\n");
      out.write("                                    name=\"CID\" size=\"10\">\r\n");
      out.write("                            </td>\r\n");
      out.write("                             \r\n");
      out.write("                            ");
      out.write("\r\n");
      out.write("                            <td>\r\n");
      out.write("                                <input type=\"submit\" value=\"Update\">\r\n");
      out.write("                            </td>\r\n");
      out.write("                        </form>\r\n");
      out.write("                        <form action=\"courseclass.jsp\" method=\"get\">\r\n");
      out.write("                            <input type=\"hidden\" value=\"delete\" name=\"action\">\r\n");
      out.write("                            <input type=\"hidden\" \r\n");
      out.write("                                value=\"");
      out.print( rs.getString("TITLE,CID") );
      out.write("\" name=\"COURSECLASS\">\r\n");
      out.write("                            ");
      out.write("\r\n");
      out.write("                            <td>\r\n");
      out.write("                                <input type=\"submit\" value=\"Delete\">\r\n");
      out.write("                            </td>\r\n");
      out.write("                        </form>\r\n");
      out.write("                    </tr>\r\n");
      out.write("            ");

                    }
            
      out.write("\r\n");
      out.write("\r\n");
      out.write("            ");
      out.write("\r\n");
      out.write("            ");

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
            
      out.write("\r\n");
      out.write("                </table>\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
