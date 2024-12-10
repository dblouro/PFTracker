<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PFTracker.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Registar</title>
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
                                <h3 class="card-title text-left mb-3">Registo</h3>
                                <div>
                                    <div class="form-group">
                                        <label>Nome de Utilizador:</label>
                                        <asp:TextBox ID="tb_utilizador" runat="server" class="form-control p_input"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Email de Utilizador:</label>
                                        <asp:TextBox ID="tb_email" runat="server" class="form-control p_input"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email é campo obrigatório" ForeColor="#FF3300" ControlToValidate="tb_email">*</asp:RequiredFieldValidator>
                                        &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Introduza um email válido" ForeColor="#009933" ControlToValidate="tb_email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label>Telemovel</label>
                                        <asp:TextBox ID="tb_movel" runat="server" class="form-control p_input"></asp:TextBox>

                                    </div>
                                    <div class="form-group">
                                        <label>Palavra-Passe</label>
                                        <asp:TextBox ID="tb_pw" runat="server" class="form-control p_input" OnTextChanged="tb_pw_TextChanged" TextMode="Password"></asp:TextBox>
                                        <input type="hidden" id="senha_hidden" runat="server" />
                                        <button type="button" onclick="togglePassword()">👁</button>
                                        <br />
                                        <label>Força da Palavra-Passe</label>
                                        <asp:Label ID="lbl_validar" runat="server"></asp:Label>
                                    </div>
                                    <div class="form-group">
                                        <label>Confirmar Palavra-Passe</label>
                                        <asp:TextBox ID="tb_cfpw" runat="server" class="form-control p_input" TextMode="Password"></asp:TextBox>

                                    </div>
                                    <div class="form-group d-flex align-items-center justify-content-between">
                                        <asp:Label ID="lbl_mensagem" runat="server"></asp:Label>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="btn_registar" runat="server" CssClass="btn btn-primary btn-block enter-btn" OnClick="btn_registar_Click" Text="Registar"/>
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
            const passwordField = document.getElementById("<%= tb_pw.ClientID %>");
            if (passwordField.type === "password") {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        }
        //guarda a pw no campo oculto antes do postback
        document.getElementById("<%= tb_pw.ClientID %>").addEventListener("input", function() {
        document.getElementById("senha_hidden").value = this.value;
           });

        //restaura o valor de pw ao carregar a página após postback
        window.onload = function() {
            document.getElementById("<%= tb_pw.ClientID %>").value = document.getElementById("senha_hidden").value;
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
