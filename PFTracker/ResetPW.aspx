<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPW.aspx.cs" Inherits="PFTracker.ResetPW" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>ResetPW</title>
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
                                <h3 class="card-title text-left mb-3">Redefinir Palavra-Passe</h3>
                                
                                <div>
                                    <div class="form-group">
                                        <asp:Label ID="lbl_novaPW" runat="server" Text="Nova Palavra-Passe: "></asp:Label>
                                        <asp:TextBox ID="tb_novaPW" runat="server" OnTextChanged="tb_pw_TextChanged" TextMode="Password" class="form-control p_input"></asp:TextBox>
                                        <input type="hidden" id="senha_hidden" runat="server" />
                                        <!-- <button type="button" onclick="togglePassword()">👁️</button> -->
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="lbl_confirmaPW" runat="server" Text="Confirme a Palavra-Passe: "></asp:Label>
                                        <asp:TextBox ID="tb_confirmaPW" runat="server" TextMode="Password" class="form-control p_input"></asp:TextBox>
                                        <input type="hidden" id="Hidden1" runat="server" />
                                        <!-- <button type="button" onclick="togglePassword()">👁️</button> -->
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="lbl_forcaPW" runat="server" Text="Força da Palavra-Passe: "></asp:Label>
                                        <asp:Label ID="lbl_validar" runat="server"></asp:Label>
                                        
                                    </div>
                                    <div class="form-group">
                                    </div>
                                    <div class="form-group d-flex align-items-center justify-content-between">
                                        <asp:Label ID="lbl_mensagem" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="btn_salvar" runat="server" CssClass="btn btn-primary btn-block enter-btn" Text="Confirmar Reset PW" OnClick="btn_salvar_Click"/>
                                    </div>
                                    <div class="d-flex">
                                        <button class="btn btn-facebook col mr-2">
                                            <i class="mdi mdi-facebook"></i>Facebook
                                        </button>
                                        <button class="btn btn-google col">
                                            <i class="mdi mdi-google-plus"></i>Google plus
                                        </button>
                                    </div>
                                    <p class="sign-up text-center">Already have an Account?<a href="Login.aspx"> Sign Up</a></p>
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
        <script>
        //para alternar o tipo do campo de password para text e vice-versa
        function togglePassword() {
            const passwordField = document.getElementById("<%= tb_novaPW.ClientID %>");
            if (passwordField.type === "password") {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        }
        //guarda a pw no campo oculto antes do postback
        document.getElementById("<%= tb_novaPW.ClientID %>").addEventListener("input", function() {
        document.getElementById("senha_hidden").value = this.value;
           });

        //restaura o valor de pw ao carregar a página após postback
        window.onload = function() {
            document.getElementById("<%= tb_novaPW.ClientID %>").value = document.getElementById("senha_hidden").value;
        }
        </script>
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
