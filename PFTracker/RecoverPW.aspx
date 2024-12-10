<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecoverPW.aspx.cs" Inherits="PFTracker.RecoverPW" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RecoverPW</title>
    <!-- Required meta tags -->
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <!-- plugins:css -->
    <link rel="stylesheet" href="css/materialdesignicons.min.css"/>
    <link rel="stylesheet" href="css/vendor.bundle.base.css"/>
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="css/style.css"/>
    <!-- End layout styles -->
    <link rel="shortcut icon" href="images/favicon.png" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-scroller">
            <div class="container-fluid page-body-wrapper full-page-wrapper">
                <div class="row w-100 m-0">
                    <div class="content-wrapper full-page-wrapper d-flex align-items-center auth login-bg">
                        <div class="card col-lg-4 mx-auto">
                            <div class="card-body px-5 py-5">
                                <h3 class="card-title text-left mb-3">Recuperação de Palavra-Passe</h3>
                                <div>
                                    <div class="form-group">
                                        <asp:Label ID="lbl_email" runat="server" Text="Digite o seu e-mail:"></asp:Label>
                                        <asp:TextBox ID="tb_email" runat="server" class="form-control p_input"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        
                                    </div>
                                    <div class="form-group d-flex align-items-center justify-content-between">
                                        <asp:Label ID="lbl_mensagem" runat="server"></asp:Label>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="btn_enviar" runat="server" CssClass="btn btn-primary btn-block enter-btn" Text="Recuperar Senha" OnClick="btn_enviar_Click"/>
                                    </div>
                                    <div class="d-flex">
                                        <asp:Button ID="btn_facebook" runat="server" Class="btn btn-facebook mr-2 col" Text="Facebook" />
                                        <asp:Button ID="btn_google" runat="server" Class="btn btn-google col" Text="Google"/>
                                    </div>
                                    <p class="sign-up">Don't have an Account?<a href="Register.aspx"> Sign Up</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                </div>
                <!-- row ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <!-- container-scroller -->
        <!-- plugins:js -->
        <script src="js/vendor.bundle.base.js"></script>
        <!-- endinject -->
        <!-- Plugin js for this page -->
        <!-- End plugin js for this page -->
        <!-- inject:js -->
        <script src="js/off-canvas.js"></script>
        <script src="js/hoverable-collapse.js"></script>
        <script src="js/misc.js"></script>
        <script src="js/settings.js"></script>
        <script src="js/todolist.js"></script>
        <!-- endinject -->
    </form>
</body>
</html>

