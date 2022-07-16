<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid px-lg-5">
                        <a class="navbar-brand" href="#">Website</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                                <div class="d-flex flex-column flex-lg-row align-items-start">
              
                                        <!-- Profile Button -->
                                        <button type="button" class="btn bg-transparent text-white border-0 mx-1">
                                                <i class="fa fa-user"></i> Profile
                                        </button>
                                         
                                </div>
                        </div>
                </div>
          </nav>
        <!-- End of Navbar -->
        
        <%
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/hackathon", "root", "");

                String pid = request.getParameter("pid");
                Statement stmt = con.createStatement();
                ResultSet res = stmt.executeQuery("Select * from projects where pid = "+pid+";");

                if(res.first()){
                    String projectId = res.getString(1);
                    String projectTitle = res.getString(2);
                    String projectDescription = res.getString(3);
                    String preferences = res.getString(4);
        %>
                    <!--File Upload Form-->
                    <form enctype="multipart/form-data" action="UploadReport" method="post" >
                        <input class="input" type="file" name="report">
                        <input type="hidden" value="<%= request.getParameter("pid") %>" name="pid" >
                        <input type="submit" value="Upload">
                    </form>
                        
                    <!--Pdf Open-->
                    <form method="get" action="OpenPDF">
                        <input type="hidden" value="1" name="rid">
                        <input type="submit" value="Open PDF" >
                    </form>
                    
                    <div class="container d-flex justify-content-center align-items-start">
                        <div class="card">
                            <div class="card-title d-flex justify-content-end">
                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                    Update Project
                                </button>
                            </div>
                            <div>
                                <h1><%= projectTitle %></h1>
                                <p>
                                    <%= projectDescription %>
                                </p>
                            </div>
                        </div>
                    </div>
                                
                    <!-- Update Project Modal -->
                    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                    <div class="modal-header">
                                    <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                <form action="UpdateProject" method="post">
                                    <div class="modal-body">

                                        <div class="mb-3">
                                                <label for="staticEmail" class="col-form-label">Project Title</label>
                                                <input type="text" class="form-control" name="title" value="<%= projectTitle %>">
                                        </div>
                                        <div class="mb-3">
                                                <label for="inputPassword" class="col-form-label">Description</label>
                                                <textarea class="form-control" name="description" rows="5"><%= projectDescription %></textarea>
                                        </div>
                                        <div class="mb-3">
                                                <label for="staticEmail" class="col-form-label">
                                                        Preferences
                                                        <i class="fa fa-info-circle" title="Preferences"></i>
                                                </label>
                                                <input type="text" class="form-control" name="preferences" value="<%= preferences %>">
                                        </div>
                                        <input type="hidden" name="pid" value="<%= projectId %>">
                                    </div>
                                    <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <input type="submit" value="Update" class="btn btn-primary">
                                    </div>
                                </form>
                            </div>
                            </div>
                    </div>
                    <!-- End of Post Project Modal -->
        <%        }
            }catch(Exception e){
                out.println(e);
            }
        %>
        
        <!-- Bootstrap Javascript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
    </body>
</html>
