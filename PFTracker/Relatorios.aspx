<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Relatorios.aspx.cs" Inherits="PFTracker.Relatorios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Relatórios Financeiros</h2>

        <!-- Filtros -->
        <div class="row mb-4">
            <div class="col-md-4">
                <label for="startDate" class="form-label">Intervalo de Datas</label>
                <input type="date" id="startDate" class="form-control">
                <span>até</span>
                <input type="date" id="endDate" class="form-control">
            </div>
            <div class="col-md-4">
                <label for="reportType" class="form-label">Tipo de Relatório</label>
                <select id="reportType" class="form-select">
                    <option>Despesas</option>
                    <option>Receitas</option>
                    <option>Saldo</option>
                    <option>Relatório Completo</option>
                </select>
            </div>
            <div class="col-md-4">
                <button class="btn btn-primary mt-4" onclick="generateReport()">Gerar Relatório</button>
            </div>
        </div>

        <!-- Tabela de Relatórios Gerados -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Relatórios Gerados</h4>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Título</th>
                                    <th>Período</th>
                                    <th>Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Relatório de Despesas - Janeiro 2024</td>
                                    <td>01 Jan - 31 Jan 2024</td>
                                    <td>
                                        <button class="btn btn-info" onclick="viewReport('report1')">Visualizar</button>
                                        <button class="btn btn-success" onclick="downloadReport('report1', 'pdf')">Baixar PDF</button>
                                        <button class="btn btn-success" onclick="downloadReport('report1', 'excel')">Baixar Excel</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Relatório Completo - Fevereiro 2024</td>
                                    <td>01 Fev - 28 Fev 2024</td>
                                    <td>
                                        <button class="btn btn-info" onclick="viewReport('report2')">Visualizar</button>
                                        <button class="btn btn-success" onclick="downloadReport('report2', 'pdf')">Baixar PDF</button>
                                        <button class="btn btn-success" onclick="downloadReport('report2', 'excel')">Baixar Excel</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Visualização de Relatório (se necessário) -->
    <div class="modal" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="reportModalLabel">Relatório de Despesas - Janeiro 2024</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                </div>
                <div class="modal-body">
                    <!-- Conteúdo do relatório aqui -->
                    <p>Conteúdo detalhado do relatório...</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        function generateReport() {
            // Lógica para gerar relatório com base nos filtros
            alert("Gerando relatório...");
        }

        function viewReport(reportId) {
            // Lógica para exibir conteúdo do relatório (pode ser um modal, por exemplo)
            alert("Visualizando relatório: " + reportId);
        }

        function downloadReport(reportId, format) {
            // Lógica para exportar o relatório em PDF ou Excel
            alert("Baixando relatório " + reportId + " em formato: " + format);
        }
</script>

</asp:Content>
