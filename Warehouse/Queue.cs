//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Queue
    {
        public int MsgId { get; set; }
        public string Command { get; set; }
        public string Msg { get; set; }
        public Nullable<System.Guid> CorrelationId { get; set; }
    }
}
