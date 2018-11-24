using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace Warehouse
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "Oc",
                routeTemplate: "api/{controller}"
            );


            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: null,
                constraints: new { id = @"^\d+$" } // Only integers 
            );

            config.Routes.MapHttpRoute(
                name: "MyRoute",
                routeTemplate: "api/{controller}/{action}"
            );
        }
    }
}
