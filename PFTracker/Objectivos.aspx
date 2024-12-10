<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Objectivos.aspx.cs" Inherits="PFTracker.Objectivos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Gestão de Objetivos</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addGoalModal">
                + Adicionar Objetivo
       
            </button>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th>Meta</th>
                    <th>Valor Alvo</th>
                    <th>Progresso</th>
                    <th>Data Limite</th>
                    <th>Ações</th>
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
                    <td>31 Dez 2024</td>
                    <td>
                        <button class="btn btn-sm btn-warning">Editar</button>
                        <button class="btn btn-sm btn-danger">Excluir</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Modal para adicionar objetivo -->
    <div class="modal fade" id="addGoalModal" tabindex="-1" aria-labelledby="addGoalModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addGoalModalLabel">Adicionar Novo Objetivo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="addGoalForm">
                        <div class="mb-3">
                            <label for="goalName" class="form-label">Meta</label>
                            <input type="text" class="form-control" id="goalName" placeholder="Ex.: Comprar um carro">
                        </div>
                        <div class="mb-3">
                            <label for="goalValue" class="form-label">Valor Alvo</label>
                            <input type="number" class="form-control" id="goalValue" placeholder="Ex.: 20000">
                        </div>
                        <div class="mb-3">
                            <label for="goalDeadline" class="form-label">Data Limite</label>
                            <input type="date" class="form-control" id="goalDeadline">
                        </div>
                        <button type="submit" class="btn btn-primary">Salvar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
