using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using CacheManagers;
using Entities;
using Attributes;

namespace RTM.Controllers
{
    public class RecordingsController : Controller
    {
        public JsonResult Pull(string Location)
        {
            RecordingsCache recordingsCache = RecordingsCache.GetInstance();
            WatcherCache watcherCache = WatcherCache.GetInstance();

            List<Recording> recordings = recordingsCache.Recordings.Where(r => r.Location == Location).ToList().GetRange(0, recordingsCache.Recordings.Count);

            JsonResult jsonResult = Json(recordings, JsonRequestBehavior.AllowGet);

            recordingsCache.Recordings.Clear();

            watcherCache.SetWatch(Location, DateTime.Now.AddSeconds(2));

            return jsonResult;
        }

        [AllowCrossSiteJsonAttribute]
        public JsonResult Receive(Recording recording)
        {
            WatcherCache watcherCache = WatcherCache.GetInstance();
            ReceiveJsonResult jsonResult = new ReceiveJsonResult();

            if (Request.UrlReferrer == null)
                return Json(new { }, JsonRequestBehavior.AllowGet);

            recording.Location = Request.UrlReferrer.AbsoluteUri;

            ValidateModel(recording);

            jsonResult.IsWatching = watcherCache.IsWatching(recording.Location);
            jsonResult.IsCached = watcherCache.IsCached(recording.Location);
            jsonResult.UID = recording.UID;

            if (!jsonResult.IsWatching)
            {
                return Json(jsonResult, JsonRequestBehavior.AllowGet);
            }

            if (recording.UID == 0)
            {
                recording.UID = new Random().Next(1, 99999999);
                jsonResult.UID = recording.UID;
            }

            RecordingsCache recordingsCache = RecordingsCache.GetInstance();
            recordingsCache.Recordings.Add(recording);

            return Json(jsonResult, JsonRequestBehavior.AllowGet);
        }

        [AllowCrossSiteJson]
        public JsonResult UploadPage(string HTML)
        {
            byte[] data = Convert.FromBase64String(HTML);
            var t = DecompressDeflateBytes(data);
            var b = Encoding.UTF8.GetString(t);
            return Json(new { }, JsonRequestBehavior.AllowGet);
        }

        private byte[] DecompressDeflateBytes(byte[] deflateOutput)
        {
            using (MemoryStream retval = new MemoryStream())
            using (DeflateStream deflateStream = new DeflateStream(new MemoryStream(deflateOutput), CompressionMode.Decompress, false))
            {
                CopyStreamContents(deflateStream, retval, null, true);
                return retval.ToArray();
            }
        }

        public static void CopyStreamContents(Stream inStream, Stream outStream, int? bufferSize, bool inputStreamSeekOrigin)
        {
            byte[] buffer = new byte[bufferSize ?? 4096];		// buffer size defaults to 4K

            // Reset input stream pointer (if asked and cursor positioning is supported)
            if (inputStreamSeekOrigin && inStream.CanSeek)
                inStream.Seek(0, SeekOrigin.Begin);
            while (true)
            {
                int bytesRead = inStream.Read(buffer, 0, buffer.Length);
                if (bytesRead <= 0)
                    break;
                outStream.Write(buffer, 0, bytesRead);
            }
        }

        private byte[] GetBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }

        private string Inflate(byte[] input)
        {
            string resultString = "";
            using (MemoryStream outStream = new MemoryStream())
            using (MemoryStream inStream = new MemoryStream(input))
            using (DeflateStream ds = new DeflateStream(inStream, CompressionMode.Decompress, true))
            {
                int bytesRead = 1;
                while (ds.CanRead && bytesRead > 0)
                {
                    const int CHUNK_SIZE = 4096;
                    byte[] buf = new byte[CHUNK_SIZE];
                    bytesRead = ds.Read(buf, 0, buf.Length);
                    outStream.Write(buf, 0, bytesRead);
                }
                resultString = Encoding.UTF8.GetString(outStream.ToArray());
            }
            return resultString;
        }

        public class ReceiveJsonResult
        {
            public int UID { get; set; }
            public bool IsWatching { get; set; }
            public bool IsCached { get; set; }
        }

    }
}
