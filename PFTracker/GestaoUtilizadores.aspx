<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="GestaoUtilizadores.aspx.cs" Inherits="PFTracker.GestaoUtilizadores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <h1>Gestão de Utlizadores</h1>
    <asp:Repeater ID="rpt_utilizadores" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="rpt_utilizadores_ItemDataBound" OnItemCommand="rpt_utilizadores_ItemCommand">
        <HeaderTemplate>
            <table border="1" width="1200">
                <tr><td><b>Nº</b></td>
                    <td><b>Nome</b></td>
                    <td><b>Palavra-Passe</b></td>
                    <td><b>Email</b></td>
                    <td><b>Contacto</b></td>
                    <td><b>Perfil</b></td>
                    <td><b>Estado</b></td>
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
                   </td>
                   <td>
                        <asp:TextBox ID="tb_perfil" runat="server"></asp:TextBox><b></td>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_estado" runat="server"></asp:TextBox><b></td>
                    </td>
                   <td>
                       <asp:Button ID="btn_gravar" CommandName="btn_gravar" runat="server" Text="Gravar" />
                       <asp:Button ID="btn_apagar" CommandName="btn_apagar" runat="server" Text="Apagar" />   
                   </td>
                </tr>
        </ItemTemplate>
        <AlternatingItemTemplate>
                <tr style="background-color:darkgreen">
                    <td> <asp:Label ID="lbl_num" runat="server"></asp:Label></td>
                     <td>
                         <asp:TextBox ID="tb_nome" runat="server"></asp:TextBox></td>
                     <td> 
                         <asp:TextBox ID="tb_pw" runat="server"></asp:TextBox></td>
                     <td> 
                         <asp:TextBox ID="tb_email" runat="server"></asp:TextBox><b></td>
                    <td>
                        <asp:TextBox ID="tb_contacto" runat="server"></asp:TextBox><b></td>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_perfil" runat="server"></asp:TextBox><b></td>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_estado" runat="server"></asp:TextBox><b></td>
                    </td>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:atec_cascaisConnectionString %>" SelectCommand="SELECT * FROM [LojaOnlineUtilizador]"></asp:SqlDataSource>
    <br />
    <asp:Button ID="btn_gravarTudo" runat="server" OnClick="btn_gravarTudo_Click" Text="Gravar Tudo" />
    &nbsp;<br />
    <br />
    <br />
    <asp:HiddenField ID="hiddenFieldNumFormando" runat="server" />
</form>
</asp:Content>
