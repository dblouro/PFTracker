using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Google.Apis.Auth;
using System.Threading.Tasks;

namespace PFTracker
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["atec_cascaisConnectionString"].ConnectionString))
                {
                    using (SqlCommand myCommand = new SqlCommand("pft_login_perfil", myConn))
                    {
                        myCommand.CommandType = CommandType.StoredProcedure;

                        // Parâmetros de entrada
                        myCommand.Parameters.AddWithValue("@nome", tb_utilizador.Text.Trim());
                        myCommand.Parameters.AddWithValue("@pw", EncryptString(tb_pw.Text.Trim()));

                        // Parâmetro de saída: retorno
                        SqlParameter retornoParam = new SqlParameter("@retorno", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        myCommand.Parameters.Add(retornoParam);

                        // Parâmetro de saída: perfil
                        SqlParameter perfilParam = new SqlParameter("@retorno_perfil", SqlDbType.VarChar, 20)
                        {
                            Direction = ParameterDirection.Output
                        };
                        myCommand.Parameters.Add(perfilParam);

                        // Parâmetro de saída: ID do utilizador
                        SqlParameter idUtilizadorParam = new SqlParameter("@id_utilizador", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        myCommand.Parameters.Add(idUtilizadorParam);

                        myConn.Open();
                        myCommand.ExecuteNonQuery();

                        // Obter os valores de saída
                        int respostaSP = (int)myCommand.Parameters["@retorno"].Value;
                        string respostaPerfil = myCommand.Parameters["@retorno_perfil"].Value.ToString();
                        int idUtilizador = (int)myCommand.Parameters["@id_utilizador"].Value;

                        if (respostaSP == 1)
                        {
                            Session["Email"] = tb_utilizador.Text;
                            Session["Role"] = respostaPerfil;
                            Session["UserId"] = idUtilizador;

                            if (respostaPerfil == "admin")
                            {
                                Response.Redirect("GestaoUtilizadores.aspx");
                            }
                            else
                            {
                                Response.Redirect("Home.aspx");
                            }
                        }
                        else
                        {
                            lbl_mensagem.Text = "Credenciais inválidas!";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lbl_mensagem.Text = "Erro no processo de login. Por favor, tente novamente.";
                // Log opcional: Registrar o erro para depuração
            }
        }

        public static string EncryptString(string Message)
        {
            string Passphrase = "atec";
            byte[] Results;
            System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();

            // Step 1. We hash the passphrase using MD5
            // We use the MD5 hash generator as the result is a 128 bit byte array
            // which is a valid length for the TripleDES encoder we use below

            MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
            byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));

            // Step 2. Create a new TripleDESCryptoServiceProvider object
            TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();

            // Step 3. Setup the encoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]
            byte[] DataToEncrypt = UTF8.GetBytes(Message);

            // Step 5. Attempt to encrypt the string
            try
            {
                ICryptoTransform Encryptor = TDESAlgorithm.CreateEncryptor();
                Results = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }

            // Step 6. Return the encrypted string as a base64 encoded string

            string enc = Convert.ToBase64String(Results);
            enc = enc.Replace("+", "KKK");
            enc = enc.Replace("/", "JJJ");
            enc = enc.Replace("\\", "III");
            return enc;
        }


        protected async void btn_google_Click(object sender, EventArgs e)
        {
            string idToken = Request.Form["id_token"]; //obter o token enviado pela API do Google
            if (string.IsNullOrEmpty(idToken))
            {
                lbl_mensagem.Text = "Token de autenticação não recebido.";
                return;
            }

            bool isValid = await ValidarGoogleTokenSync(idToken);

            if (isValid)
            {
                // Exemplo: Obtenha informações do payload (email)
                var payload = await GoogleJsonWebSignature.ValidateAsync(idToken);
                string email = payload.Email;

                // Verifique se o utilizador já existe na base de dados
                SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["atec_cascaisConnectionString"].ConnectionString);
                SqlCommand myCommand = new SqlCommand("SELECT * FROM pft_utilizador WHERE email = @Email", myConn);
                myCommand.Parameters.AddWithValue("@Email", email);

                myConn.Open();
                SqlDataReader reader = myCommand.ExecuteReader();

                if (reader.HasRows)
                {
                    // O utilizador já existe, autentique
                    Session["Email"] = email;
                    Session["Role"] = "user"; // Ajuste conforme o seu esquema
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    // Novo utilizador, crie o registo
                    reader.Close();
                    myCommand.CommandText = "INSERT INTO pft_utilizador (email, ativo, google_auth) VALUES (@Email, 1, 1)";
                    myCommand.ExecuteNonQuery();

                    Session["Email"] = email;
                    Session["Role"] = "user";
                    Response.Redirect("Home.aspx");
                }

                myConn.Close();
            }
            else
            {
                lbl_mensagem.Text = "Falha na autenticação com Google.";
            }
        }
        public async Task<bool> ValidarGoogleTokenSync(string idToken)
        {
            try
            {
                // Valida o token usando a biblioteca do Google
                var payload = await GoogleJsonWebSignature.ValidateAsync(idToken); // Executa de forma síncrona
                Console.WriteLine($"Usuário: {payload.Email}, Nome: {payload.Name}");
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erro ao validar token: {ex.Message}");
                lbl_mensagem.Text = $"Erro ao validar token: {ex.Message}";
                return false;
            }
        }

        

    }
}