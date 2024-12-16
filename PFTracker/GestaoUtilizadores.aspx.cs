using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PFTracker
{
    public partial class GestaoUtilizadores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["admin"] != null)
                {
                    int userId = Convert.ToInt32(Session["admin"]);
                    SqlConnection myConn = new SqlConnection(SqlDataSource1.ConnectionString);

                    // Verificar o perfil do utilizador
                    string query = "SELECT cod_utilizador FROM LojaOnlineUtilizador WHERE cod_utilizador = @userId";

                    SqlCommand cmd = new SqlCommand(query, myConn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    //FAZER STORED PROCEDURE <------------------------------------------------------------------------ !!!
                    myConn.Open();
                    int perfilId = (int)cmd.ExecuteScalar(); // Obtém o perfil do utilizador

                    //se o perfil não for 1 (Administrador), redireciona para a página de acesso negado
                    if (perfilId != 1)
                    {
                        Response.Redirect("~/AcessoNegado.aspx");
                    }
                }
            }
            else
            {
                //caso n haja autenticaçao, redireciona para a página de login
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void rpt_utilizadores_ItemDataBound(object source, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = e.Item.DataItem as DataRowView;
                //DataRowView dr = (DataRowView)e.Item.DataItem;
                ((Label)e.Item.FindControl("lbl_num")).Text = dr["cod_utilizador"].ToString();
                ((TextBox)e.Item.FindControl("tb_nome")).Text = dr["nome_utilizador"].ToString();
                ((TextBox)e.Item.FindControl("tb_pw")).Text = dr["pw_utilizador"].ToString();
                ((TextBox)e.Item.FindControl("tb_email")).Text = dr["email_utilizador"].ToString();
                ((TextBox)e.Item.FindControl("tb_contacto")).Text = dr["tlm_utilizador"].ToString();
                ((TextBox)e.Item.FindControl("tb_perfil")).Text = dr["cod_perfil"].ToString();
                ((TextBox)e.Item.FindControl("tb_estado")).Text = dr["estado_utilizador"].ToString();
                ((Button)e.Item.FindControl("btn_gravar")).CommandArgument = dr["cod_utilizador"].ToString();
                ((Button)e.Item.FindControl("btn_apagar")).CommandArgument = dr["cod_utilizador"].ToString();
                //((Button)e.Item.FindControl("btn_upload")).CommandArgument = dr["cod_utilizador"].ToString();
            }
        }

        protected void rpt_utilizadores_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            SqlConnection myConn = new SqlConnection(SqlDataSource1.ConnectionString);

            myConn.Open();

            //se eu cliquei no botao gravar
            if (e.CommandName == "btn_gravar")
            {
                string query = "UPDATE LojaOnlineUtilizador set ";

                query += "nome_utilizador='" + ((TextBox)e.Item.FindControl("tb_nome")).Text + "',";
                query += "pw_utilizador='" + ((TextBox)e.Item.FindControl("tb_pw")).Text + "',";
                query += "email_utilizador='" + ((TextBox)e.Item.FindControl("tb_email")).Text + "' ";
                query += "tlm_utilizador='" + ((TextBox)e.Item.FindControl("tb_contacto")).Text + "' ";
                query += "cod_perfil='" + ((TextBox)e.Item.FindControl("tb_perfil")).Text + "' ";
                query += "estado_utilizador='" + ((TextBox)e.Item.FindControl("tb_estado")).Text + "' ";
                query += "WHERE cod_utilizador=" + ((Button)e.Item.FindControl("btn_gravar")).CommandArgument;

                SqlCommand myCommand = new SqlCommand(query, myConn);
                myCommand.ExecuteNonQuery();
            }
            //se eu cliquei no botao apagar
            else if (e.CommandName == "btn_apagar")
            {
                string query = "DELETE FROM LojaOnlineUtilizador ";
                //string query2 = "DELETE FROM formandos WHERE num_formando=" + ((Button)e.Item.FindControl("btn_apagar")).CommandArgument;

                //query += "nome='" + ((TextBox)e.Item.FindControl("tb_nome")).Text + "',";
                //query += "idade='" + ((TextBox)e.Item.FindControl("tb_idade")).Text + "',";
                //query += "curso='" + ((TextBox)e.Item.FindControl("tb_curso")).Text + "' ";
                query += "WHERE cod_utilizador=" + ((Button)e.Item.FindControl("btn_apagar")).CommandArgument;

                SqlCommand myCommand = new SqlCommand(query, myConn);
                myCommand.ExecuteNonQuery();
            }
            /*else if (e.CommandName == "btn_upload")
            {
                // Obtém o número do formando a partir do CommandArgument do botão clicado
                int numFormando = Convert.ToInt32(e.CommandArgument);
                // Localiza o controle FileUpload dentro do item do Repeater
                FileUpload fileUpload = (FileUpload)e.Item.FindControl("FileUpload1");
                // Obtém os bytes da foto carregada
                byte[] fotoData = fileUpload.FileBytes;

                string query3 = "UPDATE formandos SET foto = @foto WHERE num_formando = @num_formando";
                SqlCommand myCommand = new SqlCommand(query3, myConn);
                myCommand.Parameters.AddWithValue("@foto", fotoData);
                myCommand.Parameters.AddWithValue("@num_formando", numFormando);

                myCommand.ExecuteNonQuery();

            }*/
            myConn.Close();
        }

        protected void btn_gravarTudo_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(SqlDataSource1.ConnectionString);
            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = myConn;

            myConn.Open();


            foreach (RepeaterItem formando in rpt_utilizadores.Items)
            {
                if (formando.ItemType == ListItemType.Item || formando.ItemType == ListItemType.AlternatingItem)
                {
                    string queryUpdate = "UPDATE formandos set ";
                    queryUpdate += "nome_utilizador='" + ((TextBox)formando.FindControl("tb_nome")).Text + "',";
                    queryUpdate += "pw_utilizador='" + ((TextBox)formando.FindControl("tb_pw")).Text + "',";
                    queryUpdate += "email_utilizador='" + ((TextBox)formando.FindControl("tb_email")).Text + "'";
                    queryUpdate += "tlm_utilizador='" + ((TextBox)formando.FindControl("tb_contacto")).Text + "' ";
                    queryUpdate += "cod_perfil='" + ((TextBox)formando.FindControl("tb_perfil")).Text + "' ";
                    queryUpdate += "estado_utilizador='" + ((TextBox)formando.FindControl("tb_estado")).Text + "' ";
                    queryUpdate += " WHERE num_formando=" + ((Label)formando.FindControl("lbl_num")).Text;

                    myCommand = new SqlCommand(queryUpdate, myConn);
                    myCommand.ExecuteNonQuery();
                }
            }


            myConn.Close();
            Response.Redirect(Request.RawUrl);
        }
    }
}