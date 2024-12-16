<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePW.aspx.cs" Inherits="PFTracker.ChangePW" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>ChangePW</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="vendors/mdi/css/materialdesignicons.min.css" />
    <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css" />
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="/css/style.css" />
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
                                <h3 class="card-title text-left mb-3">Mudar a Palavra-Passe</h3>
                                <div>
                                    <div class="form-group">
                          
                                    </div>
                                    <div class="form-group">
                                        
                                    </div>
                                    <div class="form-group">
                                        <label>Palavra-Passe Atual:</label>
                                        <asp:TextBox ID="tb_pwAtual" runat="server" class="form-control p_input" TextMode="Password"></asp:TextBox>

                                    </div>
                                    <div class="form-group">
                                        <label>Palavra-Passe Nova:</label>
                                        <asp:TextBox ID="tb_pwNova" runat="server" class="form-control p_input" TextMode="Password"></asp:TextBox>

                                    </div>
                                    <div class="form-group d-flex align-items-center justify-content-between">
                                        <asp:Label ID="lbl_mensagem" runat="server" ForeColor="#009933"></asp:Label>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="btn_alterar" runat="server" CssClass="btn btn-primary btn-block enter-btn" Text="Confirmar Nova Palavra-Passe" OnClick="btn_alterar_Click"/>
                                    </div>
                                    <div class="d-flex">
                                        <button class="btn btn-facebook col mr-2">
                                            <i class="mdi mdi-facebook"></i>Facebook
                                        </button>
                                        <button class="btn btn-google col">
                                            <i class="mdi mdi-google-plus"></i>Google plus
                                        </button>
                                    </div>
                                    <asp:HyperLink ID="lbl_registo" runat="server" class="sign-up text-center" NavigateUrl="Login.aspx" Text="Já tem conta? Entre!"></asp:HyperLink>
                                    <p class="terms">By creating an account you are accepting our<a href="#"> Terms & Conditions</a></p>
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
