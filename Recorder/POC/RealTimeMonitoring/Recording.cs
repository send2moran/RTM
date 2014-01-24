using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RealTimeMonitoring
{
    public class Recording
    {
        public string Location { get; set; }
        public int MouseX { get; set; }
        public int MouseY { get; set; }
        public bool IsClick { get; set; }
    }
}
