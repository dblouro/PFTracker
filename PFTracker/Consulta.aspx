<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Consulta.aspx.cs" Inherits="PFTracker.Consulta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/consulta.css" />
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
            <input type="date" id="dateStart" class="form-control mb-2">
            <input type="date" id="dateEnd" class="form-control">
        </div>
        <div class="col-md-3">
            <label for="categoryFilter">Categoria</label>
            <select id="categoryFilter" class="form-control">
                <option value="all">Todas</option>
                <option value="supermarket">Supermercado</option>
                <option value="entertainment">Lazer</option>
                <option value="transport">Transporte</option>
            </select>
        </div>
        <div class="col-md-3">
            <label for="valueRange">Faixa de Valor</label>
            <input type="text" id="valueRange" class="form-control" placeholder="$0 - $500">
        </div>
        <div class="col-md-3">
            <label>&nbsp;</label>
            <button class="btn btn-primary btn-block mt-2">Buscar</button>
        </div>
    </div>

    <!-- Resultados em Tabela -->
    <div class="row">
        <div class="col-12">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Data</th>
                        <th>Descrição</th>
                        <th>Categoria</th>
                        <th>Valor</th>
                        <th>Tipo de Pagamento</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>10 Dez</td>
                        <td>Supermercado</td>
                        <td>Compras</td>
                        <td>$200.00</td>
                        <td>Cartão de Crédito</td>
                        <td><button class="btn btn-info btn-sm">Ver Detalhes</button></td>
                    </tr>
                    <!-- Mais linhas... -->
                </tbody>
            </table>
        </div>
    </div>
    <!-- Footer -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <small>Última atualização: 10/12/2024</small>
        </div>
    </div>
</div>
</asp:Content>
