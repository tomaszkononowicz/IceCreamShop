﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Warehouse
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class IceCreamShop_WarehouseEntities : DbContext
    {
        public IceCreamShop_WarehouseEntities()
            : base("name=IceCreamShop_WarehouseEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<ProductAmount> ProductAmounts { get; set; }
        public virtual DbSet<SemiFinishedGoodAmount> SemiFinishedGoodAmounts { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<SemiFinishedGood> SemiFinishedGoods { get; set; }
        public virtual DbSet<Queue> Queues { get; set; }
    }
}
