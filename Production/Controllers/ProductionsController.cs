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
    public class ProductionsController : ApiController
    {
        private IceCreamShop_ProductionEntities db = new IceCreamShop_ProductionEntities();

        // GET: api/Productions
        public IQueryable<Production> GetProductions()
        {
            return db.Productions;
        }

        // GET: api/Productions/5
        [ResponseType(typeof(Production))]
        public async Task<IHttpActionResult> GetProduction(int id)
        {
            Production production = await db.Productions.FindAsync(id);
            if (production == null)
            {
                return NotFound();
            }

            return Ok(production);
        }

        // PUT: api/Productions/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutProduction(int id, Production production)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != production.Id)
            {
                return BadRequest();
            }

            db.Entry(production).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductionExists(id))
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

        // POST: api/Productions
        [ResponseType(typeof(Production))]
        public async Task<IHttpActionResult> PostProduction(Production production)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Productions.Add(production);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ProductionExists(production.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = production.Id }, production);
        }

        // DELETE: api/Productions/5
        [ResponseType(typeof(Production))]
        public async Task<IHttpActionResult> DeleteProduction(int id)
        {
            Production production = await db.Productions.FindAsync(id);
            if (production == null)
            {
                return NotFound();
            }

            db.Productions.Remove(production);
            await db.SaveChangesAsync();

            return Ok(production);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ProductionExists(int id)
        {
            return db.Productions.Count(e => e.Id == id) > 0;
        }

        public void NewProduction(string productName, decimal amount)
        {
            db.Productions.Add(new Production()
            {
                Id = db.Productions.Count() + 1,
                Date = DateTime.Now,
                ProductName = productName,
                Amount = amount
            });
            db.SaveChanges();
        }
    }
}