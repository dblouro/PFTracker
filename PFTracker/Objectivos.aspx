<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Objectivos.aspx.cs" Inherits="PFTracker.Objectivos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary">Gestão de Objetivos</h2>
            <asp:Button ID="btn_adicionar_objetivo" runat="server" Text="Adicionar Objetivo" OnClientClick="$('#addGoalModal').modal('show'); return false;" CssClass="btn btn-primary" />
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <asp:Repeater ID="rpt_tabela_objetivos" runat="server">
                <ItemTemplate>
                    <div class="col">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title text-secondary"><%# Eval("descricao") %></h5>
                                <p class="card-text">
                                    <strong>Valor Atual:</strong> <%# Eval("valor_inicial") %><br />
                                    <strong>Valor Alvo:</strong> <%# Eval("valor_alvo") %><br />
                                    <strong>Data Inicial:</strong> <%# Eval("data_criacao") %><br />
                                    <strong>Data Limite:</strong> <%# Eval("data_alvo") %>
                                </p>
                                <div class="progress mb-3" style="height: 20px;">
                                    <div class="progress-bar bg-success" role="progressbar"
                                        style='<%# Eval("valor_inicial") != DBNull.Value && Eval("valor_alvo") != DBNull.Value && Convert.ToDouble(Eval("valor_alvo")) > 0 
                 ? "width: " + Math.Round((Convert.ToDouble(Eval("valor_inicial")) / Convert.ToDouble(Eval("valor_alvo"))) * 100) + "%": "width: 0%" %>'
                                        aria-valuenow="<%# Eval("valor_inicial") != DBNull.Value ? Eval("valor_inicial") : 0 %>"
                                        aria-valuemin="0"
                                        aria-valuemax="<%# Eval("valor_alvo") != DBNull.Value ? Eval("valor_alvo") : 0 %>">
                                        <%# Eval("valor_inicial") != DBNull.Value && Eval("valor_alvo") != DBNull.Value && Convert.ToDouble(Eval("valor_alvo")) > 0 
            ? Math.Round((Convert.ToDouble(Eval("valor_inicial")) / Convert.ToDouble(Eval("valor_alvo"))) * 100) + "%" 
            : "0%" %>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <asp:Button ID="btn_detalhe_objectivos" runat="server" Text="Detalhes" CssClass="btn btn-outline-primary btn-sm" CommandArgument='<%# Eval("id_objetivo") %>' OnClick="btn_detalhe_objectivos_Click" />
                                    <asp:Button ID="btn_add_saldo_objectivos" runat="server" Text="Adicionar Saldo" CssClass="btn btn-outline-success btn-sm" CommandArgument='<%# Eval("id_objetivo") %>' OnClick="btn_add_saldo_objectivos_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
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
                            <asp:Label ID="lbl_objetivo" runat="server" Text="Objetivo" CssClass="form-label"></asp:Label>
                            <asp:TextBox ID="tb_descricao_objetivo" runat="server" placeholder="Ex.: Comprar um carro" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lbl_valor_alvo" runat="server" Text="Valor a Alcançar" CssClass="form-label"></asp:Label>
                            <asp:TextBox ID="tb_valor_alvo" runat="server" placeholder="Ex.: 20000" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lbl_data_alvo" runat="server" Text="Data Limite" CssClass="form-label"></asp:Label>
                            <input type="date" class="form-control" id="goalDeadline" runat="server">
                        </div>
                        <asp:Button ID="btn_add_objetivo" runat="server" Text="Adicionar" CssClass="btn btn-primary" OnClick="btn_add_objetivo_Click" />
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

                    <asp:Label ID="lbl_descricao_detalhes" runat="server" Text="Descrição" CssClass="form-label" ></asp:Label>
                    <asp:TextBox ID="tb_descricao_detalhes" runat="server" CssClass="form-control" Enabled="false" BackColor="#2A3038"></asp:TextBox>

                    <asp:Label ID="valor_atual_detalhes" runat="server" Text="Valor Atual" CssClass="form-label" ></asp:Label>
                    <asp:TextBox ID="tb_detalhes_valor_atual" runat="server" CssClass="form-control" Enabled="false" BackColor="#2A3038"></asp:TextBox>

                    <asp:Label ID="lbl_valor_alvo_detalhes" runat="server" Text="Valor a Alcançar" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="tb_detalhes_valor_alvo" runat="server" CssClass="form-control" Enabled="false" BackColor="#2A3038"></asp:TextBox>

                    <asp:Label ID="lbl_data_criacao_detalhes" runat="server" Text="Data Inicial" CssClass="form-label"></asp:Label>
                    <input type="date" id="date_add_create" class="form-control mb-2" runat="server">

                    <asp:Label ID="lbl_data_limite_detalhes" runat="server" Text="Data Limite" CssClass="form-label"></asp:Label>
                    <input type="date" id="date_add_end" class="form-control mb-2" runat="server">

                    <div class="modal-footer d-flex justify-content-between">
                        <div>
                            <asp:Button ID="btn_editar" runat="server" Text="Editar" CssClass="btn btn-warning me-2" OnClick="btn_editar_Click" />
                            <asp:Button ID="btn_salvar" runat="server" Text="Salvar" CssClass="btn btn-success me-2" OnClick="btn_salvar_Click" Visible="false" />
                            <asp:Button ID="btn_eliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btn_eliminar_Click" />
                        </div>
                        <asp:Button ID="btn_fechar" runat="server" Text="Fechar" CssClass="btn btn-secondary" />
                    </div>
                    <asp:HiddenField ID="hf_id_objetivo" runat="server" />
                    <asp:Label ID="lbl_status" runat="server" CssClass="text-success mt-2 d-block text-center"></asp:Label>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal para adicionar saldo -->
    <div class="modal fade" id="addSaldoModal" tabindex="-1" aria-labelledby="addSaldoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addSaldoModalLabel">Adicionar Saldo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lbl_saldo" runat="server" Text="Digite o valor a adicionar:" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="tb_add_saldo" runat="server" CssClass="form-control" placeholder="Ex.: 1000"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btn_confirmar_add_saldo" runat="server" Text="Adicionar" CssClass="btn btn-success" OnClick="btn_confirmar_add_saldo_Click" />
                    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="btn_cancelar_Click" class="btn btn-secondary"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
