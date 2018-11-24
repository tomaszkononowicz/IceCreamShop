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
using Sale;

namespace Sale.Controllers
{
    public class SemiFinishedGoodsController : ApiController
    {
        private IceCreamShop_SaleEntities db = new IceCreamShop_SaleEntities();

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
            SemiFinishedGood semiFinishedGood = await db.SemiFinishedGoods.FindAsync(id);
            if (semiFinishedGood == null)
            {
                return NotFound();
            }

            db.SemiFinishedGoods.Remove(semiFinishedGood);
            await db.SaveChangesAsync();

            return Ok(semiFinishedGood);
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
    }
}