using MassTransit;
using Messages;
using Newtonsoft.Json;
using Production.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http.Results;
using System.Web.Mvc;

namespace Production.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            List<Product> products = new ProductsController().GetProducts().ToList();
            List<Recipe> recipes = new RecipesController().GetRecipes().ToList();
            List<Queue> queues = new QueuesController().GetQueues().ToList();

            ViewData["products"] = products;
            ViewData["recipes"] = recipes;
            ViewData["queues"] = queues;


            return View();
        }

        public ActionResult History()
        {
            List<Production> productions = new ProductionsController().GetProductions().ToList();
            ViewData["productions"] = productions;

            return View();
        }

        [HttpPost]
        public async Task<ActionResult> Produce(ProductToProduce productToProduce)
        {
            ProductsController pc = new ProductsController();
            int id = pc.GetIdByName(productToProduce.Name);
            await Global.Bus.Publish<Produce>(new
            {
                ProductionId = Guid.NewGuid(),
                ProductId = id,
                Name = productToProduce.Name,
                Amount = productToProduce.Amount
            });

            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<ActionResult> ToProduce(int id)
        {
            QueuesController qc = new QueuesController();
            Queue queue = (qc.GetQueue(id) as OkNegotiatedContentResult<Queue>).Content;
            ToProduce msg = JsonConvert.DeserializeObject<ToProduce>(queue.Msg);

            await Global.Bus.Publish<Produce>(new
            {
                ProductionId = (Guid)queue.CorrelationId,
                ProductId = msg.ProductId,
                Name = msg.Name,
                Amount = msg.Amount
            });

            await qc.DeleteQueue(id);

            return RedirectToAction("Index");
        }
    }
}