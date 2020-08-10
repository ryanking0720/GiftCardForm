using System;
using System.ComponentModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.IO;

namespace GiftCardForm.DocumentLibrary
{
    [ToolboxItemAttribute(false)]
    public class DocumentLibrary : WebPart
    {

        private FileUpload fileUpload = new FileUpload();  
        private Button btnUpload = new Button();  
  
        private string docLibrary;  
  
        [WebBrowsable, Personalizable]  
        public string DocLibrary  
        {  
            get  
            {  
                return docLibrary;  
            }  
            set  
            {  
                docLibrary = value;  
            }  
        }  
        protected override void CreateChildControls()  
        {  
            Controls.Add(fileUpload);  
            Controls.Add(btnUpload);  
  
            btnUpload.Text = "Upload";  
            btnUpload.Click += new EventHandler(OnUploadClick);  
        }  
        void OnUploadClick(object sender, EventArgs e)  
        {  
            SPList docLibrary;  
            try  
            {  
                docLibrary = ValidateList();  
            }  
            catch (Exception ex)  
            {  
                Controls.Add(new LiteralControl(ex.Message));  
                return;  
            }  
            Stream fStream = fileUpload.PostedFile.InputStream;  
            byte[] contents = new byte[fStream.Length];  
            fStream.Read(contents, 0, (int)fStream.Length);  
            fStream.Close();  
  
            SPSecurity.CatchAccessDeniedException = false;  
            try  
            {  
                SPContext.Current.Web.Files.Add(docLibrary.RootFolder.Url + "/" + fileUpload.FileName, contents);  
            }  
            catch (UnauthorizedAccessException)  
            {  
                Controls.Add(new LiteralControl("You are not authorized to upload files to the document library"));  
            }  
        }  
        private SPList ValidateList()  
        {  
            if (string.IsNullOrEmpty(DocLibrary))  
            {  
                throw new Exception("Please edit the webpart and fill the Document Library property!");  
            }  
  
            if (!fileUpload.HasFile)  
            {  
                throw new Exception("Please select a file to upload.");  
            }  
            try  
            {  
                return SPContext.Current.Web.Lists[DocLibrary];  
            }  
            catch (ArgumentException)  
            {  
                throw new Exception("Library not found!");  
            }  
        }
    }
}
