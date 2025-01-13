using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PFTracker
{
    public partial class RecoverPW : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_enviar_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["atec_cascaisConnectionString"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();

            //variaveis de inpout
            myCommand.Parameters.AddWithValue("@email", tb_email.Text);

            //variaveis de ouput1
            SqlParameter valor = new SqlParameter();
            valor.ParameterName = "@retorno";
            valor.Direction = ParameterDirection.Output;
            valor.SqlDbType = SqlDbType.Int;

            myCommand.Parameters.Add(valor);




            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "pft_recuperarPW";

            myCommand.Connection = myConn;

            myConn.Open();
            myCommand.ExecuteNonQuery();

            //apanhar o valor do retorno
            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);


            myConn.Close();
            if (respostaSP == 1)
            {
                lbl_mensagem.Text = "Email correspondido com sucesso, verifique o seu email para recuperar a Palavra-Passe";
                lbl_mensagem.ForeColor = System.Drawing.Color.Green;
                //envio do email
                MailMessage m = new MailMessage();
                SmtpClient sc = new SmtpClient();

                try
                {
                    m.From = new MailAddress("Diogo.Louro.T0127776@edu.atec.pt");
                    m.To.Add(new MailAddress(tb_email.Text));
                    m.Subject = "Recuperação de Senha";
                    m.IsBodyHtml = true;

                    m.Body = $"Para recuperar a sua senha, clique <a href='https://localhost:44308/ResetPW.aspx?util={EncryptString(tb_email.Text)}' >aqui</a>";

                    sc.Host = "smtp.office365.com";
                    //sc.Host = "smtp-mail.outlook.com";
                    sc.Port = 587;
                    sc.Credentials = new System.Net.NetworkCredential("Diogo.Louro.T0127776@edu.atec.pt", "sPsrA3zp");

                    sc.EnableSsl = true;
                    sc.Send(m);
                }
                catch (Exception ex)
                {
                    lbl_mensagem.Text = ex.Message;
                }
            }
            else
            {
                lbl_mensagem.Text = "Email não existente";
                lbl_mensagem.ForeColor = System.Drawing.Color.Red;
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