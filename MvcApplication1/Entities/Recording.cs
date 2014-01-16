using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
    public class Recording
    {
        public int UID { get; set; }
        public string Location { get; set; }
        public int MouseX { get; set; }
        public int MouseY { get; set; }
        public bool IsClick { get; set; }
    }
}
