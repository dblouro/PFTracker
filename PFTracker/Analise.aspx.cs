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

        }

        [WebMethod]
        public static string ObterDadosGraficos()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString;

            // Exemplo: Consultar duas views (Distribuição de Despesas e Receitas vs Despesas)
            var despesas = new { labels = new List<string>(), valores = new List<decimal>() };
            var receitasDespesas = new { meses = new List<string>(), receitas = new List<decimal>(), despesas = new List<decimal>() };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Consulta à view de despesas
                string queryDespesas = "SELECT Categoria, TotalDespesa FROM vw_DistribuicaoDespesas";
                using (SqlCommand cmd = new SqlCommand(queryDespesas, connection))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        despesas.labels.Add(reader["Categoria"].ToString());
                        despesas.valores.Add(Convert.ToDecimal(reader["TotalDespesa"]));
                    }
                }

                // Consulta à view de receitas e despesas
                string queryReceitasDespesas = "SELECT Mes, TotalReceitas, TotalDespesas FROM vw_ReceitasDespesasMensais";
                using (SqlCommand cmd = new SqlCommand(queryReceitasDespesas, connection))
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
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["pftrackerConnectionString_Categorias"].ConnectionString;
            var previsoes = new List<object>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand cmd = new SqlCommand("sp_GetPrevisaoDespesas", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@mesAtual", mesAtual);

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