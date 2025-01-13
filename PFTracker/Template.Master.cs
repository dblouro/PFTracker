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
            if (Session["Email"] != null)
            {
                lbl_user.Text = "Bem-vindo, " + Session["Email"].ToString();
                btn_logout.Visible = true;
                btn_login.Visible = false;
            }
            else
            {
                lbl_user.Text = "Você não está logado.";
                btn_logout.Visible = false;
                btn_login.Visible = true;
            }
        }
        protected void btn_login_Click(object sender, EventArgs e)
        {
            //redireciona para a página de login
            Response.Redirect("Login.aspx");
        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            //redireciona para a dashboard e abandona todas as sessoes
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
    }
}