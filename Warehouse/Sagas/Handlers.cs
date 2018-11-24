using MassTransit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Messages;
using System.Threading.Tasks;
using Warehouse.Controllers;
using Newtonsoft.Json;

namespace Warehouse.Sagas
{
    public class GetSemiFinishedGoodsHandler : IConsumer<GetSemiFinishedGoods>
    {

        public Task Consume(ConsumeContext<GetSemiFinishedGoods> msg)
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

    public class GetProductsHandler : IConsumer<GetProducts>
    {
        public Task Consume(ConsumeContext<GetProducts> msg)
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

    public class PutProductHandler : IConsumer<PutProduct>
    {
        public Task Consume(ConsumeContext<PutProduct> msg)
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