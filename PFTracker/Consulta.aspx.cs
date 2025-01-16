using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PFTracker
{
    public partial class Consulta : System.Web.UI.Page
    {

        SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString);
        SqlCommand myCommand = new SqlCommand();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    Label lblUser = (Label)Master.FindControl("lbl_user");
                    if (lblUser != null)
                    {
                        lblUser.Text = "Bem-vindo, " + Session["UserId"].ToString();
                    }

                    // Recupera o id_utilizador da sessão
                    int id_utilizador = Convert.ToInt32(Session["UserId"]);

                    // Filtra as transações do utilizador logado
                    filtro_categorias(id_utilizador);
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }

                PreencherCategorias();
            }
        }

        protected void filtro_categorias(int id_utilizador)
        {
            // Base da consulta
            string query = "SELECT * FROM [Consulta] WHERE id_utilizador = @id_utilizador";

            // Limpa os parâmetros existentes no SqlDataSource
            SqlDataSource1.SelectParameters.Clear();

            // Filtros dinâmicos
            if (!string.IsNullOrEmpty(ddp_categorias.SelectedValue) && ddp_categorias.SelectedValue != "0" && ddp_categorias.SelectedValue != "Todas")
            {
                query += " AND id_categoria = @id_categoria";
                SqlDataSource1.SelectParameters.Add("id_categoria", ddp_categorias.SelectedValue);
            }

            if (!string.IsNullOrEmpty(dateStart.Value) && !string.IsNullOrEmpty(dateEnd.Value))
            {
                query += " AND data BETWEEN @dataStart AND @dataEnd";
                SqlDataSource1.SelectParameters.Add("dataStart", dateStart.Value);
                SqlDataSource1.SelectParameters.Add("dataEnd", dateEnd.Value);
            }

            if (!string.IsNullOrEmpty(tb_min.Text))
            {
                query += " AND valor >= @min";
                SqlDataSource1.SelectParameters.Add("min", tb_min.Text);
            }

            if (!string.IsNullOrEmpty(tb_max.Text))
            {
                query += " AND valor <= @max";
                SqlDataSource1.SelectParameters.Add("max", tb_max.Text);
            }

            // Adiciona o parâmetro id_utilizador à consulta
            SqlDataSource1.SelectParameters.Add("id_utilizador", id_utilizador.ToString());

            // Atualiza a consulta no SqlDataSource
            SqlDataSource1.SelectCommand = query;

            // Rebind para aplicar os filtros
            rpt_tabela_consulta.DataBind();
        }

        private void PreencherCategorias()
        {
            string query = "SELECT id_categoria, nome FROM [pft_categoria]";
            using (SqlConnection myConn = new SqlConnection(SqlDataSource1.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, myConn))
                {
                    myConn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    // Limpa o DropDownList antes de adicionar os novos itens
                    ddp_categorias.Items.Clear();
                    ddp_categorias.Items.Add(new ListItem("Todas", "0"));

                    // Preenche o DropDownList com os dados da base
                    while (reader.Read())
                    {
                        ddp_categorias.Items.Add(new ListItem(reader["nome"].ToString(), reader["id_categoria"].ToString()));
                    }
                }
            }
        }


        protected void btn_procurar_Click(object sender, EventArgs e)
        {
            int id_utilizador = Convert.ToInt32(Session["UserId"]);
            filtro_categorias(id_utilizador);
        }

        protected void filtro_categorias()
        {
            // Recupera o id_utilizador da sessão
            int id_utilizador = Convert.ToInt32(Session["id_utilizador"]);

            // Base da consulta
            string query = "SELECT * FROM [Consulta] WHERE id_utilizador = @id_utilizador";

            // Limpa os parâmetros existentes no SqlDataSource
            SqlDataSource1.SelectParameters.Clear();

            // Filtros dinâmicos
            if (!string.IsNullOrEmpty(ddp_categorias.SelectedValue) && ddp_categorias.SelectedValue != "0" && ddp_categorias.SelectedValue != "Todas")
            {
                query += " AND id_categoria = @id_categoria";
                SqlDataSource1.SelectParameters.Add("id_categoria", ddp_categorias.SelectedValue);
            }

            if (!string.IsNullOrEmpty(dateStart.Value) && !string.IsNullOrEmpty(dateEnd.Value))
            {
                query += " AND data BETWEEN @dataStart AND @dataEnd";
                SqlDataSource1.SelectParameters.Add("dataStart", dateStart.Value);
                SqlDataSource1.SelectParameters.Add("dataEnd", dateEnd.Value);
            }

            if (!string.IsNullOrEmpty(tb_min.Text))
            {
                query += " AND valor >= @min";
                SqlDataSource1.SelectParameters.Add("min", tb_min.Text);
            }

            if (!string.IsNullOrEmpty(tb_max.Text))
            {
                query += " AND valor <= @max";
                SqlDataSource1.SelectParameters.Add("max", tb_max.Text);
            }

            // Adiciona o parâmetro id_utilizador à consulta
            SqlDataSource1.SelectParameters.Add("id_utilizador", id_utilizador.ToString());

            // Atualiza a consulta no SqlDataSource
            SqlDataSource1.SelectCommand = query;

            // Rebind para aplicar os filtros
            rpt_tabela_consulta.DataBind();
        }

        protected void btn_adicionar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["UserId"] == null || !int.TryParse(Session["UserId"].ToString(), out int id_utilizador))
                {
                    lbl_add_transacao.Text = "Erro: ID do utilizador inválido.";
                    lbl_add_transacao.CssClass = "text-danger";
                    return;
                }

                if (!decimal.TryParse(tb_valor.Text.Replace(",", "."), NumberStyles.Any, CultureInfo.InvariantCulture, out decimal valor))
                {
                    lbl_add_transacao.Text = "Por favor, insira um valor válido.";
                    lbl_add_transacao.CssClass = "text-danger";
                    return;
                }

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("add_transacao", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@descricao", tb_descricao.Text);
                        cmd.Parameters.AddWithValue("@categoria", ddl_categoria_add.SelectedValue);
                        cmd.Parameters.AddWithValue("@valor", valor);
                        cmd.Parameters.AddWithValue("@tipo_transacao", ddl_tipo_transacao.SelectedValue);
                        cmd.Parameters.AddWithValue("@id_utilizador", id_utilizador);

                        SqlParameter retornoParam = new SqlParameter("@retorno", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(retornoParam);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        int resposta = Convert.ToInt32(retornoParam.Value);

                        switch (resposta)
                        {
                            case 1:
                                lbl_add_transacao.Text = "Transação registrada com sucesso!";
                                lbl_add_transacao.CssClass = "text-success";
                                Response.Redirect(Request.RawUrl); // Atualiza a página
                                break;
                            case 0:
                                lbl_add_transacao.Text = "Erro: Utilizador não encontrado.";
                                lbl_add_transacao.CssClass = "text-danger";
                                break;
                            case -1:
                                lbl_add_transacao.Text = "Erro inesperado. Por favor, tente novamente.";
                                lbl_add_transacao.CssClass = "text-danger";
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lbl_add_transacao.Text = "Erro ao adicionar a transação: " + ex.Message;
                lbl_add_transacao.CssClass = "text-danger";
            }
        }



        protected void btn_ver_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string idTransacao = btn.CommandArgument;

            // Verifique se o ID foi recuperado corretamente
            if (!string.IsNullOrEmpty(idTransacao))
            {
                // Armazenar o idTransacao no HiddenField para usá-lo depois
                hf_id_transacao.Value = idTransacao;

                // Aqui, você pode usar diretamente a consulta SQL para preencher os campos do modal
                string query = "SELECT descricao, nome, valor, tipo_transacao FROM [Consulta] WHERE id_transacao = @id_transacao";
                SqlCommand cmd = new SqlCommand(query, myConn);
                cmd.Parameters.AddWithValue("@id_transacao", idTransacao);

                myConn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    tb_detalhes_descricao.Text = reader["descricao"].ToString();
                    tb_detalhes_nome.Text = reader["nome"].ToString();
                    tb_detalhes_valor.Text = reader["valor"].ToString();
                    ddl_detalhes_transacao.SelectedValue = reader["tipo_transacao"].ToString();
                }
                myConn.Close();


                // Abrir o modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#viewDetailsModal').modal('show');", true);
            }
        }



        protected void btn_fechar_Click(object sender, EventArgs e)
        {
            // Fechar o modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PopClose", "$('#viewDetailsModal').modal('hide');", true);
        }

        protected void btn_editar_Click(object sender, EventArgs e)
        {
            // Ativar edição
            tb_detalhes_descricao.Enabled = true;
            tb_detalhes_nome.Enabled = true;
            tb_detalhes_valor.Enabled = true;
            ddl_detalhes_transacao.Enabled = true;

            // Mostrar o botão "Salvar" e ocultar o botão "Editar"
            btn_salvar.Visible = true;
            btn_editar.Visible = false;

            // Manter o modal aberto
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#viewDetailsModal').modal('show');", true);
        }




        protected void btn_salvar_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar os valores atualizados
                string descricao = tb_detalhes_descricao.Text;
                string nome = tb_detalhes_nome.Text;
                decimal valor = Convert.ToDecimal(tb_detalhes_valor.Text);
                string tipoTransacao = ddl_detalhes_transacao.SelectedValue;

                // Recuperar o ID da transação
                string idTransacao = hf_id_transacao.Value;

                // Atualizar no banco de dados
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("update_transacao", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@id_transacao", idTransacao);
                        cmd.Parameters.AddWithValue("@descricao", descricao);
                        cmd.Parameters.AddWithValue("@valor", valor);
                        cmd.Parameters.AddWithValue("@tipo_transacao", tipoTransacao);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Mensagem de sucesso
                lbl_status.Text = "Alterações salvas com sucesso!";
                lbl_status.CssClass = "text-success";

                // Voltar ao estado inicial
                tb_detalhes_descricao.Enabled = false;
                tb_detalhes_nome.Enabled = false;
                tb_detalhes_valor.Enabled = false;
                ddl_detalhes_transacao.Enabled = false;

                btn_editar.Visible = true;
                btn_salvar.Visible = false;

                // Atualizar a tabela com os dados filtrados do utilizador
                filtro_categorias(Convert.ToInt32(Session["id_utilizador"])); // Certifique-se de usar a função que aplica o filtro corretamente

                // Manter o modal aberto
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#viewDetailsModal').modal('show');", true);
            }
            catch (Exception ex)
            {
                // Mensagem de erro
                lbl_status.Text = "Erro ao salvar as alterações: " + ex.Message;
                lbl_status.CssClass = "text-danger";

                // Manter o modal aberto para corrigir o erro
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#viewDetailsModal').modal('show');", true);

            }
            Response.Redirect(Request.RawUrl);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#viewDetailsModal').modal('show');", true);
        }

        protected void btn_eliminar_Click(object sender, EventArgs e)
        {
            int idTransacao = int.Parse(hf_id_transacao.Value);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM pft_transacao WHERE id_transacao = @idTransacao", conn);
                cmd.Parameters.AddWithValue("@idTransacao", idTransacao);
                cmd.ExecuteNonQuery();
            }

            lbl_status.Text = "Transação eliminada com sucesso!";
            lbl_status.CssClass = "text-danger";
            Response.Redirect(Request.RawUrl);
        }
    }

}