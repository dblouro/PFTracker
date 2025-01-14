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
                // Recupera os dados da base de dados
                string query = "SELECT id_categoria, nome FROM [pft_categoria]";
                {
                    using (SqlCommand cmd = new SqlCommand(query, myConn))
                    {
                        myConn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        // Adiciona manualmente a opção "Todas"
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
        }

        protected void btn_procurar_Click(object sender, EventArgs e)
        {
            filtro_categorias();
        }

        protected void filtro_categorias()
        {
            // Base da consulta
            string query = "SELECT * FROM [Consulta] WHERE 1=1";

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
                query += " AND valor BETWEEN @min AND @max";
                SqlDataSource1.SelectParameters.Add("min", tb_min.Text);
            }

            if (!string.IsNullOrEmpty(tb_max.Text))
            {
                query += " AND valor BETWEEN @min AND @max";
                SqlDataSource1.SelectParameters.Add("max", tb_max.Text);
            }

            // Atualiza a consulta no SqlDataSource
            SqlDataSource1.SelectCommand = query;

            // Rebind para aplicar os filtros
            rpt_tabela_consulta.DataBind();
        }
        protected void btn_adicionar_Click(object sender, EventArgs e)
        {
            string valorCorrigido = tb_valor.Text.Replace(",", ".");
            decimal valor = Convert.ToDecimal(valorCorrigido, CultureInfo.InvariantCulture);

            myCommand.Parameters.AddWithValue("@descricao", tb_descricao.Text);
            myCommand.Parameters.AddWithValue("@categoria", ddl_categoria_add.SelectedValue);
            myCommand.Parameters.AddWithValue("@valor", valor);
            myCommand.Parameters.AddWithValue("@tipo_transacao", ddl_tipo_transacao.SelectedValue);

            SqlParameter sqlParameter = new SqlParameter();
            sqlParameter.ParameterName = "@retorno";
            sqlParameter.Direction = ParameterDirection.Output;
            sqlParameter.SqlDbType = SqlDbType.Int;
            myCommand.Parameters.Add(sqlParameter);

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "add_transacao";


            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery();
            int resposta = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);
            myConn.Close();

            if (resposta == 1)
            {
                lbl_add_transacao.Text = "Transação registada com sucesso!";
                Response.Redirect(Request.RawUrl);
            }
            else
                lbl_add_transacao.Text = "Transação já registada!";
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

                // Manter o modal aberto
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#viewDetailsModal').modal('show');", true);

                // Atualizar a tabela
                rpt_tabela_consulta.DataBind();
            }
            catch (Exception ex)
            {
                // Mensagem de erro
                lbl_status.Text = "Erro ao salvar as alterações: " + ex.Message;
                lbl_status.CssClass = "text-danger";

                // Manter o modal aberto para corrigir o erro
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#viewDetailsModal').modal('show');", true);
            }
        }
        protected void btn_eliminar_Click(object sender, EventArgs e)
        {
            // Obter o ID da transação a ser apagada
            int idTransacao = int.Parse(hf_id_transacao.Value);

            // Conectar ao banco de dados e apagar a transação
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM pft_transacao WHERE id_transacao = @idTransacao", conn);
                cmd.Parameters.AddWithValue("@idTransacao", idTransacao);
                cmd.ExecuteNonQuery();
            }

            // Exibir mensagem de sucesso
            lbl_status.Text = "Transação eliminada com sucesso!";
            lbl_status.CssClass = "text-danger";

            // Fechar modal e atualizar a página para refletir as mudanças
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "$('#viewDetailsModal').modal('hide');", true);
            Response.Redirect(Request.RawUrl); // Atualiza a página
        }
    }

}