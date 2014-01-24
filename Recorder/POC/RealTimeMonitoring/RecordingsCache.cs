using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RealTimeMonitoring
{
    public class RecordingsCache
    {
        private static RecordingsCache _instance;
        private static object lockObject = new object();
        public List<Recording> Recordings = new List<Recording>();

        public static RecordingsCache GetInstance()
        {
            lock (lockObject)
            {
                if (_instance == null)
                    _instance = new RecordingsCache();
            }

            return _instance;
        }
    }
}
