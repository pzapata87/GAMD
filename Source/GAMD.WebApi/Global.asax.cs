using System.Web.Http;
using GAMD.WebApi.Core;

namespace GAMD.WebApi
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configuration.MessageHandlers.Add(new CorsHandler());
            GlobalConfiguration.Configure(WebApiConfig.Register);
            GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Clear();
            log4net.Config.XmlConfigurator.Configure();
        }
    }
}
