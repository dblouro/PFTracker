using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PFTracker
{
    /// <summary>
    /// Descrição resumida de ImageHandler
    /// </summary>
    public class ImageHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int productId = Convert.ToInt32(context.Request.QueryString["id"]);

            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["atec_cascaisConnectionString"].ConnectionString);
            string query = "SELECT img_produto FROM LojaOnlineProdutos WHERE cod_produto = @id";

            SqlCommand cmd = new SqlCommand(query, myConn);
            cmd.Parameters.AddWithValue("@id", productId);

            myConn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                // Verifica se a coluna da foto contém dados
                if (reader["img_produto"] != DBNull.Value)
                {
                    byte[] fotoData = (byte[])reader["img_produto"];

                    // Especifica o tipo de conteúdo para a imagem
                    context.Response.ContentType = "image/png";
                    context.Response.BinaryWrite(fotoData);
                }
                else
                {
                    context.Response.StatusCode = 404;
                    context.Response.Write("Imagem não encontrada.");
                }
            }
            myConn.Close();


        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}