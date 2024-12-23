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

namespace PFTracker
{
    public partial class ChangePW : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Utilizador"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btn_alterar_Click(object sender, EventArgs e)
        {
            string utilizador = Session["utilizador"].ToString();
            string pwAtual = EncryptString(tb_pwAtual.Text);
            string pwNova = EncryptString(tb_pwNova.Text);

            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["atec_cascaisConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();

            //variaveis de inpout
            myCommand.Parameters.AddWithValue("@util", utilizador);
            myCommand.Parameters.AddWithValue("@pwAtual", EncryptString(tb_pwAtual.Text));
            myCommand.Parameters.AddWithValue("@pwNova", EncryptString(tb_pwNova.Text));

            //variaveis de ouput
            SqlParameter valor = new SqlParameter();
            valor.ParameterName = "@retorno";
            valor.Direction = ParameterDirection.Output;
            valor.SqlDbType = SqlDbType.Int;

            myCommand.Parameters.Add(valor);


            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "pft_alterarPW";

            myCommand.Connection = myConn;

            myConn.Open();
            myCommand.ExecuteNonQuery();

            //apanhar o valor do retorno
            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);
            myConn.Close();
            if (respostaSP == 1)
            {
                lbl_mensagem.Text = "Palavra-Passe atualizada com sucesso";
            }
            else
            {
                lbl_mensagem.Text = "Palavra-Passe já existente!";
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
    }
}