<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PFTracker.Login" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
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
                                <h3 class="card-title text-left mb-3">Login</h3>
                                <div>
                                    <div class="form-group">
                                        <label>Nome *</label>
                                        <asp:TextBox ID="tb_utilizador" runat="server" class="form-control p_input"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Password *</label>
                                        <asp:TextBox ID="tb_pw" runat="server" class="form-control p_input" TextMode="Password"></asp:TextBox>
                                        <input type="hidden" id="senha_hidden" runat="server" />
                                    </div>
                                    <div class="form-group d-flex align-items-center justify-content-between">
                                        <div class="form-check">
                                            <asp:CheckBox ID="Cb_lembrar" runat="server" CssClass="form-check-input" Text="Lembrar" />
                                        </div>
                                        <asp:HyperLink ID="lbl_esqueceu" runat="server" class="forgot-pass" NavigateUrl="RecoverPW.aspx" Text="Esqueceu-se da password?"></asp:HyperLink>
                                        <asp:Label ID="lbl_mensagem" runat="server"></asp:Label>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="btn_login" runat="server" CssClass="btn btn-primary btn-block enter-btn" Text="Login" OnClick="btn_login_Click"/>
                                    </div>
                                    <br />
                                    <div class="d-flex">
                                        <!-- <asp:Button ID="btn_facebook" runat="server" Class="btn btn-facebook mr-2 col" Text="Facebook" /> -->
                                        <!-- Botão do Google -->
                                        <div id="g_id_onload"
                                             data-client_id="476932828583-kqhfbbokmai06j6d5fds6cbohpsjigio.apps.googleusercontent.com"
                                             data-login_uri="https://localhost:44321/Login.aspx"
                                             data-auto_prompt="false"
                                             class="col">
                                        </div>
                                        <!-- <asp:Button ID="btn_google" runat="server" Class="g_id_signin btn btn-google col" data-type="standard" data-shape="rectangular" data-theme="outline" Text="Google" OnClick="btn_google_Click"/> -->
                                        <script src="https://accounts.google.com/gsi/client" async defer></script>

                                        <script type="text/javascript">
                                            window.onload = function () {
                                                google.accounts.id.initialize({
                                                    client_id: "476932828583-kqhfbbokmai06j6d5fds6cbohpsjigio.apps.googleusercontent.com",
                                                    callback: handleCredentialResponse
                                                });
                                                google.accounts.id.renderButton(
                                                    document.getElementById("g_id_onload"),
                                                    { theme: "outline", size: "large" }
                                                );
                                            };

                                            function handleCredentialResponse(response) {
                                                var idToken = response.credential;

                                                // Enviar o id_token para o servidor
                                                var hiddenField = document.createElement("input");
                                                hiddenField.type = "hidden";
                                                hiddenField.name = "id_token";
                                                hiddenField.value = idToken;

                                                var form = document.createElement("form");
                                                form.method = "POST";
                                                form.action = "/Login.aspx";
                                                form.appendChild(hiddenField);
                                                document.body.appendChild(form);
                                                form.submit();
                                            }
                                        </script>
                                    </div>
                                    <br />
                                    <asp:HyperLink ID="lbl_registo" runat="server" class="sign-up" NavigateUrl="Register.aspx" Text="Não tem conta? Registe-se!"></asp:HyperLink>
                                    
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
