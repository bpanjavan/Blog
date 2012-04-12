<%@ WebHandler Language="C#" Class="FileUploadCustom_Reader" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Text;
using System.IO;
using System.Xml.Linq;

public class FileUploadCustom_Reader : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string guidString = context.Request.QueryString["guid"];
            XmlDocument xmldocFileRouterPacket = new XmlDocument();
            xmldocFileRouterPacket.Load(context.Server.MapPath("XML/FileRouterPacket.xml"));
            XmlNode xmlnodeFileId = xmldocFileRouterPacket.SelectSingleNode("FileRouterPacket/Body/FileId");
            xmlnodeFileId.InnerText = guidString;

            FileRouter.FileRouterHead fileRouterHead = new FileRouter.FileRouterHead();
            byte[] fileBytes = null;
            string responsePacket = fileRouterHead.FileGet(xmldocFileRouterPacket.OuterXml, out fileBytes);
            xmldocFileRouterPacket.LoadXml(responsePacket);
            XmlNode xmlnodeExtension = xmldocFileRouterPacket.SelectSingleNode("FileRouterPacket/Body/FileExtension");
            string contentType = xmlnodeExtension.InnerText;
            XmlNode xmlnodeFileName = xmldocFileRouterPacket.SelectSingleNode("FileRouterPacket/Body/FileName");
            string fileName = xmlnodeFileName.InnerText;
            
            XDocument xdocContentTypeMap = XDocument.Load(context.Server.MapPath(@"XML\ContentTypeMap.xml"));
            IEnumerable<XElement> xElements = xdocContentTypeMap.Element(XName.Get("ContentTypeMap")).Elements("ContentType");
            var xmlnodelistContentTypesMatch = from xmlnode in xElements
                                               where xmlnode.Attribute(XName.Get("Extension")).Value == contentType.Replace(".", "").ToLower()
                                               select xmlnode;
            context.Response.Clear();
            //if they found the extention in the content type match, set the content type
            if (xmlnodelistContentTypesMatch.Count<XElement>() > 0)
            {
                XElement xmlnodeContentTypeMatch = xmlnodelistContentTypesMatch.First<XElement>();
                context.Response.ContentType = xmlnodeContentTypeMatch.Attribute(XName.Get("ContentTypeValue", string.Empty)).Value;//xmlnodeContentTypeMatch.Attributes["ContentTypeValue"].Value;
            }
            context.Response.AddHeader("Content-Disposition",string.Format("inline; filename=\"{0}\"", fileName));
            //if the file was not found
            if (fileBytes == null)
            {
                context.Response.Write("File not found");
            }
            else
            {

                context.Response.OutputStream.Write(fileBytes, 0, fileBytes.Length);
                context.Response.End();
            }
        }
        catch (Exception ex)
        {
            //context.Response.Write(ex.ToString());
            context.Response.End();
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
