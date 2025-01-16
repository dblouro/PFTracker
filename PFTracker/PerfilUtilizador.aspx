<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="PerfilUtilizador.aspx.cs" Inherits="PFTracker.PerfilUtilizador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<body>
    <form id="form1" runat="server">
        <div class="container-scroller">
            <div class="container-fluid page-body-wrapper full-page-wrapper">
                <div class="row w-100 m-0">
                    <div class="content-wrapper full-page-wrapper d-flex align-items-center auth login-bg">
                        <div class="card col-lg-4 mx-auto">
                            <div class="card-body px-5 py-5">
                                <h3 class="card-title text-left mb-3">Perfil do Utilizador</h3>
                                <div>
                                    <div class="form-group">
                                         <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/ImageHandler.ashx?id=" + Eval("id_utilizador") %>'  BorderColor="Black" BorderWidth="1px" Height="250px" Width="250px" />
                                    </div>
                                    <div class="form-group">
                                        <label>Nome de Utilizador:</label>
                                        <asp:TextBox ID="tb_utilizador" runat="server" class="form-control p_input" ReadOnly></asp:TextBox>
                                    </div>

                                    
                                    <div class="form-group">
                                        <label>Email de Utilizador:</label>
                                        <asp:TextBox ID="tb_email" runat="server" class="form-control p_input" ReadOnly></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email é campo obrigatório" ForeColor="#FF3300" ControlToValidate="tb_email">*</asp:RequiredFieldValidator>
                                        &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Introduza um email válido" ForeColor="#009933" ControlToValidate="tb_email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label>Telemovel</label>
                                        <asp:TextBox ID="tb_movel" runat="server" class="form-control p_input" ReadOnly></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Número de Identificação Fiscal</label>
                                        <asp:TextBox ID="tb_nif" runat="server" class="form-control p_input" ReadOnly></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Morada</label>
                                        <asp:TextBox ID="tb_morada" runat="server" class="form-control p_input" ReadOnly></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Palavra-Passe</label>
                                        <asp:TextBox ID="tb_pw" runat="server" class="form-control p_input" OnTextChanged="tb_pw_TextChanged" TextMode="Password" ReadOnly></asp:TextBox>
                                        <input type="hidden" id="senha_hidden" runat="server" />
                                        <button type="button" onclick="togglePassword()">👁</button>
                                        <br />
                                        <label>Força da Palavra-Passe</label>
                                        <asp:Label ID="lbl_validar" runat="server"></asp:Label>
                                    </div>
                                    <div class="form-group">
                                        <label>Confirmar Palavra-Passe</label>
                                        <asp:TextBox ID="tb_cfpw" runat="server" class="form-control p_input" TextMode="Password" ReadOnly></asp:TextBox>

                                    </div>
                                    <div class="form-group d-flex align-items-center justify-content-between">
                                        <asp:Label ID="lbl_mensagem" runat="server"></asp:Label>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="btn_guardar" runat="server" CssClass="btn btn-primary btn-block enter-btn" OnClick="btn_guardar_Click" Text="Guardar"/>
                                    </div>
                                    <div class="d-flex">
                                        
                                    </div>
                               
                                    <p class="terms">By editing an account you are accepting our<a href="#"> Terms & Conditions</a></p>
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
</asp:Content>
