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
    public class SaleSagaDataDbsController : ApiController
    {
        private IceCreamShop_SaleEntities db = new IceCreamShop_SaleEntities();

        // GET: api/SaleSagaDataDbs
        public IQueryable<SaleSagaDataDb> GetSaleSagaDataDbs()
        {
            return db.SaleSagaDataDbs;
        }

        // GET: api/SaleSagaDataDbs/5
        [ResponseType(typeof(SaleSagaDataDb))]
        public IHttpActionResult GetSaleSagaDataDb(Guid id)
        {
            SaleSagaDataDb saleSagaDataDb = db.SaleSagaDataDbs.Find(id);
            if (saleSagaDataDb == null)
            {
                return NotFound();
            }

            return Ok(saleSagaDataDb);
        }

        // PUT: api/SaleSagaDataDbs/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutSaleSagaDataDb(Guid id, SaleSagaDataDb saleSagaDataDb)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != saleSagaDataDb.SaleId)
            {
                return BadRequest();
            }

            db.Entry(saleSagaDataDb).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SaleSagaDataDbExists(id))
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

        // POST: api/SaleSagaDataDbs
        [ResponseType(typeof(SaleSagaDataDb))]
        public async Task<IHttpActionResult> PostSaleSagaDataDb(SaleSagaDataDb saleSagaDataDb)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.SaleSagaDataDbs.Add(saleSagaDataDb);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SaleSagaDataDbExists(saleSagaDataDb.SaleId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = saleSagaDataDb.SaleId }, saleSagaDataDb);
        }

        // DELETE: api/SaleSagaDataDbs/5
        [ResponseType(typeof(SaleSagaDataDb))]
        public async Task<IHttpActionResult> DeleteSaleSagaDataDb(Guid id)
        {
            SaleSagaDataDb saleSagaDataDb = await db.SaleSagaDataDbs.FindAsync(id);
            if (saleSagaDataDb == null)
            {
                return NotFound();
            }

            db.SaleSagaDataDbs.Remove(saleSagaDataDb);
            await db.SaveChangesAsync();

            return Ok(saleSagaDataDb);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SaleSagaDataDbExists(Guid id)
        {
            return db.SaleSagaDataDbs.Count(e => e.SaleId == id) > 0;
        }
    }
}