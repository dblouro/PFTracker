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
                    string query = "SELECT id_utilizador FROM pft_utilizador WHERE id_utilizador = @userId";

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
                ((Label)e.Item.FindControl("lbl_num")).Text = dr["id_utilizador"].ToString();
                ((TextBox)e.Item.FindControl("tb_nome")).Text = dr["nome"].ToString();
                ((TextBox)e.Item.FindControl("tb_pw")).Text = dr["senha"].ToString();
                ((TextBox)e.Item.FindControl("tb_email")).Text = dr["email"].ToString();
                ((TextBox)e.Item.FindControl("tb_contacto")).Text = dr["telemovel"].ToString();
                ((TextBox)e.Item.FindControl("tb_nif")).Text = dr["nif"].ToString();
                ((TextBox)e.Item.FindControl("tb_morada")).Text = dr["morada"].ToString();
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
                string query = "UPDATE pft_utilizador set ";

                query += "nome='" + ((TextBox)e.Item.FindControl("tb_nome")).Text + "',";
                query += "senha='" + ((TextBox)e.Item.FindControl("tb_pw")).Text + "',";
                query += "email='" + ((TextBox)e.Item.FindControl("tb_email")).Text + "' ";
                query += "telemovel='" + ((TextBox)e.Item.FindControl("tb_contacto")).Text + "' ";
                query += "nif='" + ((TextBox)e.Item.FindControl("tb_nif")).Text + "' ";
                query += "tipo_perfil='" + ((TextBox)e.Item.FindControl("tb_perfil")).Text + "' ";
                query += "ativo='" + ((TextBox)e.Item.FindControl("tb_estado")).Text + "' ";
                query += "morada='" + ((TextBox)e.Item.FindControl("tb_morada")).Text + "' ";
                query += "WHERE id_utilizador=" + ((Button)e.Item.FindControl("btn_gravar")).CommandArgument;

                SqlCommand myCommand = new SqlCommand(query, myConn);
                myCommand.ExecuteNonQuery();
            }
            //se eu cliquei no botao apagar
            else if (e.CommandName == "btn_apagar")
            {
                string query = "DELETE FROM pft_utilizador ";
                //string query2 = "DELETE FROM formandos WHERE num_formando=" + ((Button)e.Item.FindControl("btn_apagar")).CommandArgument;

                //query += "nome='" + ((TextBox)e.Item.FindControl("tb_nome")).Text + "',";
                //query += "idade='" + ((TextBox)e.Item.FindControl("tb_idade")).Text + "',";
                //query += "curso='" + ((TextBox)e.Item.FindControl("tb_curso")).Text + "' ";
                query += "WHERE id_utilizador=" + ((Button)e.Item.FindControl("btn_apagar")).CommandArgument;

                SqlCommand myCommand = new SqlCommand(query, myConn);
                myCommand.ExecuteNonQuery();
            }
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
                    string queryUpdate = "UPDATE pft_utilizador set ";
                    queryUpdate += "nome='" + ((TextBox)formando.FindControl("tb_nome")).Text + "',";
                    queryUpdate += "senha='" + ((TextBox)formando.FindControl("tb_pw")).Text + "',";
                    queryUpdate += "email='" + ((TextBox)formando.FindControl("tb_email")).Text + "'";
                    queryUpdate += "telemovel='" + ((TextBox)formando.FindControl("tb_contacto")).Text + "' ";
                    queryUpdate += "tipo_perfil='" + ((TextBox)formando.FindControl("tb_perfil")).Text + "' ";
                    queryUpdate += "ativo='" + ((TextBox)formando.FindControl("tb_estado")).Text + "' ";
                    queryUpdate += "morada='" + ((TextBox)formando.FindControl("tb_morada")).Text + "' ";
                    queryUpdate += " WHERE id_utilizador=" + ((Label)formando.FindControl("lbl_num")).Text;

                    myCommand = new SqlCommand(queryUpdate, myConn);
                    myCommand.ExecuteNonQuery();
                }
            }


            myConn.Close();
            Response.Redirect(Request.RawUrl);
        }
    }
}