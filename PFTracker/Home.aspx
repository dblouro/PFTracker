<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PFTracker.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="css/home.css">
    <div class="col-md-4 grid-margin stretch-card">
        <div class="credit-card">
            <div class="logo"></div>
            <div class="card-number">1234 5678 9012 3456</div>
            <div class="card-balance">Balance: $1,234.56</div>
            <div class="card-holder">Card Holder: John Doe</div>
        </div>
    </div>
    <div class="row">
        <!-- Card de resumo financeiro -->
        <div class="col-md-4 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Resumo Financeiro</h4>
                    <p class="text-muted">Saldo Atual</p>
                    <h3>$12,345.67</h3>
                </div>
            </div>
        </div>

        <!-- Gráfico de pizza para despesas -->
        <div class="col-md-4 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Despesas por Categoria</h4>
                    <canvas id="expensePieChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Tabela de objetivos de poupança -->
        <div class="col-md-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Objetivos de Poupança</h4>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Meta</th>
                                    <th>Valor Alvo</th>
                                    <th>Progresso</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Comprar um Carro</td>
                                    <td>$20,000</td>
                                    <td>
                                        <div class="progress">
                                            <div
                                                class="progress-bar bg-success"
                                                role="progressbar"
                                                style="width: 50%;"
                                                aria-valuenow="50"
                                                aria-valuemin="0"
                                                aria-valuemax="100">
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <label class="badge badge-success">Em Progresso</label></td>
                                </tr>
                                <tr>
                                    <td>Viagem de Férias</td>
                                    <td>$5,000</td>
                                    <td>
                                        <div class="progress">
                                            <div
                                                class="progress-bar bg-warning"
                                                role="progressbar"
                                                style="width: 75%;"
                                                aria-valuenow="75"
                                                aria-valuemin="0"
                                                aria-valuemax="100">
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <label class="badge badge-warning">Quase Lá</label></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Incluir Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Script para renderizar o gráfico -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById("expensePieChart").getContext("2d");
            new Chart(ctx, {
                type: "pie",
                data: {
                    labels: ["Supermercado", "Automóvel", "Transporte", "Lazer"],
                    datasets: [
                        {
                            data: [300, 500, 100, 150],
                            backgroundColor: ["#007bff", "#6610f2", "#28a745", "#ffc107"],
                        },
                    ],
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: "top",
                        },
                    },
                },
            });
        });
    </script>
    <script src="js/home.js"></script>
</asp:Content>
