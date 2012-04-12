using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
using FileRouter.Business;
using FileRouter.Data;
using System.Text;

/// <summary>
/// Summary description for FileRouter
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class FileRouterHead : System.Web.Services.WebService
{

    public FileRouterHead()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string DeleteAll(string filePacket)
    {
        XmlDocument xmldocFilePacket = new XmlDocument();
        try
        {
            xmldocFilePacket.LoadXml(filePacket);

            FileRouter.Data.FileDataAdapter.DeleteAll();
            
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Status").InnerText = "SUCCESS";
        }
        catch (Exception ex)
        {
            xmldocFilePacket.Load(Server.MapPath("FileRouterPacket.xml"));
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Status").InnerText = "ERROR";
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Message").InnerText = ex.ToString();
        }
        return xmldocFilePacket.OuterXml;
    }

    [WebMethod]
    public string FileSave(string filePacket, byte[] fileBytes)
    {
        XmlDocument xmldocFilePacket = new XmlDocument();      
        try
        {
            xmldocFilePacket.LoadXml(filePacket);
            XmlNode xmlnodeBody = xmldocFilePacket.SelectSingleNode("FileRouterPacket/Body");
            FileRouter.Business.IFileData fData = FileRouter.Business.FileDataFactory.ReturnNewFileData();
            fData.FileID = Guid.NewGuid();
            ASCIIEncoding fileBytesEncoding = new ASCIIEncoding();
            fData.FileBytes = fileBytes;//fileBytesEncoding.GetBytes(xmlnodeBody.SelectSingleNode("FileBytes").InnerText);
            fData.FileName = xmlnodeBody.SelectSingleNode("FileName").InnerText;
            fData.FileExtension = xmlnodeBody.SelectSingleNode("FileExtension").InnerText;
            fData.CreatedOn = DateTime.Parse(xmlnodeBody.SelectSingleNode("CreatedOn").InnerText);
            fData.CreatedBy = xmlnodeBody.SelectSingleNode("CreatedBy").InnerText;
            fData.ModifiedOn = DateTime.Parse(xmlnodeBody.SelectSingleNode("ModifiedOn").InnerText);
            fData.ModifiedBy = xmlnodeBody.SelectSingleNode("ModifiedBy").InnerText;

            FileRouter.Data.FileDataAdapter.Insert(fData);
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Body/FileId").InnerText = fData.FileID.ToString();
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Status").InnerText = "SUCCESS";
        }
        catch (Exception ex)
        {
            xmldocFilePacket.Load(Server.MapPath("FileRouterPacket.xml"));
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Status").InnerText = "ERROR";
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Message").InnerText = ex.ToString();
        }
        return xmldocFilePacket.OuterXml;
    }

    [WebMethod]
    public string FileGet(string filePacket, out byte[] fileBytes)
    {
        fileBytes = null;
        XmlDocument xmldocFilePacket = new XmlDocument();
        try
        {
            xmldocFilePacket.LoadXml(filePacket);
            XmlNode xmlnodeBody = xmldocFilePacket.SelectSingleNode("FileRouterPacket/Body");
            Guid fileId = new Guid(xmlnodeBody.SelectSingleNode("FileId").InnerText);
            FileRouter.Business.IFileData fData = FileRouter.Business.FileDataFactory.ReturnNewFileData();
            fData.FileID = fileId;
            fData = FileRouter.Data.FileDataAdapter.GetOne(fData);
            Decoder byteDecoder = Encoding.UTF8.GetDecoder();
            char[] fileChars = new char[fData.FileBytes.Length];
            int bytesUsed = 0;
            int charsUsed = 0;
            bool completed = false;
            byteDecoder.Convert(fData.FileBytes, 0, fData.FileBytes.Length, fileChars, 0, fData.FileBytes.Length, true, out bytesUsed, out charsUsed, out completed);
            string fileString = new string(fileChars);
            fileBytes = fData.FileBytes;
            //xmlnodeBody.SelectSingleNode("FileBytes").InnerText = fileString;
            xmlnodeBody.SelectSingleNode("FileName").InnerText = fData.FileName;
            xmlnodeBody.SelectSingleNode("FileExtension").InnerText = fData.FileExtension;
            xmlnodeBody.SelectSingleNode("CreatedOn").InnerText = fData.CreatedOn.ToString();
            xmlnodeBody.SelectSingleNode("CreatedBy").InnerText = fData.CreatedBy;
            xmlnodeBody.SelectSingleNode("ModifiedOn").InnerText = fData.ModifiedOn.ToString();
            xmlnodeBody.SelectSingleNode("ModifiedBy").InnerText = fData.ModifiedBy;

            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Status").InnerText = "SUCCESS";
        }
        catch (Exception ex)
        {
            xmldocFilePacket.Load(Server.MapPath("FileRouterPacket.xml"));
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Status").InnerText = "ERROR";
            xmldocFilePacket.SelectSingleNode("FileRouterPacket/Head/Message").InnerText = ex.ToString();
        }
        return xmldocFilePacket.OuterXml;
    }

}

