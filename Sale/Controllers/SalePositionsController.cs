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
    public class SalePositionsController : ApiController
    {
        private IceCreamShop_SaleEntities db = new IceCreamShop_SaleEntities();

        // GET: api/SalePositions
        public IQueryable<SalePosition> GetSalePositions()
        {
            return db.SalePositions;
        }

        // GET: api/SalePositions/5
        [ResponseType(typeof(SalePosition))]
        public async Task<IHttpActionResult> GetSalePosition(int id)
        {
            SalePosition salePosition = await db.SalePositions.FindAsync(id);
            if (salePosition == null)
            {
                return NotFound();
            }

            return Ok(salePosition);
        }

        // PUT: api/SalePositions/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutSalePosition(int id, SalePosition salePosition)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != salePosition.SaleId)
            {
                return BadRequest();
            }

            db.Entry(salePosition).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SalePositionExists(id))
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

        // POST: api/SalePositions
        [ResponseType(typeof(SalePosition))]
        public async Task<IHttpActionResult> PostSalePosition(SalePosition salePosition)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.SalePositions.Add(salePosition);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SalePositionExists(salePosition.SaleId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = salePosition.SaleId }, salePosition);
        }

        // DELETE: api/SalePositions/5
        [ResponseType(typeof(SalePosition))]
        public async Task<IHttpActionResult> DeleteSalePosition(int id)
        {
            SalePosition salePosition = await db.SalePositions.FindAsync(id);
            if (salePosition == null)
            {
                return NotFound();
            }

            db.SalePositions.Remove(salePosition);
            await db.SaveChangesAsync();

            return Ok(salePosition);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SalePositionExists(int id)
        {
            return db.SalePositions.Count(e => e.SaleId == id) > 0;
        }
    }
}