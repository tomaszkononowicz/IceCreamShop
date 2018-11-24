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
using Production;

namespace Production.Controllers
{
    public class ProduceSagaDataDbsController : ApiController
    {
        private IceCreamShop_ProductionEntities db = new IceCreamShop_ProductionEntities();

        // GET: api/ProduceSagaDataDbs
        public IQueryable<ProduceSagaDataDb> GetProduceSagaDataDbs()
        {
            return db.ProduceSagaDataDbs;
        }

        // GET: api/ProduceSagaDataDbs/5
        [ResponseType(typeof(ProduceSagaDataDb))]
        public IHttpActionResult GetProduceSagaDataDb(Guid id)
        {
            ProduceSagaDataDb produceSagaDataDb = db.ProduceSagaDataDbs.Find(id);
            if (produceSagaDataDb == null)
            {
                return NotFound();
            }

            return Ok(produceSagaDataDb);
        }

        // PUT: api/ProduceSagaDataDbs/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutProduceSagaDataDb(Guid id, ProduceSagaDataDb produceSagaDataDb)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != produceSagaDataDb.ProductionId)
            {
                return BadRequest();
            }

            db.Entry(produceSagaDataDb).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProduceSagaDataDbExists(id))
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

        // POST: api/ProduceSagaDataDbs
        [ResponseType(typeof(ProduceSagaDataDb))]
        public async Task<IHttpActionResult> PostProduceSagaDataDb(ProduceSagaDataDb produceSagaDataDb)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ProduceSagaDataDbs.Add(produceSagaDataDb);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ProduceSagaDataDbExists(produceSagaDataDb.ProductionId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = produceSagaDataDb.ProductionId }, produceSagaDataDb);
        }

        // DELETE: api/ProduceSagaDataDbs/5
        [ResponseType(typeof(ProduceSagaDataDb))]
        public async Task<IHttpActionResult> DeleteProduceSagaDataDb(Guid id)
        {
            ProduceSagaDataDb produceSagaDataDb = await db.ProduceSagaDataDbs.FindAsync(id);
            if (produceSagaDataDb == null)
            {
                return NotFound();
            }

            db.ProduceSagaDataDbs.Remove(produceSagaDataDb);
            await db.SaveChangesAsync();

            return Ok(produceSagaDataDb);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ProduceSagaDataDbExists(Guid id)
        {
            return db.ProduceSagaDataDbs.Count(e => e.ProductionId == id) > 0;
        }
    }
}