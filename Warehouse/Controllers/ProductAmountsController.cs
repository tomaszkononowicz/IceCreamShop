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

namespace Warehouse.Controllers
{
    public class ProductAmountsController : ApiController
    {
        private IceCreamShop_WarehouseEntities db = new IceCreamShop_WarehouseEntities();

        // GET: api/ProductAmounts
        public IQueryable<ProductAmount> GetProductAmounts()
        {
            return db.ProductAmounts;
        }

        // GET: api/ProductAmounts/5
        [ResponseType(typeof(ProductAmount))]
        public IHttpActionResult GetProductAmount(int id)
        {
            ProductAmount productAmount = db.ProductAmounts.Find(id);
            if (productAmount == null)
            {
                return NotFound();
            }

            return Ok(productAmount);
        }

        // PUT: api/ProductAmounts/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutProductAmount(int id, ProductAmount productAmount)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != productAmount.ProductId)
            {
                return BadRequest();
            }

            db.Entry(productAmount).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductAmountExists(id))
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

        // POST: api/ProductAmounts
        [ResponseType(typeof(ProductAmount))]
        public async Task<IHttpActionResult> PostProductAmount(ProductAmount productAmount)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ProductAmounts.Add(productAmount);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ProductAmountExists(productAmount.ProductId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = productAmount.ProductId }, productAmount);
        }

        // DELETE: api/ProductAmounts/5
        [ResponseType(typeof(ProductAmount))]
        public async Task<IHttpActionResult> DeleteProductAmount(int id)
        {
            ProductAmount productAmount = await db.ProductAmounts.FindAsync(id);
            if (productAmount == null)
            {
                return NotFound();
            }

            db.ProductAmounts.Remove(productAmount);
            await db.SaveChangesAsync();

            return Ok(productAmount);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public bool ProductAmountExists(int id)
        {
            return db.ProductAmounts.Count(e => e.ProductId == id) > 0;
        }

        public bool CheckIfAmountOfProductsExist(int id, decimal amount)
        {
            return db.ProductAmounts.Where(s => s.ProductId == id).First().Amount >= amount;
        }

        public decimal GetProductAmountDecimal(int id)
        {
            return db.ProductAmounts.Find(id).Amount ?? 0;
        }

        public bool PutProductAmountDecimal(int id, decimal amount)
        {
            ProductAmount pa = db.ProductAmounts.Find(id);
            decimal newAmount = (pa.Amount ?? 0) + amount;
            pa.Amount = newAmount;
            db.SaveChanges();
            return true;
        }

        public bool PutProductName(string name, decimal amount)
        {
            ProductsController pc = new ProductsController();
            int id = pc.GetIdByName(name);
            decimal oldAmount = ((GetProductAmount(id)) as OkNegotiatedContentResult<ProductAmount>).Content.Amount ?? 0;
            int result = db.Database.ExecuteSqlCommand("UPDATE[IceCreamShop_Warehouse].[dbo].[ProductAmount] SET Amount = " + (amount + oldAmount) + "WHERE ProductId = " + id);
            return result == -1 ? false : true;
        }
    }
}