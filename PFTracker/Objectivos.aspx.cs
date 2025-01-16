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
                if (Session["UserId"] != null)
                {
                    Label lblUser = (Label)Master.FindControl("lbl_user");
                    if (lblUser != null)
                    {
                        lblUser.Text = "Bem-vindo, " + Session["UserId"].ToString();
                    }

                    // Recupera o id_utilizador da sessão
                    int id_utilizador = Convert.ToInt32(Session["UserId"]);

                    CarregarObjetivos();
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
        }

        private void CarregarObjetivos()
        {
            try
            {
                int id_utilizador = Convert.ToInt32(Session["UserId"]);
                string query = "SELECT * FROM pft_objetivo WHERE id_utilizador = @id_utilizador";
                SqlCommand cmd = new SqlCommand(query, myConn);
                cmd.Parameters.AddWithValue("@id_utilizador", id_utilizador);

                myConn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                // Supondo que rpt_tabela_objetivos seja o repeater ou gridview para exibir os dados
                rpt_tabela_objetivos.DataSource = dr;
                rpt_tabela_objetivos.DataBind();

                myConn.Close();
            }
            catch (Exception ex)
            {
                lbl_status.Text = "Erro ao carregar objetivos: " + ex.Message;
                lbl_status.CssClass = "text-danger";
            }
            finally
            {
                if (myConn.State == ConnectionState.Open)
                {
                    myConn.Close();
                }
            }
        }

        protected void btn_add_objetivo_Click(object sender, EventArgs e)
        {
            try
            {
                string descricao = tb_descricao_objetivo.Text;
                decimal valorAlvo = Convert.ToDecimal(tb_valor_alvo.Text);
                DateTime dataAlvo = Convert.ToDateTime(goalDeadline.Value);
                int id_utilizador = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("adicionar_objetivo", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@descricao", descricao);
                        cmd.Parameters.AddWithValue("@valor_alvo", valorAlvo);
                        cmd.Parameters.AddWithValue("@data_alvo", dataAlvo);
                        cmd.Parameters.AddWithValue("@id_utilizador", id_utilizador);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lbl_status.Text = "Objetivo adicionado com sucesso!";
                lbl_status.CssClass = "text-success";

                CarregarObjetivos();
            }
            catch (Exception ex)
            {
                lbl_status.Text = "Erro ao adicionar objetivo: " + ex.Message;
                lbl_status.CssClass = "text-danger";
            }

        }



        protected void btn_detalhe_objectivos_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                string id_objetivo = btn.CommandArgument;
                hf_id_objetivo.Value = id_objetivo;

                if (!string.IsNullOrEmpty(id_objetivo))
                {
                    string query = "SELECT * FROM pft_objetivo WHERE id_objetivo = @id_objetivo";
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

                
            }
            catch (Exception ex)
            {
                lbl_status.Text = "Erro ao carregar os detalhes: " + ex.Message;
                lbl_status.CssClass = "text-danger";
            }
            finally
            {
                if (myConn.State == ConnectionState.Open)
                {
                    myConn.Close();
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PopDetails", "$('#detailsModal').modal('show');", true);
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
                Response.Redirect(Request.RawUrl);
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

        protected void btn_cancelar_Click(object sender, EventArgs e)
        {
            // Fechar o modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PopClose", "$('#viewDetailsModal').modal('hide');", true);
        }

        protected void btn_add_saldo_objectivos_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#addSaldoModal').modal('show');", true);

        }

        protected void btn_add_saldo_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseAddSaldoModal", "$('#addSaldoModal').modal('hide');", true);
        }

        protected void btn_confirmar_add_saldo_Click(object sender, EventArgs e)
        {
            try
            {
                // Recupera o ID do objetivo e o valor do saldo a ser adicionado
                int objetivoId = Convert.ToInt32(hf_id_objetivo.Value);
                decimal saldoAdicionar = Convert.ToDecimal(tb_add_saldo.Text.Replace(",", "."));

                // Atualiza o valor_inicial no banco de dados
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString))
                {
                    string query = "UPDATE pft_objetivo SET valor_inicial = valor_inicial + @saldoAdicionar WHERE id_objetivo = @objetivoId";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@saldoAdicionar", saldoAdicionar);
                        cmd.Parameters.AddWithValue("@objetivoId", objetivoId);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Exibe mensagem de sucesso
                lbl_status.Text = "Saldo adicionado ao objetivo com sucesso!";
                lbl_status.CssClass = "text-success";

                // Atualiza a lista de objetivos
                CarregarObjetivos();

                // Fecha o modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseAddSaldoModal", "$('#addSaldoModal').modal('hide');", true);
            }
            catch (Exception ex)
            {
                // Exibe mensagem de erro
                lbl_status.Text = "Erro ao adicionar saldo ao objetivo: " + ex.Message;
                lbl_status.CssClass = "text-danger";

                // Mantém o modal aberto para o usuário tentar novamente
                ScriptManager.RegisterStartupScript(this, this.GetType(), "KeepAddSaldoModal", "$('#addSaldoModal').modal('show');", true);
            }
        }

    }
}