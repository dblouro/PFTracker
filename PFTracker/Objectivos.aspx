<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Objectivos.aspx.cs" Inherits="PFTracker.Objectivos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Gestão de Objetivos</h2>
            <asp:Button ID="btn_adicionar_objetivo" runat="server" Text="Adicionar Objetivo" OnClientClick="$('#addGoalModal').modal('show'); return false;" class="btn btn-primary" />
        </div>
        <div class="row">
            <div class="col-12">
                <asp:Repeater ID="rpt_tabela_objetivos" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                        <table border="1" class="table table-striped">
                            <tr>
                                <th>Objetivo</th>
                                <th>Valor Atual</th>
                                <th>Valor Alvo</th>
                                <th>Data Inicial</th>
                                <th>Data Limite</th>
                                <th>Progresso</th>
                                <th>Ações</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("descricao") %></td>
                            <td><%# Eval("valor_inicial") %></td>
                            <td><%# Eval("valor_alvo") %></td>
                            <td><%# Eval("data_criacao") %></td>
                            <td><%# Eval("data_alvo") %></td>
                            <td>
                                <div class="progress" style="height: 20px;">
                                    <div class="progress-bar bg-success" role="progressbar"
                                        style='<%# "width: " + Math.Round((Convert.ToDouble(Eval("valor_inicial")) / Convert.ToDouble(Eval("valor_alvo"))) * 100) + "%;" %>'
                                        aria-valuenow="<%# Eval("valor_inicial") %>"
                                        aria-valuemin="0"
                                        aria-valuemax="<%# Eval("valor_alvo") %>">
                                        <%# Math.Round((Convert.ToDouble(Eval("valor_inicial")) / Convert.ToDouble(Eval("valor_alvo"))) * 100) %>% Completo
                                    </div>
                                </div>
                            </td>
                            <td>
                                <asp:Button ID="btn_detalhe_objectivos" runat="server" Text="Ver Detalhes" class="btn btn-primary me-2" CommandArgument='<%# Eval("id_objetivo") %>' OnClick="btn_detalhe_objectivos_Click" />
                                <asp:Button ID="btn_add_saldo_objectivos" runat="server" Text="Adicionar Saldo" class="btn btn-success" CommandArgument='<%# Eval("id_objetivo") %>' OnClick="btn_add_saldo_objectivos_Click" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:pftrackerConnectionString_Categorias %>' SelectCommand="SELECT * FROM [pft_objetivo]"></asp:SqlDataSource>
            </div>
        </div>
    </div>

    <!-- Modal para adicionar objetivo -->
    <div class="modal fade" id="addGoalModal" tabindex="-1" aria-labelledby="addGoalModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addGoalModalLabel">Adicionar Novo Objetivo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="addGoalForm">
                        <div class="mb-3">
                            <asp:Label ID="lbl_objetivo" runat="server" Text="Objetivo" class="form-label"></asp:Label>
                            <asp:TextBox ID="tb_descricao_objetivo" runat="server" placeholder="Ex.: Comprar um carro" class="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lbl_valor_alvo" runat="server" Text="Valor a Alcançar" placeholder="Ex.: 20000"></asp:Label>
                            <asp:TextBox ID="tb_valor_alvo" runat="server" placeholder="Ex.: 20000" class="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lbl_data_alvo" runat="server" Text="Data Limite"></asp:Label>
                            <input type="date" class="form-control" id="goalDeadline">
                        </div>
                        <button type="submit" class="btn btn-primary">Salvar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para detalhes do objetivo -->
    <div class="modal fade" id="detailsModal" tabindex="-1" aria-labelledby="detailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detailsModalLabel">Detalhes do Objetivo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h3>Objetivo: <span id="detailsGoalName"></span></h3>

                    <asp:Label ID="lbl_descricao_detalhes" runat="server" Text="Valor a Alcançar" class="form-label"></asp:Label>
                    <asp:TextBox ID="tb_descricao_detalhes" runat="server" class="form-control"></asp:TextBox>

                    <asp:Label ID="valor_atual_detalhes" runat="server" Text="Valor Atual"></asp:Label>
                    <asp:TextBox ID="tb_detalhes_valor_atual" runat="server" class="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_valor_alvo_detalhes" runat="server" Text="Valor a Alcançar" class="form-label"></asp:Label>
                    <asp:TextBox ID="tb_detalhes_valor_alvo" runat="server" class="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_data_criacao_detalhes" runat="server" Text="Data Inicial" class="form-label"></asp:Label>
                    <input type="date" id="date_add_create" class="form-control mb-2" runat="server">

                    <asp:Label ID="lbl_data_limite_detalhes" runat="server" Text="Data Limite" class="form-label"></asp:Label>
                    <input type="date" id="date_add_end" class="form-control mb-2" runat="server">
                    <div class="modal-footer d-flex justify-content-between">
                        <div>
                            <!-- Botão Editar alterna para o modo de edição -->
                            <asp:Button ID="btn_editar" runat="server" Text="Editar" CssClass="btn btn-warning me-2" OnClick="btn_editar_Click" />
                            <!-- Botão Salvar visível apenas no modo de edição -->
                            <asp:Button ID="btn_salvar" runat="server" Text="Salvar" CssClass="btn btn-success me-2" OnClick="btn_salvar_Click" Visible="false" />
                            <!-- Botão Eliminar -->
                            <asp:Button ID="btn_eliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btn_eliminar_Click" />
                        </div>
                        <!-- Botão Fechar -->
                        <asp:Button ID="btn_fechar" runat="server" Text="Fechar" CssClass="btn btn-secondary" />
                    </div>
                    <asp:HiddenField ID="hf_id_objetivo" runat="server" />
                    <asp:Label ID="lbl_status" runat="server" CssClass="text-success mt-2 d-block text-center"></asp:Label>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para adicionar saldo ao objetivo -->
    <div class="modal fade" id="addSaldoModal" tabindex="-1" aria-labelledby="addSaldoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addSaldoModalLabel">Adicionar Saldo ao Objetivo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <asp:Label ID="lbl_adicionar_saldo" runat="server" Text="Valor a Adicionar"></asp:Label>
                        <asp:TextBox ID="tb_add_saldo" runat="server" placeholder="Ex.: 500" class="form-control"></asp:TextBox>
                    </div>
                    <asp:Button ID="btn_add_saldo" runat="server" Text="Salvar" class="btn btn-primary" OnClick="btn_add_saldo_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

