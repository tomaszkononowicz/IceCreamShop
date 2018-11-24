using MassTransit;
using Messages;
using Newtonsoft.Json;
using Production.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Production.Sagas
{
    public class ToProduceHandler : IConsumer<ToProduce>
    {
        public Task Consume(ConsumeContext<ToProduce> msg)
        {
            QueuesController qc = new QueuesController();
            Queue q = new Queue();
            q.Command = msg.Message.GetType().Name;
            q.Msg = JsonConvert.SerializeObject(msg.Message);
            q.CorrelationId = msg.CorrelationId;
            var queues = qc.GetQueues().ToList();

            return qc.PostQueue(q);
        }
    }
}