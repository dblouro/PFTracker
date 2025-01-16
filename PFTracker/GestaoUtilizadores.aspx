<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="GestaoUtilizadores.aspx.cs" Inherits="PFTracker.GestaoUtilizadores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Gestão de Utlizadores</h2>
            </div>
            <div class="row">
                <div class="col-12">
                    <asp:Repeater ID="rpt_utilizadores" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="rpt_utilizadores_ItemDataBound" OnItemCommand="rpt_utilizadores_ItemCommand">
                        <HeaderTemplate>
                            <table border="1" width="1200">
                                <tr><td><b>Nº</b></td>
                                    <td><b>Nome</b></td>
                                    <td><b>Palavra-Passe</b></td>
                                    <td><b>Email</b></td>
                                    <td><b>NIF</b></td>
                                    <td><b>Telemovel</b></td>
                                    <td><b>Morada</b></td>
                                    <td><b>Perfil</b></td>
                                    <td><b>Ativo</b></td>
                                </tr>
            
                        </HeaderTemplate>
                        <ItemTemplate>
                               <tr>
                                   <td> <asp:Label ID="lbl_num" runat="server"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="tb_nome" runat="server"></asp:TextBox></td>
                                    <td> 
                                        <asp:TextBox ID="tb_pw" runat="server"></asp:TextBox></td>
                                    <td> 
                                        <asp:TextBox ID="tb_email" runat="server"></asp:TextBox><b></td>
                                   <td>
                                        <asp:TextBox ID="tb_contacto" runat="server"></asp:TextBox><b></td>
                                   <td>
                                        <asp:TextBox ID="tb_nif" runat="server"></asp:TextBox><b></td>
                                   <td>
                                        <asp:TextBox ID="tb_perfil" runat="server"></asp:TextBox><b></td>
                                    <td>
                                        <asp:TextBox ID="tb_estado" runat="server"></asp:TextBox><b></td>
                                   <td>
                                        <asp:TextBox ID="tb_morada" runat="server"></asp:TextBox><b></td>
                                   <td>
                                       <asp:Button ID="btn_gravar" CommandName="btn_gravar" runat="server" Text="Gravar" />
                                       <asp:Button ID="btn_apagar" CommandName="btn_apagar" runat="server" Text="Apagar" />   
                                   </td>
                                </tr>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                                <tr>
                                    <td> <asp:Label ID="lbl_num" runat="server"></asp:Label></td>
                                     <td>
                                         <asp:TextBox ID="tb_nome" runat="server"></asp:TextBox></td>
                                     <td> 
                                         <asp:TextBox ID="tb_pw" runat="server"></asp:TextBox></td>
                                     <td> 
                                         <asp:TextBox ID="tb_email" runat="server"></asp:TextBox><b></td>
                                    <td>
                                        <asp:TextBox ID="tb_contacto" runat="server"></asp:TextBox><b></td>
                                    <td>
                                        <asp:TextBox ID="tb_nif" runat="server"></asp:TextBox><b></td>
                                    <td>
                                        <asp:TextBox ID="tb_perfil" runat="server"></asp:TextBox><b></td>
                                    <td>
                                        <asp:TextBox ID="tb_estado" runat="server"></asp:TextBox><b></td>
                                    <td>
                                        <asp:TextBox ID="tb_morada" runat="server"></asp:TextBox><b></td>
                                    <td>
                                        <asp:Button ID="btn_gravar" CommandName="btn_gravar" runat="server" Text="Gravar" />
                                        <asp:Button ID="btn_apagar" CommandName="btn_apagar" runat="server" Text="Apagar" />
                                    </td>
                                 </tr>
                        </AlternatingItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:atec_cascaisConnectionString %>" SelectCommand="SELECT * FROM [pft_utilizador]"></asp:SqlDataSource>
                    <br />
                    <asp:Button ID="btn_gravarTudo" runat="server" OnClick="btn_gravarTudo_Click" Text="Gravar Tudo" />
                    &nbsp;<br />
                    <asp:HiddenField ID="hiddenFieldNumFormando" runat="server" />
                </div>
            </div>
        </div>
</form>
</asp:Content>
