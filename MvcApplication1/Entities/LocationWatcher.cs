using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Entities
{
    public class LocationWatcher
    {
        public DateTime ExpireDate { get; set; }
        public string Location { get; set; }
        public string HTMLCacheLocation { get; set; }
    }
}