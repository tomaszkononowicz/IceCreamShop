﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Production
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class IceCreamShop_ProductionEntities : DbContext
    {
        public IceCreamShop_ProductionEntities()
            : base("name=IceCreamShop_ProductionEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Production> Productions { get; set; }
        public virtual DbSet<Recipe> Recipes { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<SemiFinishedGood> SemiFinishedGoods { get; set; }
        public virtual DbSet<Queue> Queues { get; set; }
        public virtual DbSet<ProduceSagaDataDb> ProduceSagaDataDbs { get; set; }
    }
}