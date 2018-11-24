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
using Warehouse;

namespace Warehouse.Controllers
{
    public class SemiFinishedGoodAmountsController : ApiController
    {
        private IceCreamShop_WarehouseEntities db = new IceCreamShop_WarehouseEntities();

        // GET: api/SemiFinishedGoodAmounts
        public IQueryable<SemiFinishedGoodAmount> GetSemiFinishedGoodAmounts()
        {
            return db.SemiFinishedGoodAmounts;
        }

        // GET: api/SemiFinishedGoodAmounts/5
        [ResponseType(typeof(SemiFinishedGoodAmount))]
        public async Task<IHttpActionResult> GetSemiFinishedGoodAmount(int id)
        {
            SemiFinishedGoodAmount semiFinishedGoodAmount = await db.SemiFinishedGoodAmounts.FindAsync(id);
            if (semiFinishedGoodAmount == null)
            {
                return NotFound();
            }

            return Ok(semiFinishedGoodAmount);
        }

        // PUT: api/SemiFinishedGoodAmounts/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutSemiFinishedGoodAmount(int id, SemiFinishedGoodAmount semiFinishedGoodAmount)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != semiFinishedGoodAmount.SemiFinishedGoodId)
            {
                return BadRequest();
            }

            db.Entry(semiFinishedGoodAmount).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SemiFinishedGoodAmountExists(id))
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

        // POST: api/SemiFinishedGoodAmounts
        [ResponseType(typeof(SemiFinishedGoodAmount))]
        public async Task<IHttpActionResult> PostSemiFinishedGoodAmount(SemiFinishedGoodAmount semiFinishedGoodAmount)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.SemiFinishedGoodAmounts.Add(semiFinishedGoodAmount);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SemiFinishedGoodAmountExists(semiFinishedGoodAmount.SemiFinishedGoodId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = semiFinishedGoodAmount.SemiFinishedGoodId }, semiFinishedGoodAmount);
        }

        // DELETE: api/SemiFinishedGoodAmounts/5
        [ResponseType(typeof(SemiFinishedGoodAmount))]
        public async Task<IHttpActionResult> DeleteSemiFinishedGoodAmount(int id)
        {
            SemiFinishedGoodAmount semiFinishedGoodAmount = await db.SemiFinishedGoodAmounts.FindAsync(id);
            if (semiFinishedGoodAmount == null)
            {
                return NotFound();
            }

            db.SemiFinishedGoodAmounts.Remove(semiFinishedGoodAmount);
            await db.SaveChangesAsync();

            return Ok(semiFinishedGoodAmount);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SemiFinishedGoodAmountExists(int id)
        {
            return db.SemiFinishedGoodAmounts.Count(e => e.SemiFinishedGoodId == id) > 0;
        }
        
        public bool CheckIfAmountOfSemiFinishedGoodsExist(string sfg, decimal amount)
        {
            SemiFinishedGoodsController sfgc = new SemiFinishedGoodsController();
            int id = sfgc.GetSemiFinishedGoodId(sfg);
            return db.SemiFinishedGoodAmounts.Where(s => s.SemiFinishedGoodId == id).First().Amount >= amount;
        }

        public decimal GetSemiFinishedGoodAmountDecimal(int id)
        {
            return db.SemiFinishedGoodAmounts.Find(id).Amount ?? 0;
        }

        public bool PutSemiFinishedGoodAmountDecimal(int id, decimal amount)
        {
            SemiFinishedGoodAmount sfga = db.SemiFinishedGoodAmounts.Find(id);
            decimal newAmount = (sfga.Amount ?? 0) + amount;
            sfga.Amount = newAmount;
            db.SaveChanges();
            return true;
        }
    }
}