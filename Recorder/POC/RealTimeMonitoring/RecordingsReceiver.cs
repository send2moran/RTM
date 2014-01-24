using System;
using System.Web;

namespace RealTimeMonitoring
{
    public class RecordingsReceiver : IHttpHandler
    {
        /// <summary>
        /// You will need to configure this handler in the Web.config file of your 
        /// web and register it with IIS before being able to use it. For more information
        /// see the following link: http://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpHandler Members

        public bool IsReusable
        {
            // Return false in case your Managed Handler cannot be reused for another request.
            // Usually this would be false in case you have some state information preserved per request.
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            var qs = context.Request.QueryString;
            int MouseX, MouseY;
            bool IsClicked;
            string Location;

            if (!int.TryParse(qs["MouseX"], out MouseX))
            {
                throw new ArgumentNullException("MouseX");
            }

            if (!int.TryParse(qs["MouseY"], out MouseY))
            {
                throw new ArgumentNullException("MouseY");
            }

            if (!bool.TryParse(qs["IsClicked"], out IsClicked))
            {
                throw new ArgumentNullException("IsClicked");
            }

            Location = context.Request.Url.AbsoluteUri;

            RecordingsCache recordingsCache = RecordingsCache.GetInstance();
            recordingsCache.Recordings.Add(new Recording
            {
                IsClick = IsClicked,
                MouseX = MouseX,
                MouseY = MouseY,
                Location = Location
            });

        }

        #endregion
    }
}
