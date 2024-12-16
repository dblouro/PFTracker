<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Analise.aspx.cs" Inherits="PFTracker.Analise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Título e filtros -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Análise Financeira</h2>
            <div class="filters">
                <label for="dateRange" class="form-label">Intervalo de Datas</label>
                <input type="date" id="startDate" class="form-control" style="display: inline-block; width: auto;">
                <span>até</span>
                <input type="date" id="endDate" class="form-control" style="display: inline-block; width: auto;">
            </div>
        </div>

        <!-- Gráficos -->
        <div class="row">
            <!-- Gráfico de Pizza -->
            <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Distribuição de Despesas</h4>
                        <canvas id="expensePieChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Gráfico de Barras -->
            <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Receitas vs Despesas</h4>
                        <canvas id="incomeExpenseBarChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabela de transações -->
        <div class="row">
            <div class="col-md-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Transações Detalhadas</h4>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Data</th>
                                    <th>Descrição</th>
                                    <th>Categoria</th>
                                    <th>Tipo</th>
                                    <th>Valor</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>10 Dez</td>
                                    <td>Supermercado</td>
                                    <td>Alimentação</td>
                                    <td>Despesa</td>
                                    <td>$200.00</td>
                                </tr>
                                <tr>
                                    <td>09 Dez</td>
                                    <td>Salário</td>
                                    <td>Receita</td>
                                    <td>Entrada</td>
                                    <td>$1,200.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts para gráficos -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Gráfico de Pizza
            var pieCtx = document.getElementById("expensePieChart").getContext("2d");
            new Chart(pieCtx, {
                type: "pie",
                data: {
                    labels: ["Alimentação", "Transporte", "Lazer", "Outros"],
                    datasets: [{
                        data: [500, 200, 150, 100],
                        backgroundColor: ["#007bff", "#28a745", "#ffc107", "#6c757d"]
                    }]
                }
            });

            // Gráfico de Barras
            var barCtx = document.getElementById("incomeExpenseBarChart").getContext("2d");
            new Chart(barCtx, {
                type: "bar",
                data: {
                    labels: ["Janeiro", "Fevereiro", "Março", "Abril"],
                    datasets: [
                        {
                            label: "Receitas",
                            data: [3000, 4000, 3500, 3800],
                            backgroundColor: "#28a745"
                        },
                        {
                            label: "Despesas",
                            data: [2500, 3000, 2800, 3200],
                            backgroundColor: "#dc3545"
                        }
                    ]
                }
            });
        });
</script>

</asp:Content>
