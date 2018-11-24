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
using Production.Sagas;

namespace Production
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

            ToProduceHandler toProduceHandler = new ToProduceHandler();

            var repo = new InMemorySagaRepository<Sagas.ProduceSagaData>();
            var machine = new ProduceSaga();
            
            bus = MassTransit.Bus.Factory.CreateUsingRabbitMq(sbc =>
            {
                var host = sbc.Host(new Uri("rabbitmq://nifuqifp:aUx27MccsWLfbZ5kgf2nch1mkAXdKMdi@chimpanzee.rmq.cloudamqp.com/nifuqifp"),
                    h => { h.Username("nifuqifp"); h.Password("aUx27MccsWLfbZ5kgf2nch1mkAXdKMdi"); });
                sbc.UseInMemoryScheduler();
                sbc.ReceiveEndpoint(host, "production", ep =>
                {
                    ep.Instance(toProduceHandler);
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