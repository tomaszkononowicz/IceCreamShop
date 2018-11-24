
using Messages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sale.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            List<Product> products = new ProductsController().GetProducts().ToList();
            ViewData["products"] = products;

            return View();
        }

        
        public ActionResult History()
        {
            List<Sale> sales = new SalesController().GetSales().ToList();
            ProductsController pc = new ProductsController();
            Dictionary<int, string> products = new Dictionary<int, string>();

            pc.GetProducts().ToList().ForEach(p => products.Add(p.Id, p.Name));

            ViewData["sales"] = sales;
            ViewData["products"] = products;

            return View();
        }

        [HttpPost]
        public ActionResult Sale(int[] positions)
        {
            List<Product> products = new ProductsController().GetProducts().ToList();
            Dictionary<string, decimal> order = new Dictionary<string, decimal>();
            products.Where(p => positions[p.Id-1] != 0).ToList().ForEach(p => order.Add(p.Name, positions[p.Id-1]));


            Global.Bus.Publish<Messages.Sale>(new
            {
                SaleId = Guid.NewGuid(),
                Products = order
            });

            return RedirectToAction("Index");
        }
    }
}