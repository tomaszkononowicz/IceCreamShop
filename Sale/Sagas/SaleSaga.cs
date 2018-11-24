using Automatonymous;
using Automatonymous.Binders;
using Common;
using Messages;
using Newtonsoft.Json;
using Sale.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Results;

namespace Sale.Sagas
{
    
    public class SaleSagaData : SagaStateMachineInstance, ISagaDataStoreDb
    {
        public const int ScoopPrice = 3;
        public Guid CorrelationId { get; set; }
        public State CurrentState { get; set; }
        public Guid SaleId { get; set; }
        public Dictionary<string, decimal> Products { get; set; }

        public async void SaveDataToDb()
        {
            SaleSagaDataDbsController saleSagaDataDbsController = new SaleSagaDataDbsController();
            SaleSagaDataDb sagaDb = new SaleSagaDataDb()
            {
                SaleId = this.SaleId,
                Products = JsonConvert.SerializeObject(Products)
            };
            var status = (saleSagaDataDbsController.GetSaleSagaDataDb(this.SaleId));
            if (status.GetType() == typeof(NotFoundResult))
            {
                await saleSagaDataDbsController.PostSaleSagaDataDb(sagaDb); 
            }
            else
            {
                await saleSagaDataDbsController.PutSaleSagaDataDb(sagaDb.SaleId, sagaDb);
            }
        }

        public void ReadDataFromDb(Guid id)
        {
            SaleSagaDataDbsController saleSagaDataDbsController = new SaleSagaDataDbsController();
            SaleSagaDataDb saleSagaDataDb = (saleSagaDataDbsController.GetSaleSagaDataDb(id) as OkNegotiatedContentResult<SaleSagaDataDb>).Content;
            this.SaleId = saleSagaDataDb.SaleId;
            this.Products = JsonConvert.DeserializeObject<Dictionary<string, decimal>>(saleSagaDataDb.Products);
        }
    }

    public class SaleSaga : MassTransitStateMachine<SaleSagaData>
    {
        public State WaitingForProducts { get; set; }
        public State End { get; set; }
        public Event<Messages.Sale> Sale { get; set; }
        public Event<Messages.ProductsForSale> ProductsForSale { get; set; }

        private EventActivityBinder<SaleSagaData, Messages.ProductsForSale> WhenProductsForSale (bool readFromDb = false)
        {
            return When(ProductsForSale)
                .Then(saga => { if (readFromDb) saga.Instance.ReadDataFromDb(saga.Data.CorrelationId); })
                .Then(async saga =>
                {
                    SalesController sc = new SalesController();
                    ProductsController pc = new ProductsController();
                    SalePositionsController spc = new SalePositionsController();
                    int saleId = sc.GetSales().ToList().Any() ? sc.GetSales().ToList().Count() + 1 : 1;
                    Sale sale = new Sale()
                    {
                        Date = DateTime.Now,
                        Id = saleId,
                        SumPrice = (int)(saga.Data.Products.Sum(p => p.Value) * SaleSagaData.ScoopPrice)
                    };
                    foreach (var p in saga.Data.Products)
                    {
                        SalePosition salePosition = new SalePosition()
                        {
                            ProductId = pc.GetIdByName(p.Key),
                            SaleId = saleId,
                            Amount = p.Value,
                            Sale = sale
                        };
                        await spc.PostSalePosition(salePosition);
                    }
                })
                .Finalize();
        }

        public SaleSaga()
        {
            InstanceState(state => state.CurrentState);
            Event(() => Sale, x => x.CorrelateBy(ssg => ssg.SaleId.ToString(), sale => sale.Message.SaleId.ToString()).SelectId(saga => saga.Message.SaleId));
            Event(() => ProductsForSale, x => x.CorrelateBy(ssg => ssg.SaleId.ToString(), sale => sale.Message.CorrelationId.ToString()).SelectId(saga => saga.Message.CorrelationId));

            Initially(
                WhenProductsForSale(true),
                When(Sale).Then(saga =>
                {
                    saga.Instance.SaleId = saga.Data.SaleId;
                    saga.Instance.Products = saga.Data.Products;
                    saga.Instance.SaveDataToDb();
                })
                .Respond(saga =>
                {
                    Dictionary<string, decimal> productsZero = new Dictionary<string, decimal>();
                    foreach (var product in saga.Instance.Products)
                    {
                        productsZero.Add(product.Key, 0);
                    }
                    return new Messages.GetProducts()
                    {
                        CorrelationId = saga.Instance.CorrelationId,
                        Products = saga.Instance.Products,
                        ProductsCompleted = productsZero
                    };
                })
                .TransitionTo(WaitingForProducts));

            During(WaitingForProducts, 
                WhenProductsForSale());

            SetCompletedWhenFinalized();
        }
    }

}