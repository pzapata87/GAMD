﻿using System;
using System.Text;
using System.Web.Http;
using System.Web.Mvc;
using log4net;

namespace GAMD.WebApi.Controllers
{
    public class BaseController : ApiController
    {
        #region Atributos

        protected static readonly ILog Logger = LogManager.GetLogger(string.Empty);
 
        #endregion

        protected void LogError(Exception exception)
        {
            Logger.Error(string.Format("Mensaje: {0} Trace: {1}", exception.Message, exception.StackTrace));
        }

        /// <summary>  
        /// Override the Json Result with Max integer JSON lenght  
        /// </summary>  
        /// <param name="data">Data</param>  
        /// <returns>As JsonResult</returns>  
        protected JsonResult Json(object data)
        {
            return new JsonResult()
            {
                Data = data,
                ContentType = "application/json; charset=utf-8",
                ContentEncoding = Encoding.UTF8,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                MaxJsonLength = Int32.MaxValue
            };
        } 
    }
}
