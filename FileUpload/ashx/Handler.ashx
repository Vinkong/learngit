<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
          
       string ftpUserID ="kfz";
       string ftpServerIP = "192.168.0.102";
       string ftpPassword ="kfz123456";
       string ftpRemotePath ="test";

      string   ftpURI = "ftp://" + ftpServerIP + "/" + ftpRemotePath + "/";
        HttpFileCollection files = context.Request.Files;

        if (files.Count > 0)
        {
            HttpPostedFile fileInf = files[0];
            FtpWebRequest reqFTP;
            reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(ftpURI + fileInf.FileName));
            reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
            reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
            reqFTP.KeepAlive = false;
            reqFTP.UseBinary = true;
            reqFTP.ContentLength = fileInf.ContentLength;
            int buffLength = 2048;
            byte[] buff = new byte[buffLength];
            int contentLen;
            Stream fs = fileInf.InputStream;
            try
            {
                Stream strm = reqFTP.GetRequestStream();
                contentLen = fs.Read(buff, 0, buffLength);
                while (contentLen != 0)
                {
                    strm.Write(buff, 0, contentLen);
                    contentLen = fs.Read(buff, 0, buffLength);
                }
                strm.Close();
                fs.Close();
                context.Response.Write(fileInf.FileName);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}