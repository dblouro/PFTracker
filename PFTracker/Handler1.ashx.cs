using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PFTracker
{
    /// <summary>
    /// Descrição resumida de Handler1
    /// </summary>
    public class Handler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Olá, Mundo");
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