using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Warehouse.Models;
using Messages;
using System.Web.Http.Results;

namespace Warehouse.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            List<Product> products = new ProductsController().GetProducts().ToList();
            List<ProductAmount> productsAmount = new ProductAmountsController().GetProductAmounts().ToList();
            List<SemiFinishedGood> semiFinishedGoods = new SemiFinishedGoodsController().GetSemiFinishedGoods().ToList();
            List<SemiFinishedGoodAmount> semiFinishedGoodsAmount = new SemiFinishedGoodAmountsController().GetSemiFinishedGoodAmounts().ToList();
            List<Queue> queues = new QueuesController().GetQueues().ToList();

            ViewData["products"] = products;
            ViewData["productsAmount"] = productsAmount;
            ViewData["semiFinishedGoods"] = semiFinishedGoods;
            ViewData["semiFinishedGoodsAmount"] = semiFinishedGoodsAmount;
            ViewData["queues"] = queues;


            return View();
        }

        [HttpPost]
        public async Task<ActionResult> AddOrUpdateProduct(Order order)
        {
            ProductsController pc = new ProductsController();
            int id = pc.GetIdByName(order.Name);
            await Global.Bus.Publish<OrderProduct>(new
            {
                OrderId = Guid.NewGuid(),
                ProductId = id,
                Name = order.Name,
                Amount = order.Amount
            });

            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<ActionResult> GetSemiFinishedGoods(int id)
        {
            SemiFinishedGoodAmountsController sfgac = new SemiFinishedGoodAmountsController();
            SemiFinishedGoodsController sfgc = new SemiFinishedGoodsController();
            QueuesController qc = new QueuesController();
            Queue queue = (qc.GetQueue(id) as OkNegotiatedContentResult<Queue>).Content;
            GetSemiFinishedGoods msg = JsonConvert.DeserializeObject<GetSemiFinishedGoods>(queue.Msg);
            foreach (var item in msg.SemiFinishedGoods)
            {
                int _id = sfgc.GetSemiFinishedGoodId(item.Key);
                if (!sfgac.CheckIfAmountOfSemiFinishedGoodsExist(item.Key, item.Value))
                {
                    decimal amount = sfgac.GetSemiFinishedGoodAmountDecimal(_id);
                    decimal missingAmount = item.Value - amount;
                    sfgac.PutSemiFinishedGoodAmountDecimal(_id, missingAmount);
                }
                else
                {
                    sfgac.PutSemiFinishedGoodAmountDecimal(_id, -item.Value);
                }
            }

            await Global.Bus.Publish(new SemiFinishedGoodsForProduction()
            {
                CorrelationId = (Guid)queue.CorrelationId,
                SemiFinishedGoods = msg.SemiFinishedGoods
            });

            await qc.DeleteQueue(id);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<ActionResult> PutProduct(int id)
        {
            QueuesController qc = new QueuesController();
            Queue queue = (qc.GetQueue(id) as OkNegotiatedContentResult<Queue>).Content;
            PutProduct msg = JsonConvert.DeserializeObject<PutProduct>(queue.Msg);

            ProductAmountsController pac = new ProductAmountsController();
            pac.PutProductName(msg.Name, msg.Amount);

            await Global.Bus.Publish(new PutProductACK() { CorrelationId = (Guid)queue.CorrelationId });

            await qc.DeleteQueue(id);

            return RedirectToAction("Index");
        }

        private async Task CheckQueue(Queue q)
        {
            QueuesController qc = new QueuesController();

            bool allCompleted = true;
            GetProducts gp = JsonConvert.DeserializeObject<GetProducts>(q.Msg);
            foreach (var item in gp.Products)
            {
                if (gp.ProductsCompleted[item.Key] != item.Value)
                {
                    allCompleted = false;
                }
            }
            if (allCompleted)
            {
                Queue nq = new Queue();
                nq.Command = typeof(ProductsForSale).Name;
                nq.Msg = JsonConvert.SerializeObject(gp.Products);
                nq.CorrelationId = q.CorrelationId;
                var queues = qc.GetQueues().ToList();

                await qc.PostQueue(nq);
                await qc.DeleteQueue(q.MsgId);
            }           
        }

        [HttpGet]
        public async Task<ActionResult> ProductsForSale(int id)
        {
            QueuesController qc = new QueuesController();
            Queue queue = (qc.GetQueue(id) as OkNegotiatedContentResult<Queue>).Content;
            Dictionary<string, decimal> products = JsonConvert.DeserializeObject<Dictionary<string, decimal>>(queue.Msg);

            await Global.Bus.Publish(new ProductsForSale() {
                CorrelationId = (Guid)queue.CorrelationId,
                Products = products
            });

            await qc.DeleteQueue(id);

            return RedirectToAction("Index");
        }


        [HttpGet]
        public async Task<ActionResult> GetProducts(int id)
        {
            QueuesController qc = new QueuesController();
            Queue queue = (qc.GetQueue(id) as OkNegotiatedContentResult<Queue>).Content;
            GetProducts msg = JsonConvert.DeserializeObject<GetProducts>(queue.Msg);

            ProductAmountsController pac = new ProductAmountsController();
            ProductsController pc = new ProductsController();
            foreach (var item in msg.Products)
            {
                int productId = pc.GetIdByName(item.Key);
                decimal neededAmount = item.Value - msg.ProductsCompleted[item.Key];
                if (!pac.CheckIfAmountOfProductsExist(productId, neededAmount))
                {
                    decimal amount = pac.GetProductAmountDecimal(productId);
                    decimal missingAmount = neededAmount - amount;

                    await Global.Bus.Publish<OrderProduct>(new
                    {
                        OrderId = Guid.NewGuid(),
                        ProductId = productId,
                        Name = item.Key,
                        Amount = missingAmount
                    });
                    pac.PutProductAmountDecimal(productId, -amount);
                    msg.ProductsCompleted[item.Key] += amount;
                }
                else
                {
                    pac.PutProductAmountDecimal(productId, -neededAmount);
                    msg.ProductsCompleted[item.Key] += neededAmount;
                }
                
            }

            var newMsg = JsonConvert.SerializeObject(msg);
            queue.Msg = newMsg;

            await qc.PutQueue(id, queue);
            await CheckQueue(queue);
            return RedirectToAction("Index");
        }

        [HttpPost]
        public async Task<ActionResult> AddOrUpdateSemi(Order order)
        {
            await new SemiFinishedGoodsController().AddOrUpdate(order);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<ActionResult> RemoveProduct(int id)
        {
            await new ProductsController().DeleteProduct(id);
            await new ProductAmountsController().DeleteProductAmount(id);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<ActionResult> RemoveSemi(int id)
        {
            await new SemiFinishedGoodsController().DeleteSemiFinishedGood(id);
            await new SemiFinishedGoodAmountsController().DeleteSemiFinishedGoodAmount(id);

            return RedirectToAction("Index");
        }
    }
}