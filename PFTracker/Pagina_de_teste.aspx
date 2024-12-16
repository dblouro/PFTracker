<%@ Page Title="Home" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PFTracker.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- CSS -->
    <link rel="stylesheet" href="css/home.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Cartões de Crédito -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="credit-card shadow-sm">
                <div class="d-flex justify-content-between">
                    <i class="fas fa-credit-card fa-2x text-white"></i>
                    <small class="text-white">1234 5678 9012 3456</small>
                </div>
                <div class="mt-4">
                    <h6 class="text-white">Balance: <strong>$1,234.56</strong></h6>
                    <span class="text-light">Card Holder: John Doe</span>
                </div>
            </div>
        </div>
        <!-- Adicionar Novo Cartão -->
        <div class="col-md-4">
            <div class="credit-card add-card d-flex align-items-center justify-content-center shadow-sm">
                <span class="text-white fs-2">+</span>
            </div>
        </div>
    </div>

    <!-- Resumo Financeiro e Próximos Pagamentos -->
    <div class="row">
        <!-- Resumo Financeiro -->
        <div class="col-md-6 stretch-card">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-wallet me-2"></i>Resumo Financeiro</h4>
                    <h3>$12,345.67</h3>
                    <canvas id="pieChart" style="height:250px"></canvas>
                </div>
            </div>
        </div>

        <!-- Próximos Pagamentos -->
        <div class="col-md-6 stretch-card">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-calendar-alt me-2"></i>Próximos Pagamentos</h4>
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between">
                            <span>15 Dez - Conta de Água</span><span>$45.00</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            <span>20 Dez - Renda</span><span>$1,200.00</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            <span>25 Dez - Internet</span><span>$60.00</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Objetivos de Poupança -->
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-bullseye me-2"></i>Objetivos de Poupança</h4>
                    <button class="btn btn-primary btn-sm mb-3">Adicionar Objetivo</button>
                    <table class="table table-bordered table-hover">
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
                                <td><span class="badge bg-success">Em Progresso</span></td>
                            </tr>
                            <tr>
                                <td>Viagem</td>
                                <td>$5,000</td>
                                <td>
                                    <div class="progress">
                                        <div class="progress-bar bg-warning" style="width: 75%;"></div>
                                    </div>
                                </td>
                                <td><span class="badge bg-warning">Quase Lá</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Transações Recentes -->
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h4 class="card-title"><i class="fas fa-list-alt me-2"></i>Transações Recentes</h4>
                    <table class="table table-striped">
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

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById("doughnutChart").getContext("2d");
            new Chart(ctx, {
                type: "pie",
                data: {
                    labels: ["Supermercado", "Automóvel", "Transporte", "Lazer"],
                    datasets: [{
                        data: [300, 500, 100, 150],
                        backgroundColor: ["#007bff", "#6610f2", "#28a745", "#dc3545"]
                    }]
                }
            });
        });
    </script>
</asp:Content>
