using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Automatonymous;
using Production.Controllers;
using Common;
using System.Web.Http.Results;
using Automatonymous.Binders;

namespace Production.Sagas
{
    public class ProduceSagaData : SagaStateMachineInstance, ISagaDataStoreDb
    {
        public Guid CorrelationId { get; set; }
        public State CurrentState { get; set; }
        public Guid ProductionId { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal ProductAmount { get; set; }

        public async void SaveDataToDb()
        {
            ProduceSagaDataDbsController produceSagaDataDbsController = new ProduceSagaDataDbsController();
            ProduceSagaDataDb sagaDb = new ProduceSagaDataDb()
            {
                ProductionId = this.ProductionId,
                ProductId = this.ProductId,
                ProductName = this.ProductName,
                ProductAmount = this.ProductAmount
            };
            var status = (produceSagaDataDbsController.GetProduceSagaDataDb(this.ProductionId));
            if (status.GetType() == typeof(NotFoundResult))
            {
                await produceSagaDataDbsController.PostProduceSagaDataDb(sagaDb);
            }
            else
            {
                await produceSagaDataDbsController.PutProduceSagaDataDb(sagaDb.ProductionId, sagaDb);
            }
        }

        public void ReadDataFromDb(Guid id)
        {
            ProduceSagaDataDbsController produceSagaDataDbsController = new ProduceSagaDataDbsController();
            ProduceSagaDataDb produceSagaDataDb = (produceSagaDataDbsController.GetProduceSagaDataDb(id) as OkNegotiatedContentResult<ProduceSagaDataDb>).Content;
            this.ProductionId = produceSagaDataDb.ProductionId;
            this.ProductId = produceSagaDataDb.ProductId.Value;
            this.ProductName = produceSagaDataDb.ProductName;
            this.ProductAmount = produceSagaDataDb.ProductAmount.Value;
        }
    }

    public class ProduceSaga : MassTransitStateMachine<ProduceSagaData>
    {
        public State PrepareSemiFinishedGoods { get; set; }
        public State InProduction { get; set; }
        public State Putting { get; set; }
        public Event<Messages.Produce> Produce { get; set; }
        public Event<Messages.SemiFinishedGoodsForProduction> SemiFinishedGoodsForProduction { get; set; }
        public Event<Messages.PutProductACK> PutProductACK { get; set; }

        private EventActivityBinder<ProduceSagaData, Messages.SemiFinishedGoodsForProduction> WhenSemiFinishedGoodsForProduction(bool readFromDb = false)
        {
            return When(SemiFinishedGoodsForProduction)
             .Then(saga => { if (readFromDb) saga.Instance.ReadDataFromDb(saga.Data.CorrelationId); })
             .TransitionTo(InProduction)
             .Then(saga =>
             {
                 ProductionsController pc = new ProductionsController();
                 pc.NewProduction(saga.Instance.ProductName, saga.Instance.ProductAmount);
             })
             .Publish(saga =>
             {
                 return new Messages.PutProduct()
                 {
                     CorrelationId = saga.Instance.CorrelationId,
                     Name = saga.Instance.ProductName,
                     Amount = saga.Instance.ProductAmount
                 };
             }).TransitionTo(Putting);
        }

        public ProduceSaga()
        {
            InstanceState(state => state.CurrentState);
            Event(() => Produce, x => x.CorrelateBy(psg => psg.ProductionId.ToString(), produce => produce.Message.ProductionId.ToString()).SelectId(saga => saga.Message.ProductionId));
            Event(() => SemiFinishedGoodsForProduction, x => x.CorrelateBy(psg => psg.ProductionId.ToString(), produce => produce.Message.CorrelationId.ToString()).SelectId(saga => saga.Message.CorrelationId));
            Event(() => PutProductACK, x => x.CorrelateBy(psg => psg.ProductionId.ToString(), produce => produce.Message.CorrelationId.ToString()).SelectId(saga => saga.Message.CorrelationId));

            Initially(
                WhenSemiFinishedGoodsForProduction(true),
                When(PutProductACK).Finalize(),
                When(Produce).Then(saga =>
                {
                    saga.Instance.ProductId = saga.Data.ProductId;
                    saga.Instance.ProductName = saga.Data.Name;
                    saga.Instance.ProductAmount = saga.Data.Amount;
                    saga.Instance.ProductionId = saga.Data.ProductionId;
                    saga.Instance.SaveDataToDb();
                })
                .Respond(saga =>
                {
                    RecipesController rc = new RecipesController();
                    return new Messages.GetSemiFinishedGoods() {
                        CorrelationId = saga.Instance.CorrelationId,
                        SemiFinishedGoods = rc.getRecipeForProduct(saga.Instance.ProductId, saga.Instance.ProductAmount)
                    };
                })
                .TransitionTo(PrepareSemiFinishedGoods));

            During(PrepareSemiFinishedGoods,
                WhenSemiFinishedGoodsForProduction());
            During(Putting,
                When(PutProductACK).Finalize());

            SetCompletedWhenFinalized();
        }
    }
}