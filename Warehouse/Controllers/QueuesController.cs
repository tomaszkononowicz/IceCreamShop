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
    public class QueuesController : ApiController
    {
        private IceCreamShop_WarehouseEntities db = new IceCreamShop_WarehouseEntities();

        // GET: api/Queues
        public IQueryable<Queue> GetQueues()
        {
            return db.Queues;
        }

        // GET: api/Queues/5
        [ResponseType(typeof(Queue))]
        public IHttpActionResult GetQueue(int id)
        {
            Queue queue = db.Queues.Find(id);
            if (queue == null)
            {
                return NotFound();
            }

            return Ok(queue);
        }

        // PUT: api/Queues/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutQueue(int id, Queue queue)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != queue.MsgId)
            {
                return BadRequest();
            }

            db.Entry(queue).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QueueExists(id))
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

        // POST: api/Queues
        [ResponseType(typeof(Queue))]
        public async Task<IHttpActionResult> PostQueue(Queue queue)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Queues.Add(queue);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (QueueExists(queue.MsgId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = queue.MsgId }, queue);
        }

        // DELETE: api/Queues/5
        [ResponseType(typeof(Queue))]
        public async Task<IHttpActionResult> DeleteQueue(int id)
        {
            Queue queue = await db.Queues.FindAsync(id);
            if (queue == null)
            {
                return NotFound();
            }

            db.Queues.Remove(queue);
            await db.SaveChangesAsync();

            return Ok(queue);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool QueueExists(int id)
        {
            return db.Queues.Count(e => e.MsgId == id) > 0;
        }
    }
}