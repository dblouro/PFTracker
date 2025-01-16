<%@ Page Title="Home" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PFTracker.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="css/home.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <div class="container mt-4">
        <!-- Resumo Geral -->
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card summary-card text-white bg-primary">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-wallet"></i>Saldo Atual</h5>
                        <h3>$12,345.67</h3>
                        <small class="text-white-50">Última atualização: 15/01/2025</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card summary-card text-white bg-success">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-chart-line"></i>Despesas Mensais</h5>
                        <h3>$3,456.78</h3>
                        <small class="text-white-50">Média das despesas recentes</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card summary-card text-white bg-danger">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-calendar-alt"></i>Próximos Pagamentos</h5>
                        <h3>3 Pendentes</h3>
                        <small class="text-white-50">Total: $1,305.00</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Objetivos e Gráficos -->
        <div class="row">
            <!-- Gráficos -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-chart-pie"></i>Distribuição de Despesas</h5>
                        <canvas id="expensePieChart"></canvas>
                    </div>
                </div>
            </div>
            <!-- Objetivos -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-bullseye"></i>Objetivos de Poupança</h5>
                        <ul class="list-group">
                            <li class="list-group-item d-flex justify-content-between align-items-center">Comprar um Carro
                               
                                <span class="badge bg-success rounded-pill">50%</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">Viagem
                               
                                <span class="badge bg-warning rounded-pill">75%</span>
                            </li>
                        </ul>
                        <button class="btn btn-primary btn-sm mt-3">Adicionar Objetivo</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Transações Recentes -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-list-alt"></i>Transações Recentes</h5>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Data</th>
                                    <th>Descrição</th>
                                    <th>Categoria</th>
                                    <th>Valor</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>10 Dez</td>
                                    <td>Supermercado</td>
                                    <td>Compras</td>
                                    <td>$200.00</td>
                                </tr>
                                <tr>
                                    <td>09 Dez</td>
                                    <td>Gasolina</td>
                                    <td>Transporte</td>
                                    <td>$50.00</td>
                                </tr>
                                <tr>
                                    <td>08 Dez</td>
                                    <td>Almoço</td>
                                    <td>Lazer</td>
                                    <td>$30.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById("expensePieChart").getContext("2d");
            new Chart(ctx, {
                type: "pie",
                data: {
                    labels: ["Supermercado", "Transportes", "Lazer", "Outros"],
                    datasets: [
                        {
                            data: [300, 150, 200, 100],
                            backgroundColor: ["#007bff", "#28a745", "#dc3545", "#ffc107"],
                        },
                    ],
                },
                options: {
                    plugins: {
                        legend: {
                            position: "bottom",
                        },
                    },
                },
            });
        });
    </script>
</asp:Content>
