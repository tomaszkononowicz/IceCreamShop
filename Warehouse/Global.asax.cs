using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;
using MassTransit.Saga;
using MassTransit;
using Warehouse.Sagas;

namespace Warehouse
{
    public class Global : HttpApplication
    {
        static IBusControl bus;

        public static IBus Bus
        {
            get { return bus; }
        }
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
            GlobalConfiguration.Configuration.Formatters.Remove(GlobalConfiguration.Configuration.Formatters.XmlFormatter);



            GetSemiFinishedGoodsHandler getSemiFinishedGoods = new GetSemiFinishedGoodsHandler();
            PutProductHandler putProduct = new PutProductHandler();
            GetProductsHandler getProductsHandler = new GetProductsHandler();

            var repo = new InMemorySagaRepository<Sagas.OrderSagaData>();
            var machine = new OrderSaga();

            bus = MassTransit.Bus.Factory.CreateUsingRabbitMq(sbc =>
            {
                var host = sbc.Host(new Uri("rabbitmq://nifuqifp:aUx27MccsWLfbZ5kgf2nch1mkAXdKMdi@chimpanzee.rmq.cloudamqp.com/nifuqifp"),
                    h => { h.Username("nifuqifp"); h.Password("aUx27MccsWLfbZ5kgf2nch1mkAXdKMdi"); });
                sbc.UseInMemoryScheduler();
                sbc.ReceiveEndpoint(host, "warehouse", ep =>
                {
                    ep.Instance(getSemiFinishedGoods);
                    ep.Instance(putProduct);
                    ep.Instance(getProductsHandler);
                    ep.StateMachineSaga(machine, repo);
                });

            });
            
            bus.Start();
        }

        void Application_End()
        {
            if (bus != null)
            {
                bus.Stop();
            }
        }
    }
}