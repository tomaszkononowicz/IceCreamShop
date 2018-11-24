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
    public class SemiFinishedGoodsController : ApiController
    {
        private IceCreamShop_WarehouseEntities db = new IceCreamShop_WarehouseEntities();

        [HttpPost]
        public async Task<IHttpActionResult> AddOrUpdate(Order order)
        {
            SemiFinishedGood semiFinishedGood = this.GetSemiFinishedGoods().Where(p => p.Name.Equals(order.Name)).FirstOrDefault();
            decimal amount;
            try
            {
                amount = decimal.Parse(order.Amount);
            }
            catch (Exception e)
            {
                return BadRequest();
            }
            if (semiFinishedGood != null)
            {
                SemiFinishedGoodAmountsController pac = new SemiFinishedGoodAmountsController();
                decimal oldAmount = (await (pac.GetSemiFinishedGoodAmount(semiFinishedGood.Id)) as OkNegotiatedContentResult<SemiFinishedGoodAmount>).Content.Amount ?? 0;
                db.Database.ExecuteSqlCommand("UPDATE[IceCreamShop_Warehouse].[dbo].[SemiFinishedGoodAmount] SET Amount = " + (amount + oldAmount) + "WHERE SemiFinishedGoodId = " + semiFinishedGood.Id);
            }
            else
            {
                int newId = this.GetSemiFinishedGoods().Count() + 1;
                SemiFinishedGood newSemiFinishedGood = new SemiFinishedGood() { Id = newId, Name = order.Name };
                SemiFinishedGoodAmount pa = new SemiFinishedGoodAmount { SemiFinishedGoodId = newSemiFinishedGood.Id, Amount = amount };
                SemiFinishedGoodAmountsController pac = new SemiFinishedGoodAmountsController();
                await pac.PostSemiFinishedGoodAmount(pa);
                db.Database.ExecuteSqlCommand("INSERT INTO [IceCreamShop_Warehouse].[dbo].[SemiFinishedGood] VALUES (" + newSemiFinishedGood.Id + ", '" + order.Name + "')");
            }

            return Ok();
        }

        // GET: api/SemiFinishedGoods
        public IQueryable<SemiFinishedGood> GetSemiFinishedGoods()
        {
            return db.SemiFinishedGoods;
        }

        // GET: api/SemiFinishedGoods/5
        [ResponseType(typeof(SemiFinishedGood))]
        public async Task<IHttpActionResult> GetSemiFinishedGood(int id)
        {
            SemiFinishedGood semiFinishedGood = await db.SemiFinishedGoods.FindAsync(id);
            if (semiFinishedGood == null)
            {
                return NotFound();
            }

            return Ok(semiFinishedGood);
        }

        // PUT: api/SemiFinishedGoods/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutSemiFinishedGood(int id, SemiFinishedGood semiFinishedGood)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != semiFinishedGood.Id)
            {
                return BadRequest();
            }

            db.Entry(semiFinishedGood).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SemiFinishedGoodExists(id))
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

        // POST: api/SemiFinishedGoods
        [ResponseType(typeof(SemiFinishedGood))]
        public async Task<IHttpActionResult> PostSemiFinishedGood(SemiFinishedGood semiFinishedGood)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.SemiFinishedGoods.Add(semiFinishedGood);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SemiFinishedGoodExists(semiFinishedGood.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = semiFinishedGood.Id }, semiFinishedGood);
        }

        // DELETE: api/SemiFinishedGoods/5
        [ResponseType(typeof(SemiFinishedGood))]
        public async Task<IHttpActionResult> DeleteSemiFinishedGood(int id)
        {
            db.Database.ExecuteSqlCommand("DELETE FROM [IceCreamShop_Warehouse].[dbo].[SemiFinishedGood] WHERE Id =" + id);
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

        private bool SemiFinishedGoodExists(int id)
        {
            return db.SemiFinishedGoods.Count(e => e.Id == id) > 0;
        }

        public int GetSemiFinishedGoodId(string name)
        {
            return db.SemiFinishedGoods.Where(sfg => sfg.Name == name).First().Id;
        }
    }
}