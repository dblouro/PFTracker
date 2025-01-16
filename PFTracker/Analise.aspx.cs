using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PFTracker
{
    public partial class Analise : System.Web.UI.Page
    {
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
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
        }

        [WebMethod]
        public static string ObterDadosGraficos()
        {
            // Recupera o id_utilizador da sessão
            int id_utilizador = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString;

            var despesas = new { labels = new List<string>(), valores = new List<decimal>() };
            var receitasDespesas = new { meses = new List<string>(), receitas = new List<decimal>(), despesas = new List<decimal>() };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Consulta à view de despesas com filtro por id_utilizador
                string queryDespesas = "SELECT Categoria, TotalDespesa FROM vw_DistribuicaoDespesas WHERE id_utilizador = @id_utilizador";
                using (SqlCommand cmd = new SqlCommand(queryDespesas, connection))
                {
                    cmd.Parameters.AddWithValue("@id_utilizador", id_utilizador);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            despesas.labels.Add(reader["Categoria"].ToString());
                            despesas.valores.Add(Convert.ToDecimal(reader["TotalDespesa"]));
                        }
                    }
                }

                // Consulta à view de receitas e despesas com filtro por id_utilizador
                string queryReceitasDespesas = "SELECT Mes, TotalReceitas, TotalDespesas FROM vw_ReceitasDespesasMensais WHERE id_utilizador = @id_utilizador";
                using (SqlCommand cmd = new SqlCommand(queryReceitasDespesas, connection))
                {
                    cmd.Parameters.AddWithValue("@id_utilizador", id_utilizador);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            receitasDespesas.meses.Add(reader["Mes"].ToString());
                            receitasDespesas.receitas.Add(Convert.ToDecimal(reader["TotalReceitas"]));
                            receitasDespesas.despesas.Add(Convert.ToDecimal(reader["TotalDespesas"]));
                        }
                    }
                }
            }

            var dados = new
            {
                despesas,
                receitasDespesas
            };

            return new JavaScriptSerializer().Serialize(dados);
        }

        [WebMethod]
        public static string ObterPrevisaoDespesas(int mesAtual)
        {
            // Recupera o id_utilizador da sessão
            int id_utilizador = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString;
            var previsoes = new List<object>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand cmd = new SqlCommand("sp_GetPrevisaoDespesas", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@mesAtual", mesAtual);
                    cmd.Parameters.AddWithValue("@id_utilizador", id_utilizador); // Passando o id_utilizador como parâmetro para a SP

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            previsoes.Add(new
                            {
                                Categoria = reader["Categoria"].ToString(),
                                Mes = Convert.ToInt32(reader["Mes"]),
                                MediaMensalDespesas = Convert.ToDecimal(reader["MediaMensalDespesas"])
                            });
                        }
                    }
                }
            }

            return new JavaScriptSerializer().Serialize(previsoes);
        }
    }
}
