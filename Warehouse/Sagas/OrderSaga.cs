using Automatonymous;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Warehouse.Controllers;

namespace Warehouse.Sagas
{
    public class OrderSagaData : SagaStateMachineInstance
    {
        public Guid CorrelationId { get; set; }
        public State CurrentState { get; set; }
        public Guid OrderId { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal ProductAmount { get; set; }
    }

    public class OrderSaga : MassTransitStateMachine<OrderSagaData>
    {
        public State WaitingForProducts { get; set; }
        public State End { get; set; }
        public Event<Messages.OrderProduct> Order { get; set; }
        public Event<Messages.PutProduct> PutProduct { get; set; }

        public OrderSaga()
        {
            InstanceState(state => state.CurrentState);
            Event(() => Order, x => x.CorrelateBy(osg => osg.OrderId.ToString(), order => order.Message.OrderId.ToString()).SelectId(saga => Guid.NewGuid()));
            Event(() => PutProduct, x => x.CorrelateBy(osg => osg.OrderId.ToString(), order => order.Message.CorrelationId.ToString()).SelectId(saga => saga.Message.CorrelationId));

            Initially(
                When(PutProduct).Finalize(),
                When(Order).Then(saga =>
                {
                    saga.Instance.ProductId = saga.Data.ProductId;
                    saga.Instance.ProductName = saga.Data.Name;
                    saga.Instance.ProductAmount = saga.Data.Amount;
                })
                .Respond(saga =>
                {

                    return new Messages.ToProduce()
                    {
                        CorrelationId = saga.Instance.CorrelationId,
                        ProductId = saga.Instance.ProductId,
                        Name = saga.Instance.ProductName,
                        Amount = saga.Instance.ProductAmount
                    };
                })
                .TransitionTo(WaitingForProducts));

            During(WaitingForProducts,
                When(PutProduct)
                .Finalize());

            SetCompletedWhenFinalized();
        }
    }

}