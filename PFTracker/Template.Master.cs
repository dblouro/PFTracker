using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PFTracker
{
    public partial class Template : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["Email"] != null)
                {
                    lbl_user.Text = $"Bem-vindo, {Session["Email"]}";
                    btn_logout.Visible = true;
                    btn_login.Visible = false;
                }
                else
                {
                    ExibirMensagemNaoLogado();
                }

                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    
                }
                else
                {
                    lblDebug.Visible = true;
                    lblDebug.Text = "Session UserId is null";
                }
            }
            catch (Exception ex)
            {
                // Log de erro para monitoramento
                lblDebug.Visible = true;
                lblDebug.Text = "Erro ao carregar sessão: " + ex.Message;
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            // Redireciona para a página de login
            Response.Redirect("Login.aspx");
        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            // Limpa a sessão e redireciona para a página inicial
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }

        private void ExibirMensagemNaoLogado()
        {
            lbl_user.Text = "Você não está logado.";
            btn_logout.Visible = false;
            btn_login.Visible = true;
        }
    }
}
