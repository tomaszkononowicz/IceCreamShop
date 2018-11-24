using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MassTransit;

namespace Messages
{
    public class Message : CorrelatedBy<Guid>
    {
        public Guid CorrelationId { get; set; }
    }

    public class PutProduct : Message
    {
        public string Name { get; set; }
        public decimal Amount { get; set; }
    }

    public class PutProductACK : Message
    {
    }

    public class GetSemiFinishedGoods : Message
    {
        public Dictionary<string, decimal> SemiFinishedGoods { get; set; }
    }

    public class SemiFinishedGoodsForProduction : Message
    {
        public Dictionary<string, decimal> SemiFinishedGoods { get; set; }
    }

    public class Produce : Message
    {
        public Guid ProductionId { get; set; }
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Amount { get; set; }
    }

    public class SemiFinishedGoodsExist : Message {}

    public class SemiFinishedGoodsNotExist : Message { }

    /**OrderSaga*/

    public class ToProduce : Message
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Amount { get; set; }
    }

    public class OrderProduct : Message
    {
        public Guid OrderId { get; set; }
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Amount { get; set; }
    }

    public class Sale : Message
    {
        public Guid SaleId { get; set; }
        public Dictionary<string, decimal> Products { get; set; }

    }

    public class GetProducts : Message
    {
        public Dictionary<string, decimal> Products { get; set; }
        public Dictionary<string, decimal> ProductsCompleted { get; set; }

    }

    public class ProductsForSale : Message
    {
        public Dictionary<string, decimal> Products { get; set; }

    }




}
