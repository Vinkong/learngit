using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

/// <summary>
/// FtpHelper 的摘要说明
/// </summary>
public class FtpHelper
{



    #region 字段
  public  string ftpURI;
  public string ftpUserID;
  public string ftpServerIP;
  public string ftpPassword;
    public string ftpRemotePath;
    #endregion
	public FtpHelper()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    /// <summary>  
    /// 连接FTP服务器
    /// </summary>  
    /// <param name="FtpServerIP">FTP连接地址</param>  
    /// <param name="FtpRemotePath">指定FTP连接成功后的当前目录, 如果不指定即默认为根目录</param>  
    /// <param name="FtpUserID">用户名</param>  
    /// <param name="FtpPassword">密码</param>  
    public FtpHelper(string FtpServerIP, string FtpRemotePath, string FtpUserID, string FtpPassword)
        {
            ftpServerIP = FtpServerIP;
            ftpRemotePath = FtpRemotePath;
            ftpUserID = FtpUserID;
            ftpPassword = FtpPassword;
            ftpURI = "ftp://" + ftpServerIP + "/" + ftpRemotePath + "/";
        }

    public void Upload(string filename)
    {
        FileInfo fileInf = new FileInfo(filename);
        FtpWebRequest reqFTP;
        reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(ftpURI + fileInf.Name));
        reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
        reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
        reqFTP.KeepAlive = false;
        reqFTP.UseBinary = true;
        reqFTP.ContentLength = fileInf.Length;
        int buffLength = 2048;
        byte[] buff = new byte[buffLength];
        int contentLen;
        FileStream fs = fileInf.OpenRead();
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
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
     
      
}