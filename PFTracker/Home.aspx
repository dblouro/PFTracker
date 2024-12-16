<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PFTracker.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="css/home.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Cartões de Crédito -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="credit-card">
                <div class="logo"><i class="fas fa-credit-card"></i></div>
                <div class="card-number">1234 5678 9012 3456</div>
                <div class="card-balance">Balance: $1,234.56</div>
                <div class="card-holder">Card Holder: John Doe</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="credit-card add-card">
                <div class="add-icon">+</div>
                <p>Adicionar Novo Cartão</p>
            </div>
        </div>
    </div>

    <!-- Resumo Financeiro e Próximos Pagamentos -->
    <div class="row">
        <!-- Resumo Financeiro -->
        <div class="col-md-6 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-wallet"></i>Resumo Financeiro</h4>
                    <p>Saldo Atual</p>
                    <h3>$12,345.67</h3>
                    <canvas id="expensePieChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Próximos Pagamentos -->
        <div class="col-md-6 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-calendar-alt"></i>Próximos Pagamentos</h4>
                    <ul class="payment-list">
                        <li><span class="payment-date">15 Dez</span><span>Conta de Água</span><span>$45.00</span></li>
                        <li><span class="payment-date">20 Dez</span><span>Renda</span><span>$1,200.00</span></li>
                        <li><span class="payment-date">25 Dez</span><span>Internet</span><span>$60.00</span></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Objetivos de Poupança -->
    <div class="row">
        <div class="col-md-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-bullseye"></i>Objetivos de Poupança</h4>
                    <button class="btn btn-primary btn-sm mb-3">Adicionar Objetivo</button>
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
                                        <div class="progress-bar bg-success" style="width: 50%;"></div>
                                    </div>
                                </td>
                                <td><span class="badge badge-success">Em Progresso</span></td>
                            </tr>
                            <tr>
                                <td>Viagem</td>
                                <td>$5,000</td>
                                <td>
                                    <div class="progress">
                                        <div class="progress-bar bg-warning" style="width: 75%;"></div>
                                    </div>
                                </td>
                                <td><span class="badge badge-warning">Quase Lá</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Transações Recentes -->
    <div class="row">
        <div class="col-md-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-list-alt"></i>Transações Recentes</h4>
                    <table class="table">
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
                            backgroundColor: ["#007bff", "#6610f2", "#28a745", "#dc3545"],
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
                    animation: {
                        duration: 1000,
                        easing: "easeInOutQuart"
                    }
                },
            });
        });
    </script>
    <script src="js/home.js"></script>
</asp:Content>
