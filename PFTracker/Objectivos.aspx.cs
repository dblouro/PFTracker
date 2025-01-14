using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace PFTracker
{
    public partial class Objectivos : System.Web.UI.Page
    {
        SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString);
        SqlCommand myCommand = new SqlCommand();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }
        protected void btn_detalhe_objectivos_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string id_objetivo = btn.CommandArgument;
            hf_id_objetivo.Value = id_objetivo;

            if (!string.IsNullOrEmpty(id_objetivo))
            {
                


                string query = "SELECT * FROM [pft_objetivo]  WHERE id_objetivo = @id_objetivo";
                SqlCommand cmd = new SqlCommand(query, myConn);
                cmd.Parameters.AddWithValue("@id_objetivo", id_objetivo);

                myConn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    tb_descricao_detalhes.Text = dr["descricao"].ToString();
                    tb_detalhes_valor_atual.Text = dr["valor_inicial"].ToString();
                    tb_detalhes_valor_alvo.Text = dr["valor_alvo"].ToString();
                    date_add_create.Value = Convert.ToDateTime(dr["data_criacao"]).ToString("yyyy-MM-dd");
                    date_add_end.Value = Convert.ToDateTime(dr["data_alvo"]).ToString("yyyy-MM-dd");
                }
                myConn.Close();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#detailsModal').modal('show');", true);
        }

        protected void btn_fechar_Click(object sender, EventArgs e)
        {
            // Fechar o modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PopClose", "$('#detailsModal').modal('hide');", true);
        }

        protected void btn_editar_Click(object sender, EventArgs e)
        {
            // Ativar edição
            tb_descricao_detalhes.Enabled = true;
            tb_detalhes_valor_atual.Enabled = true;
            tb_detalhes_valor_alvo.Enabled = true;
            date_add_create.Disabled = false;
            date_add_end.Disabled = false;

            // Mostrar o botão "Salvar" e ocultar o botão "Editar"
            btn_salvar.Visible = true;
            btn_editar.Visible = false;

            // Manter o modal aberto
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#detailsModal').modal('show');", true);
        }

        protected void btn_salvar_Click(object sender, EventArgs e)
        {
            try
            {
                // Recuperar os valores atualizados
                string descricao = tb_descricao_detalhes.Text;
                decimal valor_inicial = Convert.ToDecimal(tb_detalhes_valor_atual.Text);
                decimal valor_alvo = Convert.ToDecimal(tb_detalhes_valor_alvo.Text);
                DateTime data_criacao = Convert.ToDateTime(date_add_create.Value);
                DateTime data_alvo = Convert.ToDateTime(date_add_end.Value);

                // Recuperar o ID da transação
                string id_objetivo = hf_id_objetivo.Value;

                // Atualizar no banco de dados
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("update_objetivo", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@id_objetivo", id_objetivo);
                        cmd.Parameters.AddWithValue("@descricao", descricao);
                        cmd.Parameters.AddWithValue("@valor_inicial", valor_inicial);
                        cmd.Parameters.AddWithValue("@valor_alvo", valor_alvo);
                        cmd.Parameters.AddWithValue("@data_criacao", data_criacao);
                        cmd.Parameters.AddWithValue("@data_alvo", data_alvo);
                        
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Mensagem de sucesso
                lbl_status.Text = "Alterações salvas com sucesso!";
                lbl_status.CssClass = "text-success";

                // Voltar ao estado inicial
                tb_descricao_detalhes.Enabled = false;
                tb_detalhes_valor_atual.Enabled = false;
                tb_detalhes_valor_alvo.Enabled = false;
                date_add_create.Disabled = true;
                date_add_end.Disabled = true;

                btn_editar.Visible = true;
                btn_salvar.Visible = false;

                // Manter o modal aberto
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#detailsModal').modal('show');", true);

                // Atualizar a tabela
                rpt_tabela_objetivos.DataBind();
            }
            catch (Exception ex)
            {
                // Mensagem de erro
                lbl_status.Text = "Erro ao salvar as alterações: " + ex.Message;
                lbl_status.CssClass = "text-danger";

                // Manter o modal aberto para corrigir o erro
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#detailsModal').modal('show');", true);
            }
        }

        protected void btn_eliminar_Click(object sender, EventArgs e)
        {
            // Obter o ID da transação a ser apagada
            int id_objetivo = int.Parse(hf_id_objetivo.Value);

            // Conectar ao banco de dados e apagar a transação
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM pft_objetivo WHERE id_objetivo = @id_objetivo", conn);
                cmd.Parameters.AddWithValue("@id_objetivo", id_objetivo);
                cmd.ExecuteNonQuery();
            }

            // Exibir mensagem de sucesso
            lbl_status.Text = "Transação eliminada com sucesso!";
            lbl_status.CssClass = "text-danger";

            // Fechar modal e atualizar a página para refletir as mudanças
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "$('#detailsModal').modal('hide');", true);
            Response.Redirect(Request.RawUrl); // Atualiza a página
        }

        protected void btn_add_saldo_objectivos_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#addSaldoModal').modal('show');", true);
        }

        protected void btn_add_saldo_Click(object sender, EventArgs e)
        {
            
            myConn.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO SaldoObjectivos (idObjectivo, saldo) VALUES (@idObjectivo, @saldo)", myConn);
            cmd.Parameters.AddWithValue("@idObjectivo", Convert.ToInt32(hf_id_objetivo.Value));
            cmd.Parameters.AddWithValue("@saldo", Convert.ToInt32(tb_add_saldo.Text));
            cmd.ExecuteNonQuery();
            myConn.Close();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#addSaldoModal').modal('hide');", true);
            Response.Redirect(Request.RawUrl);
        }
    }
}