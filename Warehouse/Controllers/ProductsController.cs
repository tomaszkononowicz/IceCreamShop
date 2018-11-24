using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.Http.Results;
using Warehouse;
using Warehouse.Models;

namespace Warehouse.Controllers
{
    public class ProductsController : ApiController
    {
        // POST: api/Products/AddOrUpdate
        [HttpPost]
        public async Task<IHttpActionResult> AddOrUpdate(Order order)
        {
            Product product = this.GetProducts().Where(p => p.Name.Equals(order.Name)).FirstOrDefault();
            decimal amount;
            try
            {
                amount = decimal.Parse(order.Amount);
            }
            catch (Exception e)
            {
                return BadRequest();
            }
            if (product != null)
            {
                ProductAmountsController pac = new ProductAmountsController();
                decimal oldAmount = ((pac.GetProductAmount(product.Id)) as OkNegotiatedContentResult<ProductAmount>).Content.Amount ?? 0;
                db.Database.ExecuteSqlCommand("UPDATE[IceCreamShop_Warehouse].[dbo].[ProductAmount] SET Amount = " + (amount + oldAmount) + "WHERE ProductId = " + product.Id);

            }
            else
            {
                int newId = this.GetProducts().Count() + 1;
                Product newProduct = new Product() { Id = newId, Name = order.Name };
                ProductAmount pa = new ProductAmount { ProductId = newProduct.Id, Amount = amount };
                ProductAmountsController pac = new ProductAmountsController();
                await pac.PostProductAmount(pa);
                db.Database.ExecuteSqlCommand("INSERT INTO [IceCreamShop_Warehouse].[dbo].[Product] VALUES (" + newProduct.Id + ", '" + order.Name + "')");
            }

            return Ok();
        }

        private IceCreamShop_WarehouseEntities db = new IceCreamShop_WarehouseEntities();

        // GET: api/Products
        public IQueryable<Product> GetProducts()
        {
            return db.Products;
        }

        // GET: api/Products/5
        [ResponseType(typeof(Product))]
        public async Task<IHttpActionResult> GetProduct(int id)
        {
            Product product = await db.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }

            return Ok(product);
        }

        // PUT: api/Products/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutProduct(int id, Product product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != product.Id)
            {
                return BadRequest();
            }

            db.Entry(product).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Products
        [ResponseType(typeof(Product))]
        public async Task<IHttpActionResult> PostProduct(Product product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Products.Add(product);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ProductExists(product.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = product.Id }, product);
        }

        // DELETE: api/Products/5
        [ResponseType(typeof(Product))]
        public async Task<IHttpActionResult> DeleteProduct(int id)
        {
            db.Database.ExecuteSqlCommand("DELETE FROM [IceCreamShop_Warehouse].[dbo].[Product] WHERE Id =" + id);
            return Ok();
        }



        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ProductExists(int id)
        {
            return db.Products.Count(e => e.Id == id) > 0;
        }

        public int GetIdByName(string name)
        {
            return db.Products.Where(sfg => sfg.Name == name).First().Id;
        }
    }
}