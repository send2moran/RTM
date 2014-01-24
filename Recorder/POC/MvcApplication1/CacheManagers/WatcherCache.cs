using Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CacheManagers
{
    public class WatcherCache
    {
        private static WatcherCache _instance;
        private static object lockObject = new object();
        private static List<LocationWatcher> Locations = new List<LocationWatcher>();

        private WatcherCache() { }

        public static WatcherCache GetInstance()
        {
            lock (lockObject)
            {
                if (_instance == null)
                    _instance = new WatcherCache();
            }

            return _instance;
        }

        public void SetWatch(string Location, DateTime ExpireDate)
        {
            LocationWatcher locationWatcher = GetLocationWatcher(Location);

            if (locationWatcher == null)
            {
                locationWatcher = new LocationWatcher {
                    Location = Location
                };

                Locations.Add(locationWatcher);
            }

            locationWatcher.ExpireDate = ExpireDate;
        }

        private LocationWatcher GetLocationWatcher(string Location)
        {
            return Locations.FirstOrDefault(l => l.Location == Location);
        }

        public bool IsWatching(string Location)
        {
            LocationWatcher locationWatcher = GetLocationWatcher(Location);

            if (locationWatcher == null)
                return false;

            if (locationWatcher.ExpireDate < DateTime.Now)
                Locations.Remove(locationWatcher);

            return true;
        }

        public bool IsCached(string Location)
        {
            LocationWatcher locationWatcher = GetLocationWatcher(Location);

            if (locationWatcher == null)
                return false;

            if (locationWatcher.HTMLCacheLocation == null)
                return false;

            return locationWatcher.HTMLCacheLocation.Length > 0;
        }
    }
}
