package pckg1;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class signup extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/hackathon", "root", "");

                String firstname = request.getParameter("firstname");
                String lastname = request.getParameter("lastname");
                String email = request.getParameter("email");
                String pass = request.getParameter("pass");
                String college = request.getParameter("clgname");
                int passyear = Integer.parseInt(request.getParameter("passyear"));
                out.println(firstname + " " + lastname + " " + " " + email + " " + pass + " " + college + " " + passyear + " ");
                PreparedStatement pst = con.prepareStatement("insert into users(firstname,lastname,email,password,college,passing_year,is_delete) values(?,?,?,?,?,?,?)");
                pst.setString(1, firstname);
                pst.setString(2, lastname);
                pst.setString(3, email);
                pst.setString(4, pass);
                pst.setString(5, college);
                pst.setInt(6, passyear);
                pst.setString(7, "no");
                int result = pst.executeUpdate();
                if (result == 1) {
                    out.println("Login Successful");
                    Statement st = con.createStatement();
                    ResultSet rst = st.executeQuery("select * from users where email = '" + email + "' and password = '" + pass + "'");
                    rst.last();
                    if (rst.getRow() == 1) {
                        if (rst.first()) {
                            String id = (String.valueOf(rst.getInt(1)));
                            HttpSession s = request.getSession();
                            s.setAttribute("uid", id);
                            response.sendRedirect("home.jsp");
                        }
                    } else {
                        out.println("<script>alert('Incorrect Email or Password')</script>");
                        HttpSession s = request.getSession();
                        s.setAttribute("loginfailed", 1);
                        response.sendRedirect("login.jsp");
                    }
                } else {
                    response.sendRedirect("signup.jsp");
                }
            } catch (Exception e) {
                out.println("Exception Occurred " + e);
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
