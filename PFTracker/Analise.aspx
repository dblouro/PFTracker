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
                <button id="applyFilters" class="btn btn-primary" style="margin-left: 10px;">Aplicar</button>
            </div>
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
    <div class="row">
        <div class="col-md-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Previsão de Despesas (Próximos 3 Meses)</h4>
                    <table class="table" id="previsaoDespesasTable">
                        <thead>
                            <tr>
                                <th>Categoria</th>
                                <th>Mês</th>
                                <th>Média de Despesas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Previsões serão carregadas aqui -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
        <!-- Scripts para gráficos -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            fetch("Analise.aspx/ObterDadosGraficos", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({})
            })
                .then(response => response.json())
                .then(data => {
                    const dados = JSON.parse(data.d);

                    // Atualizar Gráfico de Pizza
                    new Chart(document.getElementById("expensePieChart").getContext("2d"), {
                        type: "pie",
                        data: {
                            labels: dados.despesas.labels,
                            datasets: [{
                                data: dados.despesas.valores,
                                backgroundColor: ["#007bff", "#28a745", "#ffc107", "#6c757d"]
                            }]
                        }
                    });

                    // Atualizar Gráfico de Barras
                    new Chart(document.getElementById("incomeExpenseBarChart").getContext("2d"), {
                        type: "bar",
                        data: {
                            labels: dados.receitasDespesas.meses,
                            datasets: [
                                {
                                    label: "Receitas",
                                    data: dados.receitasDespesas.receitas,
                                    backgroundColor: "#28a745"
                                },
                                {
                                    label: "Despesas",
                                    data: dados.receitasDespesas.despesas,
                                    backgroundColor: "#dc3545"
                                }
                            ]
                        }
                    });
                })
                .catch(error => console.error("Erro ao carregar os dados:", error));
        });

        document.addEventListener("DOMContentLoaded", function () {
            // Obter o mês atual (Janeiro = 0, por isso adicionamos 1)
            const mesAtual = new Date().getMonth() + 1;

            // Chamar o WebMethod com o mês atual
            fetch("Analise.aspx/ObterPrevisaoDespesas", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ mesAtual: mesAtual }) // Passa o mês atual
            })
                .then(response => response.json())
                .then(data => {
                    console.log("Dados recebidos:", data);
                    const previsoes = JSON.parse(data.d);

                    const tabelaBody = document.querySelector("#previsaoDespesasTable tbody");
                    tabelaBody.innerHTML = "";

                    previsoes.forEach(previsao => {
                        const linha = document.createElement("tr");
                        linha.innerHTML = `
                    <td>${previsao.Categoria}</td>
                    <td>${["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"][previsao.Mes - 1]}</td>
                    <td>${previsao.MediaMensalDespesas.toFixed(2)} €</td>
                `;
                        tabelaBody.appendChild(linha);
                    });
                })
                .catch(error => console.error("Erro ao carregar as previsões:", error));
        });
    </script>
</asp:Content>
