<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Consulta.aspx.cs" Inherits="PFTracker.Consulta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/consulta.css"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Título -->
        <div class="row">
            <div class="col-12 text-center mb-4">
                <h1>Consulta de Transações</h1>
            </div>
        </div>
        <!-- Filtros -->
        <div class="row mb-4">
            <div class="col-md-3">
                <label for="dateRange">Intervalo de Datas</label>
                <input type="date" id="dateStart" class="form-control mb-2" runat="server">
                <input type="date" id="dateEnd" class="form-control" runat="server">
            </div>
            <div class="col-md-3">
                <label for="categoryFilter">Categoria</label>
                <asp:DropDownList ID="ddp_categorias" runat="server" class="form-control" AutoPostBack="True">
                    <asp:ListItem Text="Todas" Value="0" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-3">
                <label for="valueRange">Faixa de Valor</label>
                <asp:TextBox ID="tb_min" runat="server" class="form-control" placeholder="Min"></asp:TextBox>
                <asp:TextBox ID="tb_max" runat="server" class="form-control" placeholder="Max"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <label>&nbsp;</label>
                <asp:Button ID="btn_procurar" runat="server" Text="Procurar" class="btn btn-primary btn-block mt-2" OnClick="btn_procurar_Click" />
                <asp:Button ID="btn_adicionar" runat="server" Text="Adicionar" class="btn btn-primary btn-block mt-2" OnClientClick="$('#addTransactionModal').modal('show'); return false;" />
            </div>
        </div>
        <!-- Resultados em Tabela -->
        <div class="row">
            <div class="col-12">
                <asp:Repeater ID="rpt_tabela_consulta" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                        <table border="1" class="table table-striped">
                            <tr>
                                <th>Data</th>
                                <th>Descrição</th>
                                <th>Categoria</th>
                                <th>Valor</th>
                                <th>Tipo de Pagamento</th>
                                <th>Ações</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("data") %></td>
                            <td><%# Eval("descricao") %></td>
                            <td><%# Eval("nome") %></td>
                            <td><%# Eval("valor") %></td>
                            <td><%# Eval("tipo_transacao") %></td>
                            <td>
                                <asp:Button ID="btn_ver" runat="server" Text="Ver Detalhes" CommandArgument='<%# Eval("id_transacao") %>' OnClick="btn_ver_Click" /></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:pftrackerConnectionString_Categorias %>' SelectCommand="SELECT * FROM [Consulta]"></asp:SqlDataSource>
            </div>
        </div>
    </div>
    <!--Modal Add trancacao-->
    <div class="modal fade" id="addTransactionModal" tabindex="-1" aria-labelledby="addTransactionModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addTransactionModalLabel">Adicionar Transação</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="tb_descricao" runat="server" class="form-control mb-2" Placeholder="Descrição"></asp:TextBox>
                    <asp:TextBox ID="tb_valor" runat="server" class="form-control mb-2" Placeholder="Valor"></asp:TextBox>
                    <asp:DropDownList ID="ddl_categoria_add" runat="server" class="form-control mb-2" DataSourceID="SqlDataSource2" DataTextField="nome" DataValueField="id_categoria">
                    </asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:pftrackerConnectionString_Categorias %>' SelectCommand="SELECT * FROM [pft_categoria]"></asp:SqlDataSource>
                    <input type="date" id="date_add" class="form-control mb-2" runat="server">
                    <asp:DropDownList ID="ddl_tipo_transacao" runat="server" class="form-control mb-2">
                        <asp:ListItem>receita</asp:ListItem>
                        <asp:ListItem>despesa</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label ID="lbl_add_transacao" runat="server" Text=""></asp:Label>

                </div>
                <div class="modal-footer">
                    <asp:Button ID="btn_add" runat="server" Text="Salvar" CssClass="btn btn-primary" OnClick="btn_adicionar_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <!--Modal Details -->
    <div class="modal fade" id="viewDetailsModal" tabindex="-1" aria-labelledby="viewDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewDetailsModalLabel">Detalhes da Transação</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-2">
                        <label for="tb_detalhes_descricao" class="form-label">Descrição</label>
                        <asp:TextBox ID="tb_detalhes_descricao" runat="server" CssClass="form-control" Enabled="false" BackColor="#2A3038"></asp:TextBox>
                    </div>
                    <div class="mb-2">
                        <label for="tb_detalhes_nome" class="form-label">Nome</label>
                        <asp:TextBox ID="tb_detalhes_nome" runat="server" CssClass="form-control" Enabled="false" BackColor="#2A3038"></asp:TextBox>
                    </div>
                    <div class="mb-2">
                        <label for="tb_detalhes_valor" class="form-label">Valor</label>
                        <asp:TextBox ID="tb_detalhes_valor" runat="server" CssClass="form-control" Enabled="false" BackColor="#2A3038"></asp:TextBox>
                    </div>
                    <div class="mb-2">
                        <label for="ddl_detalhes_transacao" class="form-label">Tipo de Transação</label>
                        <asp:DropDownList ID="ddl_detalhes_transacao" runat="server" CssClass="form-control" Enabled="false" BackColor="#2A3038">
                            <asp:ListItem>receita</asp:ListItem>
                            <asp:ListItem>despesa</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <asp:HiddenField ID="hf_id_transacao" runat="server" />
                </div>
                <div class="modal-footer d-flex justify-content-between">
                    <div>
                        <!-- Botão Editar alterna para o modo de edição -->
                        <asp:Button ID="btn_editar" runat="server" Text="Editar" CssClass="btn btn-warning me-2" OnClick="btn_editar_Click" />
                        <!-- Botão Salvar visível apenas no modo de edição -->
                        <asp:Button ID="btn_salvar" runat="server" Text="Salvar" CssClass="btn btn-success me-2" OnClick="btn_salvar_Click" Visible="false" />
                        <!-- Botão Eliminar -->
                        <asp:Button ID="btn_eliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btn_eliminar_Click"/>
                    </div>
                    <!-- Botão Fechar -->
                    <asp:Button ID="btn_fechar" runat="server" Text="Fechar" CssClass="btn btn-secondary" />
                </div>
                <asp:Label ID="lbl_status" runat="server" CssClass="text-success mt-2 d-block text-center"></asp:Label>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <small>Última atualização: 10/12/2024</small>
        </div>
    </div>
</asp:Content>
