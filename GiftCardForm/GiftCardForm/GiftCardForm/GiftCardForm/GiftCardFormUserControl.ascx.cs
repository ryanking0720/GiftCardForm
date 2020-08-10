using System;
using System.Data;
using System.DirectoryServices;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.Utilities;
using AjaxControlToolkit;
/*
 Project: Gift Card Form 
 
 Author: Ryan King
 
 Date: August 12, 2019
 
 Purpose: This program allows the user to submit up to 10 gift card applications.
 All applications can be sent to different users, but will all contain the same
 email address and username, as well as a hidden field for who created them.
 If ther user makes a mistake, a label will appear up at the top to indicate to
 him/her what mistake(s) s/he made and then the user will have a chance to 
 correct the application. If no errors exist, the label will say "Success!" and the
 submitted application will appear on a table in a dynamic pill.
  
 Any user will have access to a dynamic pill containing a table filled with his/her own applications
 but will not be allowed to see anyone else's.
 
 The owners of the form (Full Control) will have access to all applications submitted by all users,
 as well as the hidden "Created By", "Unique ID", and "Timestamp" fields. This table appears at the top.
 The owner will still not be able to change the Unique ID, Timestamp, or Created By fields; these are for
 bookkeeping purposes and are read-only.
 The owner can also fill in information pertaining to purchasing the gift card, which includes the
 vendor received from, date received, person given to, date given, etc. on a lower table.
 
 All applications use unique IDs, which are set at the
 time of submission and cannot be changed. They are formatted as such:
 YYYYMMDDHHMMSSII, where YYYY refers to the year, MM refers to the month,
 DD refers to the date, HH refers to the hour in 24-hour time, MM refers to minutes,
 and SS refers to seconds.
 II can be a number from 1 to 10, formatted 01 to 10, depending on which application
 it was. 
 */
namespace GiftCardForm.GiftCardForm
{
    public partial class GiftCardFormUserControl : System.Web.UI.UserControl
    {
        // Keeps track of the current website
        Guid guidSite = SPContext.Current.Site.ID;
        Guid guidWeb = SPContext.Current.Web.ID;

        // An internal timestamp representing when this request was made. Only visible to admins.
        DateTime timestamp;

        // Data table with only this user's submissions
        DataTable dt;

        // Data table with every user's submissions, visible only to Site Owners.
        DataTable alldtTop;

        // Data table with purchase/delivery information, visible only to Site Owners.
        DataTable alldtBottom;

        // Code that was here before I started working on this. Serves no purpose.
        public class LookUpJunkRemoval
        {
            public string ParseLookUpItem(object obj)
            {
                if (obj != null && !String.IsNullOrEmpty(obj.ToString()))
                {
                    return obj.ToString().Split(new string[] { ";#" }, StringSplitOptions.RemoveEmptyEntries)[1];
                }
                else
                {
                    return obj.ToString().Replace(";#", "");
                }
            }
        }

        // Uploads the file to SharePoint by filename, content, and library name.
        // Returns the link to the file in SharePoint on success and null on failure.
        protected string LinkFile(string name, string content, string library)
        {
            try
            {
                SPSite site = new SPSite(guidSite);
                SPWeb web = site.OpenWeb();

                web.AllowUnsafeUpdates = true;

                if (content != null)
                {
                    // Convert the content back into a byte array
                    byte[] fileContents = Convert.FromBase64String(content);
                    // Get the URL
                    string destUrl = SPContext.Current.Site.Url + "/" + library + "/" + name;
                    // Add the file to SharePoint
                    web.Files.Add(destUrl, fileContents, true);
                    // Return the URL
                    return destUrl;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        // This parses the date into a string.
        // It returns the date as a string in the form "MM/DD/YYY" on success, or null on error.
        protected string ParseDate(string date)
        {
            // Isolate each number
            string[] dateParts = date.Split('/');
            int[] integers = new int[3];

            for (int i = 0; i < 3; i++)
            {
                if (!int.TryParse(dateParts[i], out integers[i]))
                {
                    return null;
                }
            }

            // Construct a new DateTime object that will give us the time as of now
            DateTime now = DateTime.Now;

            DateTime dateTime = new DateTime(integers[2], integers[0], integers[1], now.Hour, now.Minute, now.Second);

            return dateTime.ToShortDateString();
        }

        // This loads requests from all users, and can only be viewed by users with Full Control.
        protected void LoadAllRequests(SPSite _SPSite, SPWeb _SPweb, SPList _SPlist)
        {
            // Generate DataTables to hold all of the information
            alldtTop = new DataTable();
            alldtBottom = new DataTable();

            SPListItemCollection AllCollection = _SPlist.GetItems();

            // Add the appropriate columns to the top DataTable
            alldtTop.Columns.Add("UniqueID", typeof(string));
            alldtTop.Columns.Add("Timestamp", typeof(string));
            alldtTop.Columns.Add("Created By", typeof(string));
            alldtTop.Columns.Add("EmailAddress", typeof(string));
            alldtTop.Columns.Add("RequesterName", typeof(string));
            alldtTop.Columns.Add("RecipientName", typeof(string));
            alldtTop.Columns.Add("RecipientStatus", typeof(string));
            alldtTop.Columns.Add("Branch", typeof(string));
            alldtTop.Columns.Add("ReceivedSixHundred", typeof(string));
            alldtTop.Columns.Add("W9", typeof(string));
            alldtTop.Columns.Add("GiftCardAmount", typeof(string));
            alldtTop.Columns.Add("GiftCardType", typeof(string));
            alldtTop.Columns.Add("Purpose", typeof(string));
            alldtTop.Columns.Add("ApprovedBy", typeof(string));
            alldtTop.Columns.Add("ApprovalDocument", typeof(string));
            alldtTop.Columns.Add("StreetAddress", typeof(string));
            alldtTop.Columns.Add("ApartmentNumber", typeof(string));
            alldtTop.Columns.Add("City", typeof(string));
            alldtTop.Columns.Add("State", typeof(string));
            alldtTop.Columns.Add("ZIPCode", typeof(string));
            alldtTop.Columns.Add("DateNeededBy", typeof(string));
            alldtTop.Columns.Add("Status", typeof(string));

            // Add the appropriate columns to the bottom DataTable
            alldtBottom.Columns.Add("VendorPurchasedFrom", typeof(string));
            alldtBottom.Columns.Add("DatePurchased", typeof(string));
            alldtBottom.Columns.Add("PurchasedBy", typeof(string));
            alldtBottom.Columns.Add("GiftCardSerialNumber", typeof(string));
            alldtBottom.Columns.Add("DateGiven", typeof(string));
            alldtBottom.Columns.Add("PersonGivenTo", typeof(string));
            alldtBottom.Columns.Add("DateInfoSentToPayroll", typeof(string));
            alldtBottom.Columns.Add("W9Received", typeof(string));
            alldtBottom.Columns.Add("Notes", typeof(string));

            // Do not proceed if the collection does not point to anything or is empty
            if (AllCollection != null && AllCollection.Count > 0)
            {
                // Change the label to indicate there is at least one request
                allrequestslabel.Text = "Here are all of the gift card requests by all users:";
                foreach (SPListItem item in AllCollection)//SPException
                {
                    // Assign a new entry to the top DataTable
                    DataRow drTop = alldtTop.NewRow();

                    // Parse all fields into the table
                    drTop["UniqueID"] = item["UniqueID"];
                    drTop["Timestamp"] = item["Timestamp"];
                    drTop["Created By"] = item["Created By"];
                    drTop["EmailAddress"] = item["EmailAddress"];
                    drTop["RequesterName"] = item["RequesterName"];
                    drTop["RecipientName"] = item["RecipientName"];
                    drTop["RecipientStatus"] = item["RecipientStatus"];
                    drTop["Branch"] = item["Branch"];
                    drTop["ReceivedSixHundred"] = item["ReceivedSixHundred"];
                    drTop["W9"] = item["W9"];
                    drTop["GiftCardAmount"] = String.Format("{0:C}", item["GiftCardAmount"]);
                    drTop["GiftCardType"] = item["GiftCardType"];
                    drTop["Purpose"] = item["Purpose"];
                    drTop["ApprovedBy"] = item["ApprovedBy"];
                    drTop["ApprovalDocument"] = item["ApprovalDocument"];
                    drTop["StreetAddress"] = item["StreetAddress"];
                    drTop["ApartmentNumber"] = item["ApartmentNumber"];
                    drTop["City"] = item["City"];
                    drTop["State"] = item["State"];
                    drTop["ZIPCode"] = item["ZIPCode"];
                    drTop["DateNeededBy"] = item["DateNeededBy"];
                    drTop["Status"] = item["Status"];

                    // Assign a new entry to the bottom DataTable
                    DataRow drBottom = alldtBottom.NewRow();

                    // Parse all fields into a table
                    drBottom["VendorPurchasedFrom"] = item["VendorPurchasedFrom"];
                    drBottom["DatePurchased"] = item["DatePurchased"];
                    drBottom["PurchasedBy"] = item["PurchasedBy"];
                    drBottom["GiftCardSerialNumber"] = item["GiftCardSerialNumber"];
                    drBottom["DateGiven"] = item["DateGiven"];
                    drBottom["PersonGivenTo"] = item["PersonGivenTo"];
                    drBottom["DateInfoSentToPayroll"] = item["DateInfoSentToPayroll"];
                    drBottom["W9Received"] = item["W9Received"];
                    drBottom["Notes"] = item["Notes"];

                    // Add both rows to their respective tables
                    alldtTop.Rows.Add(drTop);
                    alldtBottom.Rows.Add(drBottom);
                }

                // Make sure the critical fields are read-only
                alldtTop.Columns["UniqueID"].ReadOnly = true;
                alldtTop.Columns["Timestamp"].ReadOnly = true;

                // Assign and bind the data to the grids, one at a time
                allgridTop.DataSource = alldtTop;

                allgridTop.DataBind();

                allgridBottom.DataSource = alldtBottom;
                allgridBottom.DataBind();
            }
            else
            {
                // Tell if there are no requests to display
                allrequestslabel.Text = "There are no gift card requests to display.";
            }
        }

        // This loads requests into the user's request table, which is always visible to the current user.
        // It will not load any table if there are no requests.
        protected void LoadMyRequests(SPSite _SPSite, SPWeb _SPweb, SPList _SPlist)
        {

            // Query the results of the current user's gift card requests
            SPQuery _spquery = new SPQuery();
            _spquery.Query = "<Where><Eq><FieldRef Name='Created_x0020_By'/><Value Type='Text'>" + SPContext.Current.Web.CurrentUser.LoginName + "</Value></Eq></Where>";

            // Get the list of items that match the query
            SPListItemCollection Collection = _SPlist.GetItems(_spquery);

            // Generate a DataTable to hold all of the information
            dt = new DataTable();

            // Add the appropriate columns to the DataTable
            dt.Columns.Add("EmailAddress", typeof(string));
            dt.Columns.Add("RequesterName", typeof(string));
            dt.Columns.Add("RecipientName", typeof(string));
            dt.Columns.Add("RecipientStatus", typeof(string));
            dt.Columns.Add("Branch", typeof(string));
            dt.Columns.Add("ReceivedSixHundred", typeof(string));
            dt.Columns.Add("W9", typeof(string));
            dt.Columns.Add("GiftCardAmount", typeof(string));
            dt.Columns.Add("GiftCardType", typeof(string));
            dt.Columns.Add("OtherGiftCardType", typeof(string));
            dt.Columns.Add("Purpose", typeof(string));
            dt.Columns.Add("ApprovedBy", typeof(string));
            dt.Columns.Add("ApprovalDocument", typeof(string));
            dt.Columns.Add("StreetAddress", typeof(string));
            dt.Columns.Add("ApartmentNumber", typeof(string));
            dt.Columns.Add("City", typeof(string));
            dt.Columns.Add("State", typeof(string));
            dt.Columns.Add("ZIPCode", typeof(string));
            dt.Columns.Add("DateNeededBy", typeof(string));
            dt.Columns.Add("Status", typeof(string));

            // Do not proceed if this collection is null or has no elements
            if (Collection != null && Collection.Count > 0)
            {
                queryresults.Text = "Here are all of the gift card requests by " + SPContext.Current.Web.CurrentUser.LoginName + " (" + GetUserFullName(Environment.UserDomainName, Environment.UserName) + "):";
                foreach (SPListItem item in Collection)
                {
                    // Assign a new entry to the DataTable
                    DataRow dr = dt.NewRow();

                    // Parse the information into the table
                    dr["EmailAddress"] = item["EmailAddress"];
                    dr["RequesterName"] = item["RequesterName"];
                    dr["RecipientName"] = item["RecipientName"];
                    dr["RecipientStatus"] = item["RecipientStatus"];
                    dr["Branch"] = item["Branch"];
                    dr["ReceivedSixHundred"] = item["ReceivedSixHundred"];
                    dr["W9"] = item["W9"];
                    dr["GiftCardAmount"] = String.Format("{0:C}", item["GiftCardAmount"]);
                    dr["GiftCardType"] = item["GiftCardType"];
                    dr["Purpose"] = item["Purpose"];
                    dr["ApprovedBy"] = item["ApprovedBy"];
                    dr["ApprovalDocument"] = item["ApprovalDocument"];
                    dr["StreetAddress"] = item["StreetAddress"];
                    dr["ApartmentNumber"] = item["ApartmentNumber"];
                    dr["City"] = item["City"];
                    dr["State"] = item["State"];
                    dr["ZIPCode"] = item["ZIPCode"];
                    dr["DateNeededBy"] = item["DateNeededBy"];
                    dr["Status"] = item["Status"];

                    // Add the row to the data table
                    dt.Rows.Add(dr);
                }

                // Assign and bind the data to the grid
                mygrid.DataSource = dt;
                mygrid.DataBind();
            }
            else
            {
                // Show if there are no requests
                queryresults.Text = "There are no gift card requests by " + SPContext.Current.Web.CurrentUser.LoginName + " (" + GetUserFullName(Environment.UserDomainName, Environment.UserName) + ").";
            }
        }

        // This changes the font size in every grid cell to 12px
        protected void ChangeGridFontSize(GridView grid)
        {
            grid.Font.Size = 12;
            for (int i = 0; i < grid.Columns.Count; i++)
            {
                grid.Columns[i].ItemStyle.Font.Size = 12;
            }
        }

        // Called when the page gets loaded
        // Pre-populates the requester name textbox with the user's display name
        // This also gets the username to get the user's email address
        protected void Page_Load(object sender, EventArgs e)
        {
            // Load the names for the autocomplete widget
            LoadNames();
            // Only perform this on the initial load of the page
            if (!Page.IsPostBack)
            {
                // Variable declarations
                string displayName;

                // Get the user's full name for displaying in the requester field (e.g. "King, Ryan")
                displayName = GetUserFullName(Environment.UserDomainName, Environment.UserName);

                // Get the website for getting metadata
                SPWeb w = SPContext.Current.Web;

                // Assign the hidden label the Created By name
                created.Text = w.CurrentUser.LoginName;

                // The display name comes back as Last, First. For example, "King, Ryan", so remove the comma.
                displayName = displayName.Replace(",", "");

                // Get the separate parts of the display name
                string[] parts = displayName.Split();

                // Enter the user's email address
                this.email.Text = w.CurrentUser.Email;

                // Insert the user's display name. Since parts[0] is the last name and parts[1] is the first name,
                // the two need to be reversed for Western name order.
                this.requester.Text = parts[1] + " " + parts[0];

                // Set all forms but the first invisible for now
                form2.Visible = false;
                form3.Visible = false;
                form4.Visible = false;
                form5.Visible = false;
                form6.Visible = false;
                form7.Visible = false;
                form8.Visible = false;
                form9.Visible = false;
                form10.Visible = false;

                // Set the all request grids invisible for now
                topGrid.Visible = false;
                bottomGrid.Visible = false;

                // Set the error labels invisible for now
                allErrors.Visible = false;
                errorForms.Text = "";
                errorForms.Visible = false;
                resubmit.Visible = false;

                // Make the font sizes larger on both grids
                ChangeGridFontSize(mygrid);
                ChangeGridFontSize(allgridTop);
                ChangeGridFontSize(allgridBottom);

                // Get the site and list to read from
                SPSite _SPSite = new SPSite(guidSite);
                SPWeb _SPweb = _SPSite.OpenWeb();
                SPList _SPlist = _SPweb.Lists["GifrCardRecords"];

                // Load only the current user's requests
                LoadMyRequests(_SPSite, _SPweb, _SPlist);

                // Load every user's request
                LoadAllRequests(_SPSite, _SPweb, _SPlist);

                // Refresh the data
                BindData();

                // Check to see if the user is a Site Owner to determine if s/he can see the All Requests list
                SetAllViewPermissions();
            }
        }

        // Determine if the user has the proper permissions to view
        // the list of all gift card requests.
        // Also makes the lists of W9s and approval documents invisible if
        // the user has no permissions.
        protected void SetAllViewPermissions()
        {
            if (SPContext.Current.Web.DoesUserHavePermissions(SPBasePermissions.FullMask))
            {
                canAccessAll.Text = "T";// True
            }
            else
            {
                canAccessAll.Text = "F";// False

                // Set these private lists invisible
                using (SPSite site = new SPSite(guidSite))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        web.AllowUnsafeUpdates = true;
                        SPList configList = web.Lists["ApprovalDocuments"];
                        configList.Hidden = true;
                        configList.Update();

                        SPList w9s = web.Lists["W9s"];
                        w9s.Hidden = true;
                        w9s.Update();

                        SPList options = web.Lists["Options"];
                        options.Hidden = true;
                        options.Update();
                    }
                }
            }
        }

        // Obtains the current user's display name, e.g. "King, Ryan" as opposed to "KingRy", which is the username
        protected string GetUserFullName(string domain, string userName)
        {
            DirectoryEntry userEntry = new DirectoryEntry("WinNT://" + domain + "/" + userName + ",User");
            return (string)userEntry.Properties["fullname"].Value;
        }

        // Parses the dollar amount and determines if it is valid.
        // Returns -1 on error or the amount on success.
        protected decimal ParseAmount(string toParse)
        {
            // Remove the dollar sign from the string
            string rawNumber = Regex.Replace(toParse, @"\$", "");
            // Split the dollars and cents
            string[] parts = rawNumber.Split('.');
            decimal dollars, cents = 0;
            // Try parsing the numbers. Return -1 on error.
            if (!decimal.TryParse(parts[0], out dollars))
            {
                return -1;
            }
            // Determine if there are any cents in this amount
            if (parts.Length > 1)
            {
                if (!decimal.TryParse(parts[1], out cents))
                {
                    return -1;
                }
            }
            // Format and add up the dollars and cents
            cents /= 100;
            dollars += cents;
            return dollars;
        }

        // Serves the same purpose as a System.Windows.Forms.MessageBox object
        // as a JavaScript alert box.
        protected void MsgBox(string sMessage)
        {
            // Make a new script with an alert box and the argument as a message
            string msg = "<script type=\"text/javascript\">";
            msg += "alert(\"" + sMessage + "\");";
            msg += "</script>";

            // Post the message to the top of the document
            Response.Write(msg);
        }

        // All the methods of the format EnableFormN() or DisableFormN()
        // will enable or disable the CustomValidators for form N,
        // which can be any form from 2 to 10.
        // Disabling the validators is essential if the user only
        // wishes to submit fewer than 10 forms at once.
        // The validators for form 1 are always enabled and cannot be disabled.

        // Enables the validators for form 2
        protected void EnableForm2()
        {
            cvName2.Enabled = true;
            cvRecipientType2.Enabled = true;
            cvOtherRecipient2.Enabled = true;
            cvYesNo2.Enabled = true;
            cvW92.Enabled = true;
            cvAmount2.Enabled = true;
            cvGiftCardType2.Enabled = true;
            cvPurpose2.Enabled = true;
            cvStreetAddress2.Enabled = true;
            cvCity2.Enabled = true;
            cvState2.Enabled = true;
            cvZipCode2.Enabled = true;
            cvOtherApprovalText2.Enabled = true;
            cvApprovalFile2.Enabled = true;
            cvDate2.Enabled = true;
        }

        // Disables the validators for form 2
        protected void DisableForm2()
        {
            cvName2.Enabled = false;
            cvRecipientType2.Enabled = false;
            cvOtherRecipient2.Enabled = false;
            cvYesNo2.Enabled = false;
            cvW92.Enabled = false;
            cvAmount2.Enabled = false;
            cvGiftCardType2.Enabled = false;
            cvPurpose2.Enabled = false;
            cvStreetAddress2.Enabled = false;
            cvCity2.Enabled = false;
            cvState2.Enabled = false;
            cvZipCode2.Enabled = false;
            cvOtherApprovalText2.Enabled = false;
            cvApprovalFile2.Enabled = false;
            cvDate2.Enabled = false;
        }

        // Enables the validators for form 3
        protected void EnableForm3()
        {
            cvName3.Enabled = true;
            cvRecipientType3.Enabled = true;
            cvOtherRecipient3.Enabled = true;
            cvYesNo3.Enabled = true;
            cvW93.Enabled = true;
            cvAmount3.Enabled = true;
            cvGiftCardType3.Enabled = true;
            cvPurpose3.Enabled = true;
            cvStreetAddress3.Enabled = true;
            cvCity3.Enabled = true;
            cvState3.Enabled = true;
            cvZipCode3.Enabled = true;
            cvOtherApprovalText3.Enabled = true;
            cvApprovalFile3.Enabled = true;
            cvDate3.Enabled = true;
        }

        // Disables the validators for form 3
        protected void DisableForm3()
        {
            cvName3.Enabled = false;
            cvRecipientType3.Enabled = false;
            cvOtherRecipient3.Enabled = false;
            cvYesNo3.Enabled = false;
            cvW93.Enabled = false;
            cvAmount3.Enabled = false;
            cvGiftCardType3.Enabled = false;
            cvPurpose3.Enabled = false;
            cvStreetAddress3.Enabled = false;
            cvCity3.Enabled = false;
            cvState3.Enabled = false;
            cvZipCode3.Enabled = false;
            cvOtherApprovalText3.Enabled = false;
            cvApprovalFile3.Enabled = false;
            cvDate3.Enabled = false;
        }

        // Enables the validators for form 4
        protected void EnableForm4()
        {
            cvName4.Enabled = true;
            cvRecipientType4.Enabled = true;
            cvOtherRecipient4.Enabled = true;
            cvYesNo4.Enabled = true;
            cvW94.Enabled = true;
            cvAmount4.Enabled = true;
            cvGiftCardType4.Enabled = true;
            cvPurpose4.Enabled = true;
            cvStreetAddress4.Enabled = true;
            cvCity4.Enabled = true;
            cvState4.Enabled = true;
            cvZipCode4.Enabled = true;
            cvOtherApprovalText4.Enabled = true;
            cvApprovalFile4.Enabled = true;
            cvDate4.Enabled = true;
        }

        // Disables the validators for form 4
        protected void DisableForm4()
        {
            cvName4.Enabled = false;
            cvRecipientType4.Enabled = false;
            cvOtherRecipient4.Enabled = false;
            cvYesNo4.Enabled = false;
            cvW94.Enabled = false;
            cvAmount4.Enabled = false;
            cvGiftCardType4.Enabled = false;
            cvPurpose4.Enabled = false;
            cvStreetAddress4.Enabled = false;
            cvCity4.Enabled = false;
            cvState4.Enabled = false;
            cvZipCode4.Enabled = false;
            cvOtherApprovalText4.Enabled = false;
            cvApprovalFile4.Enabled = false;
            cvDate4.Enabled = false;
        }

        // Enables the validators for form 5
        protected void EnableForm5()
        {
            cvName5.Enabled = true;
            cvRecipientType5.Enabled = true;
            cvOtherRecipient5.Enabled = true;
            cvYesNo5.Enabled = true;
            cvW95.Enabled = true;
            cvAmount5.Enabled = true;
            cvGiftCardType5.Enabled = true;
            cvPurpose5.Enabled = true;
            cvStreetAddress5.Enabled = true;
            cvCity5.Enabled = true;
            cvState5.Enabled = true;
            cvZipCode5.Enabled = true;
            cvOtherApprovalText5.Enabled = true;
            cvApprovalFile5.Enabled = true;
            cvDate5.Enabled = true;
        }

        // Disables the validators for form 5
        protected void DisableForm5()
        {
            cvName5.Enabled = false;
            cvRecipientType5.Enabled = false;
            cvOtherRecipient5.Enabled = false;
            cvYesNo5.Enabled = false;
            cvW95.Enabled = false;
            cvAmount5.Enabled = false;
            cvGiftCardType5.Enabled = false;
            cvPurpose5.Enabled = false;
            cvStreetAddress5.Enabled = false;
            cvCity5.Enabled = false;
            cvState5.Enabled = false;
            cvZipCode5.Enabled = false;
            cvOtherApprovalText5.Enabled = false;
            cvApprovalFile5.Enabled = false;
            cvDate5.Enabled = false;
        }

        // Enables the validators for form 6
        protected void EnableForm6()
        {
            cvName6.Enabled = true;
            cvRecipientType6.Enabled = true;
            cvOtherRecipient6.Enabled = true;
            cvYesNo6.Enabled = true;
            cvW96.Enabled = true;
            cvAmount6.Enabled = true;
            cvGiftCardType6.Enabled = true;
            cvPurpose6.Enabled = true;
            cvStreetAddress6.Enabled = true;
            cvCity6.Enabled = true;
            cvState6.Enabled = true;
            cvZipCode6.Enabled = true;
            cvOtherApprovalText6.Enabled = true;
            cvApprovalFile6.Enabled = true;
            cvDate6.Enabled = true;
        }

        // Disables the validators for form 6
        protected void DisableForm6()
        {
            cvName6.Enabled = false;
            cvRecipientType6.Enabled = false;
            cvOtherRecipient6.Enabled = false;
            cvYesNo6.Enabled = false;
            cvW96.Enabled = false;
            cvAmount6.Enabled = false;
            cvGiftCardType6.Enabled = false;
            cvPurpose6.Enabled = false;
            cvStreetAddress6.Enabled = false;
            cvCity6.Enabled = false;
            cvState6.Enabled = false;
            cvZipCode6.Enabled = false;
            cvOtherApprovalText6.Enabled = false;
            cvApprovalFile6.Enabled = false;
            cvDate6.Enabled = false;
        }

        // Enables the validators for form 7
        protected void EnableForm7()
        {
            cvName7.Enabled = true;
            cvRecipientType7.Enabled = true;
            cvOtherRecipient7.Enabled = true;
            cvYesNo7.Enabled = true;
            cvW97.Enabled = true;
            cvAmount7.Enabled = true;
            cvGiftCardType7.Enabled = true;
            cvPurpose7.Enabled = true;
            cvStreetAddress7.Enabled = true;
            cvCity7.Enabled = true;
            cvState7.Enabled = true;
            cvZipCode7.Enabled = true;
            cvOtherApprovalText7.Enabled = true;
            cvApprovalFile7.Enabled = true;
            cvDate7.Enabled = true;
        }

        // Disables the validators for form 7
        protected void DisableForm7()
        {
            cvName7.Enabled = false;
            cvRecipientType7.Enabled = false;
            cvOtherRecipient7.Enabled = false;
            cvYesNo7.Enabled = false;
            cvW97.Enabled = false;
            cvAmount7.Enabled = false;
            cvGiftCardType7.Enabled = false;
            cvPurpose7.Enabled = false;
            cvStreetAddress7.Enabled = false;
            cvCity7.Enabled = false;
            cvState7.Enabled = false;
            cvZipCode7.Enabled = false;
            cvOtherApprovalText7.Enabled = false;
            cvApprovalFile7.Enabled = false;
            cvDate7.Enabled = false;
        }

        // Enables the validators for form 8
        protected void EnableForm8()
        {
            cvName8.Enabled = true;
            cvRecipientType8.Enabled = true;
            cvOtherRecipient8.Enabled = true;
            cvYesNo8.Enabled = true;
            cvW98.Enabled = true;
            cvAmount8.Enabled = true;
            cvGiftCardType8.Enabled = true;
            cvPurpose8.Enabled = true;
            cvStreetAddress8.Enabled = true;
            cvCity8.Enabled = true;
            cvState8.Enabled = true;
            cvZipCode8.Enabled = true;
            cvOtherApprovalText8.Enabled = true;
            cvApprovalFile8.Enabled = true;
            cvDate8.Enabled = true;
        }

        // Disables the validators for form 8
        protected void DisableForm8()
        {
            cvName8.Enabled = false;
            cvRecipientType8.Enabled = false;
            cvOtherRecipient8.Enabled = false;
            cvYesNo8.Enabled = false;
            cvW98.Enabled = false;
            cvAmount8.Enabled = false;
            cvGiftCardType8.Enabled = false;
            cvPurpose8.Enabled = false;
            cvStreetAddress8.Enabled = false;
            cvCity8.Enabled = false;
            cvState8.Enabled = false;
            cvZipCode8.Enabled = false;
            cvOtherApprovalText8.Enabled = false;
            cvApprovalFile8.Enabled = false;
            cvDate8.Enabled = false;
        }

        // Enables the validators for form 9
        protected void EnableForm9()
        {
            cvName9.Enabled = true;
            cvRecipientType9.Enabled = true;
            cvOtherRecipient9.Enabled = true;
            cvYesNo9.Enabled = true;
            cvW99.Enabled = true;
            cvAmount9.Enabled = true;
            cvGiftCardType9.Enabled = true;
            cvPurpose9.Enabled = true;
            cvStreetAddress9.Enabled = true;
            cvCity9.Enabled = true;
            cvState9.Enabled = true;
            cvZipCode9.Enabled = true;
            cvOtherApprovalText9.Enabled = true;
            cvApprovalFile9.Enabled = true;
            cvDate9.Enabled = true;
        }

        // Disables the validators for form 9
        protected void DisableForm9()
        {
            cvName9.Enabled = false;
            cvRecipientType9.Enabled = false;
            cvOtherRecipient9.Enabled = false;
            cvYesNo9.Enabled = false;
            cvW99.Enabled = false;
            cvAmount9.Enabled = false;
            cvGiftCardType9.Enabled = false;
            cvPurpose9.Enabled = false;
            cvStreetAddress9.Enabled = false;
            cvCity9.Enabled = false;
            cvState9.Enabled = false;
            cvZipCode9.Enabled = false;
            cvOtherApprovalText9.Enabled = false;
            cvApprovalFile9.Enabled = false;
            cvDate9.Enabled = false;
        }

        // Enables the validators for form 10
        protected void EnableForm10()
        {
            cvName10.Enabled = true;
            cvRecipientType10.Enabled = true;
            cvOtherRecipient10.Enabled = true;
            cvYesNo10.Enabled = true;
            cvW910.Enabled = true;
            cvAmount10.Enabled = true;
            cvGiftCardType10.Enabled = true;
            cvPurpose10.Enabled = true;
            cvStreetAddress10.Enabled = true;
            cvCity10.Enabled = true;
            cvState10.Enabled = true;
            cvZipCode10.Enabled = true;
            cvOtherApprovalText10.Enabled = true;
            cvApprovalFile10.Enabled = true;
            cvDate10.Enabled = true;
        }

        // Disables the validators for form 10
        protected void DisableForm10()
        {
            cvName10.Enabled = false;
            cvRecipientType10.Enabled = false;
            cvOtherRecipient10.Enabled = false;
            cvYesNo10.Enabled = false;
            cvW910.Enabled = false;
            cvAmount10.Enabled = false;
            cvGiftCardType10.Enabled = false;
            cvPurpose10.Enabled = false;
            cvStreetAddress10.Enabled = false;
            cvCity10.Enabled = false;
            cvState10.Enabled = false;
            cvZipCode10.Enabled = false;
            cvOtherApprovalText10.Enabled = false;
            cvApprovalFile10.Enabled = false;
            cvDate10.Enabled = false;
        }

        // Called when the Submit button is clicked
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Update the timestamp. This will be the same for every form submitted in this instance.
            timestamp = DateTime.Now;

            allErrors.Visible = false;
            errorForms.Text = "";
            errorForms.Visible = false;
            resubmit.Visible = false;

            // Submit as many forms as necessary
            if (Submit(name, recipientType, branch, otherRecipient, yesNo, w9, amount, giftCardType, otherGiftCardType, purpose, streetAddress, aptNumber, city, state, zipCode, approval, otherApprovalText, approvalFile, date, outcome, 1)) 
            {
                ClearInternalForm1Fields();
                cvW9.Enabled = true;
                cvApprovalFile.Enabled = true;
            }

            // Only submit the 2nd through 10th forms if they are visible
            if (form2.Visible && Submit(name2, recipientType2, branch2, otherRecipient2, yesNo2, w92, amount2, giftCardType2, otherGiftCardType2, purpose2, streetAddress2, aptNumber2, city2, state2, zipCode2, approval2, otherApprovalText2, approvalFile2, date2, outcome2, 2))
            {
                ClearInternalForm2Fields();
                EnableForm2();
            }

            if (form3.Visible && Submit(name3, recipientType3, branch3, otherRecipient3, yesNo3, w93, amount3, giftCardType3, otherGiftCardType3, purpose3, streetAddress3, aptNumber3, city3, state3, zipCode3, approval3, otherApprovalText3, approvalFile3, date3, outcome3, 3))
            {
                ClearInternalForm3Fields();
                EnableForm3();
            }

            if (form4.Visible && Submit(name4, recipientType4, branch4, otherRecipient4, yesNo4, w94, amount4, giftCardType4, otherGiftCardType4, purpose4, streetAddress4, aptNumber4, city4, state4, zipCode4, approval4, otherApprovalText4, approvalFile4, date4, outcome4, 4))
            {
                ClearInternalForm4Fields();
                EnableForm4();
            }

            if (form5.Visible && Submit(name5, recipientType5, branch5, otherRecipient5, yesNo5, w95, amount5, giftCardType5, otherGiftCardType5, purpose5, streetAddress5, aptNumber5, city5, state5, zipCode5, approval5, otherApprovalText5, approvalFile5, date5, outcome5, 5))
            {
                ClearInternalForm5Fields();
                EnableForm5();
            }

            if (form6.Visible && Submit(name6, recipientType6, branch6, otherRecipient6, yesNo6, w96, amount6, giftCardType6, otherGiftCardType6, purpose6, streetAddress6, aptNumber6, city6, state6, zipCode6, approval6, otherApprovalText6, approvalFile6, date6, outcome6, 6))
            {
                ClearInternalForm6Fields();
                EnableForm6();
            }

            if (form7.Visible && Submit(name7, recipientType7, branch7, otherRecipient7, yesNo7, w97, amount7, giftCardType7, otherGiftCardType7, purpose7, streetAddress7, aptNumber7, city7, state7, zipCode7, approval7, otherApprovalText7, approvalFile7, date7, outcome7, 7))
            {
                ClearInternalForm7Fields();
                EnableForm7();
            }

            if (form8.Visible && Submit(name8, recipientType8, branch8, otherRecipient8, yesNo8, w98, amount8, giftCardType8, otherGiftCardType8, purpose8, streetAddress8, aptNumber8, city8, state8, zipCode8, approval8, otherApprovalText8, approvalFile8, date8, outcome8, 8))
            {
                ClearInternalForm8Fields();
                EnableForm8();
            }

            if (form9.Visible && Submit(name9, recipientType9, branch9, otherRecipient9, yesNo9, w99, amount9, giftCardType9, otherGiftCardType9, purpose9, streetAddress9, aptNumber9, city9, state9, zipCode9, approval9, otherApprovalText9, approvalFile9, date9, outcome9, 9))
            {
                ClearInternalForm9Fields();
                EnableForm9();
            }

            if (form10.Visible && Submit(name10, recipientType10, branch10, otherRecipient10, yesNo10, w910, amount10, giftCardType10, otherGiftCardType10, purpose10, streetAddress10, aptNumber10, city10, state10, zipCode10, approval10, otherApprovalText10, approvalFile10, date10, outcome10, 10))
            {
                ClearInternalForm10Fields();
                EnableForm10();
            }

            if (!IsNullEmptyOrWhitespace(errorForms.Text))
            {
                allErrors.Visible = true;
                errorForms.Visible = true;
                resubmit.Visible = true;
            }
            else
            {
                allErrors.Visible = false;
                errorForms.ForeColor = System.Drawing.Color.ForestGreen;
                errorForms.Text = "All forms were submitted successfully.";
                errorForms.Visible = true;
                resubmit.Visible = false;
            }

        }

        // Stores the filename, contents, and URL in C#. Does nothing on error or exception.
        protected void UploadFile(ref FileUpload upload, ref System.Web.UI.WebControls.Label name, ref System.Web.UI.WebControls.Label content, ref System.Web.UI.WebControls.Label url, string library)
        {
            try
            {

                if (upload.PostedFile != null)
                {
                    name.Text = upload.FileName;
                    content.Text = Convert.ToBase64String(upload.FileBytes);
                    url.Text = SPContext.Current.Site.Url + "/" + library + "/" + upload.FileName;
                }
                else
                {
                    return;
                }
            }
            catch (Exception)
            {
                return;
            }
        }

        // Finds the text of the URL that corresponds to the index.
        // Returns the URL as a string on success and null on failure.
        protected string FindW9Url(int index)
        {
            try
            {
                switch (index)
                {
                    case 1: return w9Url.Text;
                    case 2: return w92Url.Text;
                    case 3: return w93Url.Text;
                    case 4: return w94Url.Text;
                    case 5: return w95Url.Text;
                    case 6: return w96Url.Text;
                    case 7: return w97Url.Text;
                    case 8: return w98Url.Text;
                    case 9: return w99Url.Text;
                    case 10: return w910Url.Text;
                    default: return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        // Finds the text of the URL that corresponds to the index.
        // Returns the URL as a string on success and null on failure.
        protected string FindApprovalUrl(int index)
        {
            try
            {
                switch (index)
                {
                    case 1: return approvalFileUrl.Text;
                    case 2: return approvalFile2Url.Text;
                    case 3: return approvalFile3Url.Text;
                    case 4: return approvalFile4Url.Text;
                    case 5: return approvalFile5Url.Text;
                    case 6: return approvalFile6Url.Text;
                    case 7: return approvalFile7Url.Text;
                    case 8: return approvalFile8Url.Text;
                    case 9: return approvalFile9Url.Text;
                    case 10: return approvalFile10Url.Text;
                    default: return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        // Finds the text of the file content that corresponds to the index.
        // Returns the file content as a string on success and null on failure.
        protected string FindW9Content(int index)
        {
            try
            {
                switch (index)
                {
                    case 1: return w9Content.Text;
                    case 2: return w92Content.Text;
                    case 3: return w93Content.Text;
                    case 4: return w94Content.Text;
                    case 5: return w95Content.Text;
                    case 6: return w96Content.Text;
                    case 7: return w97Content.Text;
                    case 8: return w98Content.Text;
                    case 9: return w99Content.Text;
                    case 10: return w910Content.Text;
                    default: return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        // Finds the text of the filename that corresponds to the index.
        // Returns the filename as a string on success and null on failure.
        protected string FindW9Name(int index)
        {
            try
            {
                switch (index)
                {
                    case 1: return w9Name.Text;
                    case 2: return w92Name.Text;
                    case 3: return w93Name.Text;
                    case 4: return w94Name.Text;
                    case 5: return w95Name.Text;
                    case 6: return w96Name.Text;
                    case 7: return w97Name.Text;
                    case 8: return w98Name.Text;
                    case 9: return w99Name.Text;
                    case 10: return w910Name.Text;
                    default: return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        // Finds the text of the file content that corresponds to the index.
        // Returns the file content as a string on success and null on failure.
        protected string FindApprovalContent(int index)
        {
            try
            {
                switch (index)
                {
                    case 1: return approvalFileContent.Text;
                    case 2: return approvalFile2Content.Text;
                    case 3: return approvalFile3Content.Text;
                    case 4: return approvalFile4Content.Text;
                    case 5: return approvalFile5Content.Text;
                    case 6: return approvalFile6Content.Text;
                    case 7: return approvalFile7Content.Text;
                    case 8: return approvalFile8Content.Text;
                    case 9: return approvalFile9Content.Text;
                    case 10: return approvalFile10Content.Text;
                    default: return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        // Finds the text of the filename that corresponds to the index.
        // Returns the filename as a string on success and null on failure.
        protected string FindApprovalName(int index)
        {
            try
            {
                switch (index)
                {
                    case 1: return approvalFileName.Text;
                    case 2: return approvalFile2Name.Text;
                    case 3: return approvalFile3Name.Text;
                    case 4: return approvalFile4Name.Text;
                    case 5: return approvalFile5Name.Text;
                    case 6: return approvalFile6Name.Text;
                    case 7: return approvalFile7Name.Text;
                    case 8: return approvalFile8Name.Text;
                    case 9: return approvalFile9Name.Text;
                    case 10: return approvalFile10Name.Text;
                    default: return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        // This gets called from 1 to 10 times, depending on how many forms get submitted.
        // This method can quit prematurely if there's an error, such as not opening the site or list, 
        // or finding data errors in the current submissions. Such errors are reported to the user
        // through the CustomValidators on that form.
        protected bool Submit(System.Web.UI.WebControls.TextBox nameOfRecipient, RadioButtonList typeOfRecipient, DropDownList employeeBranch, System.Web.UI.WebControls.TextBox otherTypeOfRecipient, RadioButtonList sixHundred, FileUpload w9Form,
            System.Web.UI.WebControls.TextBox giftCardAmount, RadioButtonList giftCardSelection, System.Web.UI.WebControls.TextBox giftCardType, System.Web.UI.WebControls.TextBox giftCardPurpose, System.Web.UI.WebControls.TextBox address, System.Web.UI.WebControls.TextBox apartmentOrSuite, System.Web.UI.WebControls.TextBox recipientCity, System.Web.UI.WebControls.TextBox recipientState,
            System.Web.UI.WebControls.TextBox zip, RadioButtonList approver, System.Web.UI.WebControls.TextBox otherApprover, FileUpload approvalForm, System.Web.UI.WebControls.TextBox dateNeededBy, System.Web.UI.WebControls.Label outcomeLabel, int index)
        {
            try
            {
                // Determine if there are any errors in the form
                string errors = CheckForErrors(nameOfRecipient, typeOfRecipient, employeeBranch, otherTypeOfRecipient, sixHundred, w9Form,
                    giftCardAmount, giftCardSelection, giftCardType, giftCardPurpose, address, apartmentOrSuite, recipientCity, recipientState,
                    zip, approver, otherApprover, approvalForm, dateNeededBy, index);

                // Do not continue if there are errors
                if (!IsNullEmptyOrWhitespace(errors))
                {
                    /*// Old error displaying code will show errors on the bottom of the page
                    outcomeLabel.Text = errors;
                    outcomeLabel.ForeColor = System.Drawing.Color.Red;
                    outcomeLabel.Visible = true;
                    */
                    return false;
                }

                // Attempt to open the SharePoint site
                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        // Attempt to open the gift card record database (spelling error was made on creation)
                        SPList list = web.Lists.TryGetList("GifrCardRecords");
                        if (list != null)
                        {
                            // Add a new item to the successfully opened list
                            SPListItem NewItem = list.Items.Add();
                            {
                                web.AllowUnsafeUpdates = true;
                                // Unique ID will look like this: YYYYMMDDHHMMSSII
                                // Sample:                        2019080211483001
                                string uniqueID = timestamp.Year.ToString("D4") + timestamp.Month.ToString("D2") + timestamp.Day.ToString("D2")
                                    + timestamp.Hour.ToString("D2") + timestamp.Minute.ToString("D2") + timestamp.Second.ToString("D2") + index.ToString("D2");

                                NewItem["UniqueID"] = uniqueID;

                                NewItem["Timestamp"] = timestamp.ToString("MM/dd/yyyy hh:mm:ss tt");

                                // Put the primary key into the database entry
                                NewItem["Created By"] = web.CurrentUser.LoginName;

                                // Add all of the fields from the form
                                NewItem["EmailAddress"] = email.Text;

                                NewItem["RequesterName"] = requester.Text;

                                NewItem["RecipientName"] = nameOfRecipient.Text;

                                // Parse the proper information if the recipient is an employee or not
                                if (!IsEmployee(typeOfRecipient))
                                {
                                    // This field is not necessary for a non-employee
                                    NewItem["Branch"] = "N/A";

                                    NewItem["ReceivedSixHundred"] = sixHundred.SelectedValue.ToString();

                                    NewItem["RecipientStatus"] = otherTypeOfRecipient.Text;

                                    // Get the name, content, and URL of this file
                                    string w9FileName = FindW9Name(index);
                                    string w9FileContent = FindW9Content(index);
                                    string w9FileUrl = FindW9Url(index);

                                    // Upload the file to SharePoint
                                    string w9FileLink = LinkFile(w9FileName, w9FileContent, "W9s");

                                    NewItem["W9"] = w9FileLink;

                                    // Instantiate the Attachment object
                                    Attachment att = new Attachment(new MemoryStream(Convert.FromBase64String(w9FileContent)), w9FileName);

                                    // Replace these with Sharp Support Center email address and password
                                    //var fromAddress = new MailAddress("KingRy@sharpsec.com", GetUserFullName(Environment.UserDomainName, Environment.UserName));
                                    var fromAddress = new MailAddress(SPContext.Current.Web.CurrentUser.Email, GetUserFullName(Environment.UserDomainName, Environment.UserName));
                                    var toAddress = new MailAddress("rajasundaraa@sharpsec.com", "Rajasundaram, Arulraj");
                                    string subject = "W-9 Form " + w9FileName + " for Gift Card #" + uniqueID;
                                    const string body = "";

                                    // Initialize the SMTP client
                                    SmtpClient smtp = new SmtpClient();
                                    smtp.UseDefaultCredentials = false;
                                    smtp.Credentials = new System.Net.NetworkCredential("KingRy@sharpsec.com", "Sharp.2");
                                    smtp.Host = "smtp.office365.com";
                                    smtp.Port = 587;  // this is critical
                                    smtp.EnableSsl = true;  // this is critical

                                    ServicePointManager.ServerCertificateValidationCallback += (o, c, ch, er) => true;

                                    // Initialize the Mail Message object
                                    MailMessage message = new MailMessage();

                                    // Fil out the subject, body, sender, and recipient
                                    message.Subject = subject;
                                    message.Body = body;
                                    message.From = fromAddress;
                                    message.To.Add(toAddress);
                                    // Addresses for gift cards
                                    // Sending works as of August 2019
                                    // message.To.Add("sharpgiftcard@sharpsec.com");//Uncomment this later

                                    // Attach the PDF
                                    message.Attachments.Add(att);
                                    //smtp.Send(message);// Uncomment this later
                                }
                                else
                                {
                                    NewItem["Branch"] = employeeBranch.SelectedValue;
                                    NewItem["RecipientStatus"] = "Employee";

                                    // This field is not necessary for an employee
                                    NewItem["ReceivedSixHundred"] = "N/A";
                                }

                                // Place the dollar amount in as a number to get parsed by SharePoint
                                NewItem["GiftCardAmount"] = String.Format("{0:C}", giftCardAmount.Text);

                                // Parse the gift card type into SharePoint
                                if (!IsNullEmptyOrWhitespace(giftCardType.Text))
                                {
                                    NewItem["GiftCardType"] = giftCardType.Text;
                                    NewItem["VendorPurchasedFrom"] = giftCardType.Text;
                                }
                                else
                                {
                                    // American Express is the default gift card
                                    NewItem["GiftCardType"] = "American Express";

                                    // Allows the column to be clicked on and edited later
                                    NewItem["VendorPurchasedFrom"] = "American Express";
                                }

                                // Parse the purpose into SharePoint
                                NewItem["Purpose"] = giftCardPurpose.Text;

                                // Parse the approver into SharePoint
                                if (!approver.SelectedValue.Equals("Other", StringComparison.OrdinalIgnoreCase))
                                {
                                    NewItem["ApprovedBy"] = approver.SelectedValue.ToString();
                                }
                                else
                                {
                                    NewItem["ApprovedBy"] = otherApprover.Text;
                                }

                                // Grab the approval filename, content, and URL from C#
                                string approvalName = FindApprovalName(index);
                                string approvalContent = FindApprovalContent(index);
                                string approvalUrl = FindApprovalUrl(index);

                                // Upload the file to SharePoint and return the link
                                string approvalLink = LinkFile(approvalName, approvalContent, "ApprovalDocuments");

                                // Instantiate the Attachment object
                                Attachment att2 = new Attachment(new MemoryStream(Convert.FromBase64String(approvalContent)), approvalName);

                                // Replace these with Sharp Support Center 
                                // address and password
                                //var fromAddress = new MailAddress("KingRy@sharpsec.com", GetUserFullName(Environment.UserDomainName, Environment.UserName));
                                var fromAddress2 = new MailAddress(SPContext.Current.Web.CurrentUser.Email, GetUserFullName(Environment.UserDomainName, Environment.UserName));
                                var toAddress2 = new MailAddress("rajasundaraa@sharpsec.com", "Rajasundaram, Arulraj");
                                string subject2 = "Approval Form " + approvalName + " for Gift Card #" + uniqueID;
                                const string body2 = "";

                                // Initialize the SMTP client
                                SmtpClient smtp2 = new SmtpClient();
                                smtp2.UseDefaultCredentials = false;
                                smtp2.Credentials = new System.Net.NetworkCredential("KingRy@sharpsec.com", "Sharp.2");
                                smtp2.Host = "smtp.office365.com";
                                smtp2.Port = 587;  // this is critical
                                smtp2.EnableSsl = true;  // this is critical

                                ServicePointManager.ServerCertificateValidationCallback += (o, c, ch, er) => true;

                                // Initialize the Mail Message object
                                MailMessage message2 = new MailMessage();

                                // Fil out the subject, body, sender, and recipient
                                message2.Subject = subject2;
                                message2.Body = body2;
                                message2.From = fromAddress2;
                                message2.To.Add(toAddress2);
                                // Addresses for gift cards
                                // message.To.Add("sharpgiftcard@sharpsec.com");

                                // Attach the PDF and send it
                                message2.Attachments.Add(att2);
                                //smtp2.Send(message2);// Uncomment this later

                                // Leave the link as the file's name
                                NewItem["ApprovalDocument"] = approvalLink;

                                // Parse the recipient's delivery address into SharePoint
                                NewItem["StreetAddress"] = address.Text;

                                // Only include an apartment number if one was provided
                                if (!IsNullEmptyOrWhitespace(apartmentOrSuite.Text))
                                {
                                    NewItem["ApartmentNumber"] = apartmentOrSuite.Text;
                                }

                                NewItem["City"] = recipientCity.Text;

                                NewItem["State"] = recipientState.Text;

                                NewItem["ZIPCode"] = zip.Text;

                                // Parse the date string into SharePoint
                                NewItem["DateNeededBy"] = ParseDate(dateNeededBy.Text);

                                // Update the item on the server
                                NewItem.Update();

                                // Reset all of the initially empty fields for the submission of another form
                                nameOfRecipient.Text = "";
                                otherTypeOfRecipient.Text = "";
                                giftCardAmount.Text = "";
                                giftCardType.Text = "";
                                giftCardPurpose.Text = "";
                                approver.SelectedValue = "";
                                otherApprovalText.Text = "";
                                date.Text = "";
                                address.Text = "";
                                apartmentOrSuite.Text = "";
                                recipientCity.Text = "";
                                recipientState.Text = "";
                                zip.Text = "";

                                typeOfRecipient.SelectedIndex = -1;
                                employeeBranch.SelectedIndex = -1;
                                sixHundred.SelectedIndex = -1;
                                approver.SelectedIndex = -1;

                                switch(index){
                                    case 1: this.giftCardType.SelectedIndex = -1;
                                        break;
                                    case 2: this.giftCardType2.SelectedIndex = -1;
                                        break;
                                    case 3: this.giftCardType3.SelectedIndex = -1;
                                        break;
                                    case 4: this.giftCardType4.SelectedIndex = -1;
                                        break;
                                    case 5: this.giftCardType5.SelectedIndex = -1;
                                        break;
                                    case 6: this.giftCardType6.SelectedIndex = -1;
                                        break;
                                    case 7: this.giftCardType7.SelectedIndex = -1;
                                        break;
                                    case 8: this.giftCardType8.SelectedIndex = -1;
                                        break;
                                    case 9: this.giftCardType9.SelectedIndex = -1;
                                        break;
                                    case 10: this.giftCardType10.SelectedIndex = -1;
                                        break;
                                    default: break;
                                }
                                

                                // Alert the user of a successful request
                                outcomeLabel.Text = "Success!";
                                outcomeLabel.ForeColor = System.Drawing.Color.ForestGreen;
                                outcomeLabel.Visible = true;

                                // Get the site and list to read from
                                SPWeb currentWeb = SPContext.Current.Web;
                                SPSite _SPSite = new SPSite(guidSite);
                                SPWeb _SPweb = _SPSite.OpenWeb();
                                SPList _SPlist = _SPweb.Lists["GifrCardRecords"];

                                // Load only the current user's requests
                                LoadMyRequests(_SPSite, _SPweb, _SPlist);

                                // Load the requests of all users for Site Owners
                                LoadAllRequests(_SPSite, _SPweb, _SPlist);

                                return true;
                            }
                        }
                        else
                        {
                            // Alert the user if the list was not found
                            MsgBox("List not found.");
                            return false;
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                // Alert the user of any exception that may have occurred
                MsgBox(ex.Message);
                return false;
            }
        }

        // Determines if the recipient is an employee
        // Returns true if s/he is and false otherwise.
        protected bool IsEmployee(RadioButtonList recipient)
        {
            try
            {
                return recipient.SelectedValue == "Yes";
            }
            catch (Exception)
            {
                return false;
            }
        }

        // This determines if the recipient requires a W-9 to be submitted.
        // Returns true if it does and false otherwise.
        protected bool NeedsW9(RadioButtonList recipient, RadioButtonList sixHundred, System.Web.UI.WebControls.TextBox giftCardAmount)
        {
            return (!IsEmployee(recipient) && ParseAmount(giftCardAmount.Text) >= 600) || (!IsEmployee(recipient) && sixHundred.SelectedValue == "Yes");
        }

        // All of the following methods of the format "ClearInternalFormNFields" will clear the file name, content, and URL fields for the W-9 and approval document
        // for their respective forms.

        // Clears the internal fields of form 1
        protected void ClearInternalForm1Fields() 
        {
            w9Outcome.Text = "";
            w9Name.Text = "";
            w9Content.Text = "";
            approvalFileOutcome.Text = "";
            approvalFileName.Text = "";
            approvalFileContent.Text = "";
        }

        // Clears the internal fields of form 2
        protected void ClearInternalForm2Fields() 
        {
            w92Outcome.Text = "";
            w92Name.Text = "";
            w92Content.Text = "";
            approvalFile2Outcome.Text = "";
            approvalFile2Name.Text = "";
            approvalFile2Content.Text = "";
        }

        // Clears the internal fields of form 3
        protected void ClearInternalForm3Fields() 
        {
            w93Outcome.Text = "";
            w93Name.Text = "";
            w93Content.Text = "";
            approvalFile3Outcome.Text = "";
            approvalFile3Name.Text = "";
            approvalFile3Content.Text = "";
        }

        // Clears the internal fields of form 4
        protected void ClearInternalForm4Fields() 
        {
            w94Outcome.Text = "";
            w94Name.Text = "";
            w94Content.Text = "";
            approvalFile4Outcome.Text = "";
            approvalFile4Name.Text = "";
            approvalFile4Content.Text = "";
        }

        // Clears the internal fields of form 5
        protected void ClearInternalForm5Fields() 
        {
            w95Outcome.Text = "";
            w95Name.Text = "";
            w95Content.Text = "";
            approvalFile5Outcome.Text = "";
            approvalFile5Name.Text = "";
            approvalFile5Content.Text = "";
        }

        // Clears the internal fields of form 6
        protected void ClearInternalForm6Fields() 
        {
            w96Outcome.Text = "";
            w96Name.Text = "";
            w96Content.Text = "";
            approvalFile6Outcome.Text = "";
            approvalFile6Name.Text = "";
            approvalFile6Content.Text = "";
        }

        // Clears the internal fields of form 7
        protected void ClearInternalForm7Fields() 
        {
            w97Outcome.Text = "";
            w97Name.Text = "";
            w97Content.Text = "";
            approvalFile7Outcome.Text = "";
            approvalFile7Name.Text = "";
            approvalFile7Content.Text = "";
        }

        // Clears the internal fields of form 8
        protected void ClearInternalForm8Fields() 
        {
            w98Outcome.Text = "";
            w98Name.Text = "";
            w98Content.Text = "";
            approvalFile8Outcome.Text = "";
            approvalFile8Name.Text = "";
            approvalFile8Content.Text = "";
        }

        // Clears the internal fields of form 9
        protected void ClearInternalForm9Fields() 
        {
            w99Outcome.Text = "";
            w99Name.Text = "";
            w99Content.Text = "";
            approvalFile9Outcome.Text = "";
            approvalFile9Name.Text = "";
            approvalFile9Content.Text = "";
        }

        // Clears the internal fields of form 10
        protected void ClearInternalForm10Fields() 
        {
            w910Outcome.Text = "";
            w910Name.Text = "";
            w910Content.Text = "";
            approvalFile10Outcome.Text = "";
            approvalFile10Name.Text = "";
            approvalFile10Content.Text = "";
        }

        // Determines if the Yes/No radio buttons determining if the recipient is an employee
        // were selected. Returns true if Yes/No and false if not, as well as on error.
        protected bool IsStatusChosen(RadioButtonList recipient)
        {
            try
            {
                return !IsNullEmptyOrWhitespace(recipient.SelectedValue);
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Determines if there are at least 4 business days from today to the desired date
        protected bool IsValidFourDaySpan(DateTime today, DateTime desiredDate)
        {
            try
            {
                // Do not allow the user to proceed if the span of days does not include at least 4 business days
                if (today.DayOfWeek == DayOfWeek.Tuesday && desiredDate.DayOfWeek == DayOfWeek.Saturday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Wednesday && desiredDate.DayOfWeek == DayOfWeek.Sunday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Thursday && desiredDate.DayOfWeek == DayOfWeek.Monday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Friday && desiredDate.DayOfWeek == DayOfWeek.Tuesday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Saturday && desiredDate.DayOfWeek == DayOfWeek.Wednesday)
                {
                    return false;
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Determines if there are at least 4 business days from today to the desired date
        // Returns true if there is and false otherwise.
        protected bool IsValidFiveDaySpan(DateTime today, DateTime desiredDate)
        {
            try
            {
                // Do not allow the user to proceed if the span of days does not include at least 4 business days
                if (today.DayOfWeek == DayOfWeek.Monday && desiredDate.DayOfWeek == DayOfWeek.Saturday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Tuesday && desiredDate.DayOfWeek == DayOfWeek.Sunday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Wednesday && desiredDate.DayOfWeek == DayOfWeek.Monday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Thursday && desiredDate.DayOfWeek == DayOfWeek.Tuesday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Friday && desiredDate.DayOfWeek == DayOfWeek.Wednesday)
                {
                    return false;
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Determines if there are at least 4 business days from today to the desired date
        // Any span that ends on a business day at least 7 days away is always valid.
        protected bool IsValidSixDaySpan(DateTime today, DateTime desiredDate)
        {
            try
            {
                // Do not allow the user to proceed if the span of days does not include at least 4 business days
                if (today.DayOfWeek == DayOfWeek.Sunday && desiredDate.DayOfWeek == DayOfWeek.Saturday)
                {
                    return false;
                }
                else if (today.DayOfWeek == DayOfWeek.Monday && desiredDate.DayOfWeek == DayOfWeek.Sunday)
                {
                    return false;
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Parses the date from its textbox
        // toParse can be any textbox holding a date,
        // formatted as MM/DD/YYYY.
        // Returns null on error.
        protected int[] ParseDate(System.Web.UI.WebControls.TextBox toParse)
        {
            try
            {
                // We will store the parsed numbers in here
                int[] formattedDate = new int[3];

                // Grab the text from the date picker
                string original = toParse.Text;

                // Isolate each number of the date
                string[] parts = original.Split('/');
                for (int i = 0; i < parts.Length; i++)
                {
                    // Attempt to parse each number of the date; return null on error
                    if (!int.TryParse(parts[i], out formattedDate[i]))
                    {
                        return null;
                    }
                }
                // Return the formatted date array on success
                return formattedDate;
            }
            catch (Exception)
            {
                return null;
            }
        }

        // Determines if a given day for request is Monday through Friday and at least 4 business days away
        // Returns true on success and false on failure.
        protected bool IsValidBusinessDay(System.Web.UI.WebControls.TextBox toParse)
        {
            try
            {
                // Determine the difference between today and the desired date
                DateTime today = DateTime.Now;
                int[] formattedDate = ParseDate(toParse);

                // Do not proceed if the date is invalid
                if (formattedDate == null)
                {
                    return false;
                }

                // Find the difference between today and the desired date
                DateTime desiredDate = new DateTime(formattedDate[2], formattedDate[0], formattedDate[1]);
                TimeSpan interval = desiredDate.Subtract(today);

                // Do not allow the user to place a request if s/he chose today or a date prior to today
                if (interval.TotalSeconds <= 0)
                {
                    return false;
                }

                // Do not allow the user to proceed if the desired date is not a business day.
                // These kinds of days are invalid no matter how far away they fall.
                if (desiredDate.DayOfWeek == DayOfWeek.Saturday || desiredDate.DayOfWeek == DayOfWeek.Sunday)
                {
                    return false;
                }

                // Do not allow the user to proceed if the desired date is less than 4 days away
                if (Math.Ceiling(interval.TotalDays) < 4)
                {
                    return false;
                }
                else if (Math.Ceiling(interval.TotalDays) == 4)
                {
                    return IsValidFourDaySpan(today, desiredDate);
                }
                else if (Math.Ceiling(interval.TotalDays) == 5)
                {
                    return IsValidFiveDaySpan(today, desiredDate);
                }
                else if (Math.Ceiling(interval.TotalDays) == 6)
                {
                    return IsValidSixDaySpan(today, desiredDate);
                }
                // Spans that are at least 7 days away that end on a business day are always valid
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Determines if a textbox contains valid characters
        protected bool IsNameValid(System.Web.UI.WebControls.TextBox tb)
        {
            try
            {
                return Regex.IsMatch(tb.Text, @"^[\w\-'\s]+$");
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Modified slightly from the String.IsNullOrWhiteSpace() method, which is not included in this framework.
        // Returns true if the string consists entirely of whitespace characters and false otherwise.
        public bool IsWhitespace(String value)
        {
            for (int i = 0; i < value.Length; i++)
            {
                if (!Char.IsWhiteSpace(value[i]))
                {
                    return false;
                }
            }

            return true;
        }

        // Determine if a textbox is null, empty, or whitespace; 
        // my own version of String.IsNullOrEmpty() combined with
        // my modified version of String.IsNullOrWhiteSpace(), 
        // the second of which does not exist in this framework.
        protected bool IsNullEmptyOrWhitespace(string str)
        {
            try
            {
                return String.IsNullOrEmpty(str) || IsWhitespace(str);
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Match an email to a regular expression to determine if it is valid (valid: myname@example.com | invalid: this is my email)
        protected bool IsEmailValid()
        {
            try
            {
                return Regex.IsMatch(this.email.Text, @"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Checks to see if the gift card amount is valid,
        // e.g. it is at least 10 and at most 1,000
        protected bool IsValidValue(decimal value)
        {
            return value >= 10 && value <= 1000;
        }

        // Check for errors. A perfect form with no errors returns a null string. A nonnull string indicates there is at least one error that must be fixed.
        protected string CheckForErrors(System.Web.UI.WebControls.TextBox nameOfRecipient, RadioButtonList typeOfRecipient, DropDownList employeeBranch, System.Web.UI.WebControls.TextBox otherTypeOfRecipient, RadioButtonList sixHundred, FileUpload w9Form,
            System.Web.UI.WebControls.TextBox giftCardAmount, RadioButtonList giftCardSelection, System.Web.UI.WebControls.TextBox typeOfGiftCard, System.Web.UI.WebControls.TextBox giftCardPurpose, System.Web.UI.WebControls.TextBox streetAddress, System.Web.UI.WebControls.TextBox apartmentOrSuite, System.Web.UI.WebControls.TextBox city, System.Web.UI.WebControls.TextBox state,
            System.Web.UI.WebControls.TextBox zip, RadioButtonList approver, System.Web.UI.WebControls.TextBox otherApprover, FileUpload approvalForm, System.Web.UI.WebControls.TextBox dateNeededBy, int index)
        {
            try
            {
                // String to display on alert if there was at least one error
                string errorString = "";

                // The number of errors accounted for
                UInt32 errors = 0;

                // See if the names are valid
                if (!IsNameValid(requester))
                {
                    errorString += "You did not enter a valid requester name.<br />";
                    errors++;
                }

                // See if the email address text box has been filled in with an invalid value
                if (!IsEmailValid() || IsNullEmptyOrWhitespace(email.Text))
                {
                    errorString += "You did not enter a valid email address.<br />";
                    errors++;
                }

                // See if the recipient's first and last names are valid
                if (!IsNameValid(nameOfRecipient) || IsNullEmptyOrWhitespace(nameOfRecipient.Text))
                {
                    errorString += "You did not enter a valid name for the recipient.<br />";
                    errors++;
                }

                // See if a choice was chosen
                if (!IsStatusChosen(typeOfRecipient))
                {
                    errorString += "You did not choose a recipient type.<br />";
                    errors++;
                }

                // See if a non-employee needs a W-9
                if (IsStatusChosen(typeOfRecipient) && !IsEmployee(typeOfRecipient) && IsNullEmptyOrWhitespace(sixHundred.SelectedValue))
                {
                    errorString += "You did not choose whether this non-employee recipient needs a W-9 form.<br />";
                    errors++;
                }

                // See if an employee needs a branch
                if (IsStatusChosen(typeOfRecipient) && IsEmployee(typeOfRecipient) && IsNullEmptyOrWhitespace(employeeBranch.SelectedValue))
                {
                    errorString += "You did not choose an employee branch.<br />";
                    errors++;
                }

                // See if the "Other Recipient" field is filled
                if (typeOfRecipient.SelectedValue.Equals("No", StringComparison.OrdinalIgnoreCase) && IsNullEmptyOrWhitespace(otherTypeOfRecipient.Text))
                {
                    errorString += "You did not enter a value for the “Other Recipient” field.<br />";
                    errors++;
                }

                // See if an entered dollar amount is valid
                if (!IsValidValue(ParseAmount(giftCardAmount.Text)) || IsNullEmptyOrWhitespace(giftCardAmount.Text))
                {
                    errorString += "You did not enter a valid dollar amount.<br />";
                    errors++;
                }

                // See if the user entered a valid gift card type
                if (IsNullEmptyOrWhitespace(giftCardSelection.SelectedValue))
                {
                    errorString += "You did not enter a valid gift card type.<br />";
                    errors++;
                }

                // See if an alternative gift card type was entered if it wasn't American Express
                if (giftCardSelection.SelectedValue == "Other" && IsNullEmptyOrWhitespace(typeOfGiftCard.Text))
                {
                    errorString += "You did not enter a valid alternative gift card type.<br />";
                    errors++;
                }

                // See if the user attached a W-9 if the request warrants it
                if (NeedsW9(typeOfRecipient, sixHundred, giftCardAmount) && IsNullEmptyOrWhitespace(FindW9Content(index)))
                {
                    errorString += "You did not submit a W-9 form.<br />";
                    errors++;
                }

                // See if a purpose was given
                if (IsNullEmptyOrWhitespace(giftCardPurpose.Text))
                {
                    errorString += "You did not enter a valid purpose.<br />";
                    errors++;
                }

                // See if a choice was chosen
                if (IsNullEmptyOrWhitespace(approver.SelectedValue))
                {
                    errorString += "You did not choose valid approval credentials.<br />";
                    errors++;
                }

                // See if the "Other Approval" field is filled
                if (approver.SelectedValue.Equals("Other", StringComparison.OrdinalIgnoreCase) && IsNullEmptyOrWhitespace(otherApprover.Text))
                {
                    errorString += "You did not enter a value for the “Other Approval” field.<br />";
                    errors++;
                }

                // See if the user attached a document showing approval
                if (IsNullEmptyOrWhitespace(FindApprovalContent(index)))
                {
                    errorString += "You did not submit a valid approval form.<br />";
                    errors++;
                }

                // Check to see if a valid business day 
                // that is at least 4 business days away has been chosen
                if (!IsValidBusinessDay(dateNeededBy))
                {
                    errorString += "You did not choose a valid business day.<br />";
                    errors++;
                }

                // Prepare a header for the error alert
                string headerString = "We have encountered the following error";

                if (errors > 1)
                {
                    headerString += "s";
                }

                headerString += " in your request:<br />";

                // Append the error descriptions to the header
                headerString += errorString;

                // Return the number of errors, if any; otherwise return null
                if (errors > 0)
                {
                    errorForms.Text += index.ToString() + " ";
                    return headerString;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        // Generates a new form based on which ones are visible or not.
        protected void btnAnother_Click(object sender, EventArgs e)
        {
            if (!form2.Visible)
            {
                form2.Visible = true;
                EnableForm2();
            }
            else if (!form3.Visible)
            {
                form3.Visible = true;
                EnableForm3();
            }
            else if (!form4.Visible)
            {
                form4.Visible = true;
                EnableForm4();
            }
            else if (!form5.Visible)
            {
                form5.Visible = true;
                EnableForm5();
            }
            else if (!form6.Visible)
            {
                form6.Visible = true;
                EnableForm6();
            }
            else if (!form7.Visible)
            {
                form7.Visible = true;
                EnableForm7();
            }
            else if (!form8.Visible)
            {
                form8.Visible = true;
                EnableForm8();
            }
            else if (!form9.Visible)
            {
                form9.Visible = true;
                EnableForm9();
            }
            else if (!form10.Visible)
            {
                form10.Visible = true;
                EnableForm10();
            }

        }

        // Clears and gets rid of form #2
        protected void btnClear2_Click(object sender, EventArgs e)
        {
            name2.Text = "";
            amount2.Text = "";
            otherGiftCardType2.Text = "";
            purpose2.Text = "";
            streetAddress2.Text = "";
            aptNumber2.Text = "";
            city2.Text = "";
            state2.Text = "";
            zipCode2.Text = "";
            otherApprovalText2.Text = "";
            date2.Text = "";
            w92Name.Text = "";
            w92Content.Text = "";
            w92Url.Text = "";
            w92Outcome.Text = "";
            w92Outcome.Visible = false;
            approvalFile2Name.Text = "";
            approvalFile2Content.Text = "";
            approvalFile2Url.Text = "";
            approvalFile2Outcome.Text = "";
            approvalFile2Outcome.Visible = false;
            form2.Visible = false;
            DisableForm2();
        }

        // Clears and gets rid of form #3
        protected void btnClear3_Click(object sender, EventArgs e)
        {
            name3.Text = "";
            amount3.Text = "";
            otherGiftCardType3.Text = "";
            purpose3.Text = "";
            streetAddress3.Text = "";
            aptNumber3.Text = "";
            city3.Text = "";
            state3.Text = "";
            zipCode3.Text = "";
            otherApprovalText3.Text = "";
            date3.Text = "";
            w93Name.Text = "";
            w93Content.Text = "";
            w93Url.Text = "";
            w93Outcome.Text = "";
            w93Outcome.Visible = false;
            approvalFile3Name.Text = "";
            approvalFile3Content.Text = "";
            approvalFile3Url.Text = "";
            approvalFile3Outcome.Text = "";
            approvalFile3Outcome.Visible = false;
            form3.Visible = false;
            DisableForm3();
        }

        // Clears and gets rid of form #4
        protected void btnClear4_Click(object sender, EventArgs e)
        {
            name4.Text = "";
            amount4.Text = "";
            otherGiftCardType4.Text = "";
            purpose4.Text = "";
            streetAddress4.Text = "";
            aptNumber4.Text = "";
            city4.Text = "";
            state4.Text = "";
            zipCode4.Text = "";
            otherApprovalText4.Text = "";
            date4.Text = "";
            w94Name.Text = "";
            w94Content.Text = "";
            w94Url.Text = "";
            w94Outcome.Text = "";
            w94Outcome.Visible = false;
            approvalFile4Name.Text = "";
            approvalFile4Content.Text = "";
            approvalFile4Url.Text = "";
            approvalFile4Outcome.Text = "";
            approvalFile4Outcome.Visible = false;
            form4.Visible = false;
            DisableForm4();
        }

        // Clears and gets rid of form #5
        protected void btnClear5_Click(object sender, EventArgs e)
        {
            name5.Text = "";
            amount5.Text = "";
            otherGiftCardType5.Text = "";
            purpose5.Text = "";
            streetAddress5.Text = "";
            aptNumber5.Text = "";
            city5.Text = "";
            state5.Text = "";
            zipCode5.Text = "";
            otherApprovalText5.Text = "";
            date5.Text = "";
            w95Name.Text = "";
            w95Content.Text = "";
            w95Url.Text = "";
            w95Outcome.Text = "";
            w95Outcome.Visible = false;
            approvalFile5Name.Text = "";
            approvalFile5Content.Text = "";
            approvalFile5Url.Text = "";
            approvalFile5Outcome.Text = "";
            approvalFile5Outcome.Visible = false;
            form5.Visible = false;
            DisableForm5();
        }

        // Clears and gets rid of form #6
        protected void btnClear6_Click(object sender, EventArgs e)
        {
            name6.Text = "";
            amount6.Text = "";
            otherGiftCardType6.Text = "";
            purpose6.Text = "";
            streetAddress6.Text = "";
            aptNumber6.Text = "";
            city6.Text = "";
            state6.Text = "";
            zipCode6.Text = "";
            otherApprovalText6.Text = "";
            date6.Text = "";
            w96Name.Text = "";
            w96Content.Text = "";
            w96Url.Text = "";
            w96Outcome.Text = "";
            w96Outcome.Visible = false;
            approvalFile6Name.Text = "";
            approvalFile6Content.Text = "";
            approvalFile6Url.Text = "";
            approvalFile6Outcome.Text = "";
            approvalFile6Outcome.Visible = false;
            form6.Visible = false;
            DisableForm6();
        }

        // Clears and gets rid of form #7
        protected void btnClear7_Click(object sender, EventArgs e)
        {
            name7.Text = "";
            amount7.Text = "";
            otherGiftCardType7.Text = "";
            purpose7.Text = "";
            streetAddress7.Text = "";
            aptNumber7.Text = "";
            city7.Text = "";
            state7.Text = "";
            zipCode7.Text = "";
            otherApprovalText7.Text = "";
            date7.Text = "";
            w97Name.Text = "";
            w97Content.Text = "";
            w97Url.Text = "";
            w97Outcome.Text = "";
            w97Outcome.Visible = false;
            approvalFile7Name.Text = "";
            approvalFile7Content.Text = "";
            approvalFile7Url.Text = "";
            approvalFile7Outcome.Text = "";
            approvalFile7Outcome.Visible = false;
            form7.Visible = false;
            DisableForm7();
        }

        // Clears and gets rid of form #8
        protected void btnClear8_Click(object sender, EventArgs e)
        {
            name8.Text = "";
            amount8.Text = "";
            otherGiftCardType8.Text = "";
            purpose8.Text = "";
            streetAddress8.Text = "";
            aptNumber8.Text = "";
            city8.Text = "";
            state8.Text = "";
            zipCode8.Text = "";
            otherApprovalText8.Text = "";
            date8.Text = "";
            w98Name.Text = "";
            w98Content.Text = "";
            w98Url.Text = "";
            w98Outcome.Text = "";
            w98Outcome.Visible = false;
            approvalFile8Name.Text = "";
            approvalFile8Content.Text = "";
            approvalFile8Url.Text = "";
            approvalFile8Outcome.Text = "";
            approvalFile8Outcome.Visible = false;
            form8.Visible = false;
            DisableForm8();
        }

        // Clears and gets rid of form #9
        protected void btnClear9_Click(object sender, EventArgs e)
        {
            name9.Text = "";
            amount9.Text = "";
            otherGiftCardType9.Text = "";
            purpose9.Text = "";
            streetAddress9.Text = "";
            aptNumber9.Text = "";
            city9.Text = "";
            state9.Text = "";
            zipCode9.Text = "";
            otherApprovalText9.Text = "";
            date9.Text = "";
            w99Name.Text = "";
            w99Content.Text = "";
            w99Url.Text = "";
            w99Outcome.Text = "";
            w99Outcome.Visible = false;
            approvalFile9Name.Text = "";
            approvalFile9Content.Text = "";
            approvalFile9Url.Text = "";
            approvalFile9Outcome.Text = "";
            approvalFile9Outcome.Visible = false;
            form9.Visible = false;
            DisableForm9();
        }

        // Clears and gets rid of form #10
        protected void btnClear10_Click(object sender, EventArgs e)
        {
            name10.Text = "";
            amount10.Text = "";
            otherGiftCardType10.Text = "";
            purpose10.Text = "";
            streetAddress10.Text = "";
            aptNumber10.Text = "";
            city10.Text = "";
            state10.Text = "";
            zipCode10.Text = "";
            otherApprovalText4.Text = "";
            date10.Text = "";
            w910Name.Text = "";
            w910Content.Text = "";
            w910Url.Text = "";
            w910Outcome.Text = "";
            w910Outcome.Visible = false;
            approvalFile10Name.Text = "";
            approvalFile10Content.Text = "";
            approvalFile10Url.Text = "";
            approvalFile10Outcome.Text = "";
            approvalFile10Outcome.Visible = false;
            form10.Visible = false;
            DisableForm10();
        }

        // Handles a cancelled edit on the All Entries table (GridViewCancelEditEventArgs)
        protected void allgridTop_RowCancelingEdit(object sender, EventArgs e)
        {
            //Reset the edit index.
            allgridTop.EditIndex = -1;
            //Bind data to the GridView control.
            BindData();

            // Set the edit column invisible
            allgridTop.Columns[22].Visible = false;
        }

        // Handles a cancelled edit on the All Entries table
        protected void allgridBottom_RowCancelingEdit(object sender, EventArgs e)
        {
            //Reset the edit index.
            allgridBottom.EditIndex = -1;
            //Bind data to the GridView control.
            BindData();

            allgridTop.Columns[9].Visible = false;
        }

        // Binds data to the tables and refreshes them
        private void BindData()
        {
            try
            {
                mygrid.DataSource = dt;
                mygrid.DataBind();
                allgridTop.DataSource = alldtTop;
                allgridTop.Columns[22].Visible = false;
                allgridTop.DataBind();
                allgridBottom.Columns[9].Visible = false;
                allgridBottom.DataSource = alldtBottom;
                allgridBottom.DataBind();

                // Get the site and list to read from
                SPSite _SPSite = new SPSite(guidSite);
                SPWeb _SPweb = _SPSite.OpenWeb();
                SPList _SPlist = _SPweb.Lists["GifrCardRecords"];

                // Load only the current user's requests
                LoadMyRequests(_SPSite, _SPweb, _SPlist);

                // Load every user's request
                LoadAllRequests(_SPSite, _SPweb, _SPlist);

            }
            catch (Exception)
            {
                return;
            }
        }

        // Called when the user decides to edit an entry
        protected void allgridTop_RowEditing(object sender, GridViewEditEventArgs e)
        {
            allgridTop.EditIndex = e.NewEditIndex;
            BindData();
            allgridTop.Rows[e.NewEditIndex].Attributes.Remove("ondblclick");
            allgridTop.Columns[22].Visible = true;

        }

        // Called when the user decides to edit an entry
        protected void allgridBottom_RowEditing(object sender, GridViewEditEventArgs e)
        {
            allgridBottom.EditIndex = e.NewEditIndex;
            BindData();
            allgridBottom.Rows[e.NewEditIndex].Attributes.Remove("ondblclick");
            allgridBottom.Columns[9].Visible = true;

        }

        // (System.Web.UI.WebControls.GridViewRowEventArgs)
        protected void allgridTop_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["ondblclick"] = Page.ClientScript.GetPostBackClientHyperlink(allgridTop, "Edit$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
                for (int index = 0; index <= 2; index++)
                {
                    if (allgridTop.Columns[index] is BoundField)
                    {
                        (allgridTop.Columns[index] as BoundField).ReadOnly = true;
                    }
                }
            }
        }

        // Called when the Site Owner edits the bottom grid
        protected void allgridBottom_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["ondblclick"] = Page.ClientScript.GetPostBackClientHyperlink(allgridBottom, "Edit$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        // Called when the Site Owner updates the top grid
        protected void allgridTop_RowUpdating(object sender, EventArgs e)
        {
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;

            string email = (row.Cells[3].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string requesterName = (row.Cells[4].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string recipientName = (row.Cells[5].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string recipientStatus = (row.Cells[6].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string branch = (row.Cells[7].Controls[1] as DropDownList).SelectedValue;
            string sixHundred = (row.Cells[8].Controls[1] as DropDownList).SelectedValue;
            string amount = (row.Cells[9].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string type = (row.Cells[11].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string purpose = (row.Cells[12].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string approvedBy = (row.Cells[13].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string dateNeededBy = (row.Cells[15].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string address = (row.Cells[16].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string apartment = (row.Cells[17].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string city = (row.Cells[18].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string state = (row.Cells[19].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string zip = (row.Cells[20].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string requestStatus = (row.Cells[21].Controls[1] as DropDownList).SelectedValue;

            string[] values = {email, requesterName, recipientName, recipientStatus, branch, sixHundred, amount, null, type, purpose,
                              approvedBy, null, dateNeededBy, address, apartment, city, state, zip, requestStatus};

            UpdateTopRecord(row.DataItemIndex, values);

            allgridTop.EditIndex = -1;

            this.BindData();
        }

        // Called when the site owner updates the bottom grid
        protected void allgridBottom_RowUpdating(object sender, EventArgs e)
        {
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;

            string vendorPurchasedFrom = (row.Cells[0].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string datePurchased = (row.Cells[1].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string purchasedBy = (row.Cells[2].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string serialNumber = (row.Cells[3].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string dateGiven = (row.Cells[4].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string personGivenTo = (row.Cells[5].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string dateInfoSentToPayroll = (row.Cells[6].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string w9Received = (row.Cells[7].Controls[1] as System.Web.UI.WebControls.TextBox).Text;
            string notes = (row.Cells[8].Controls[1] as System.Web.UI.WebControls.TextBox).Text;

            string[] values = { vendorPurchasedFrom, datePurchased, purchasedBy, serialNumber, dateGiven, personGivenTo, dateInfoSentToPayroll, w9Received, notes };

            UpdateBottomRecord(row.DataItemIndex, values);

            allgridBottom.EditIndex = -1;

            this.BindData();
        }

        // Called when the Site Owner cancels an edit on the top grid
        protected void allgridTop_OnCancel(object sender, EventArgs e)
        {
            allgridTop.EditIndex = -1;
            this.BindData();
        }

        // Called when the Site Owner cancels an edit on the bottom grid
        protected void allgridBottom_OnCancel(object sender, EventArgs e)
        {
            allgridBottom.EditIndex = -1;
            this.BindData();
        }

        // This updates the "top" part of the record directly in SharePoint
        protected void UpdateTopRecord(int index, string[] values)
        {
            try
            {
                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        // Attempt to open the gift card record database (spelling error was made on creation)
                        SPList list = web.Lists.TryGetList("GifrCardRecords");
                        if (list != null)
                        {
                            int i = 0;
                            SPListItemCollection collection = list.GetItems();
                            foreach (SPListItem item in collection)
                            {
                                // Find the chosen record and modify its field accordingly
                                // Only works one at a time
                                if (i == index)
                                {
                                    item["EmailAddress"] = values[0];
                                    item["RequesterName"] = values[1];
                                    item["RecipientName"] = values[2];
                                    item["RecipientStatus"] = values[3];
                                    item["Branch"] = values[4];
                                    item["ReceivedSixHundred"] = values[5];
                                    item["GiftCardAmount"] = values[6];
                                    //item["W9"] = values[7];
                                    item["GiftCardType"] = values[8];
                                    item["Purpose"] = values[9];
                                    item["ApprovedBy"] = values[10];
                                    //item["ApprovalDocument"] = values[11];
                                    item["DateNeededBy"] = values[12];
                                    item["StreetAddress"] = values[13];
                                    item["ApartmentNumber"] = values[14];
                                    item["City"] = values[15];
                                    item["State"] = values[16];
                                    item["ZIPCode"] = values[17];
                                    item["Status"] = values[18];
                                    item.Update();
                                    return;
                                }
                                i++;
                            }
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(e.Message);
            }
        }

        // This updates the "bottom" part of the record directly in SharePoint
        protected void UpdateBottomRecord(int index, string[] values)
        {
            try
            {
                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        // Attempt to open the gift card record database (spelling error was made on creation)
                        SPList list = web.Lists.TryGetList("GifrCardRecords");
                        if (list != null)
                        {
                            int i = 0;
                            SPListItemCollection collection = list.GetItems();
                            foreach (SPListItem item in collection)
                            {
                                // Find the chosen record and modify its field accordingly
                                // Only works one at a time
                                if (i == index)
                                {
                                    item["VendorPurchasedFrom"] = values[0];
                                    item["DatePurchased"] = values[1];
                                    item["PurchasedBy"] = values[2];
                                    item["GiftCardSerialNumber"] = values[3];
                                    item["DateGiven"] = values[4];
                                    item["PersonGivenTo"] = values[5];
                                    item["DateInfoSentToPayroll"] = values[6];
                                    item["W9Received"] = values[7];
                                    item["Notes"] = values[8];
                                    item.Update();
                                    return;
                                }
                                i++;
                            }
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(e.Message);
                return;
            }
        }

        // Handles an event once the page index is changed.
        // Serves no purpose for this program.
        protected void allgridTop_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            allgridTop.PageIndex = e.NewPageIndex;

            BindData();
        }

        protected void allgridBottom_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            allgridBottom.PageIndex = e.NewPageIndex;

            BindData();
        }

        // Handles the click of the "Show/Hide Requester Information" button
        // on the All Requests tab.
        // Toggles visibility of the top grid and changes the button text.
        protected void requesterButton_Click(object sender, EventArgs e)
        {
            if (topGrid.Visible)
            {
                topGrid.Visible = false;
                requesterButton.Text = "Show Requester Information";
            }
            else
            {
                topGrid.Visible = true;
                requesterButton.Text = "Hide Requester Information";
            }
        }

        // Handles the click of the "Show/Hide Purchaser Information" button
        // on the All Requests tab.
        // Toggles visibility of the bottom grid and changes the button text.
        protected void purchaserButton_Click(object sender, EventArgs e)
        {
            if (bottomGrid.Visible)
            {
                bottomGrid.Visible = false;
                purchaserButton.Text = "Show Purchaser Information";
            }
            else
            {
                bottomGrid.Visible = true;
                purchaserButton.Text = "Hide Purchaser Information";
            }
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w9Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w9, ref w9Name, ref w9Content, ref w9Url, "W9s");
            w9Outcome.Text = "“" + w9Name.Text + "” was uploaded successfully!";
            cvW9.Enabled = false;
            w9Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFileUpload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile, ref approvalFileName, ref approvalFileContent, ref approvalFileUrl, "ApprovalDocuments");
            approvalFileOutcome.Text = "“" + approvalFileName.Text + "” was uploaded successfully!";
            cvApprovalFile.Enabled = false;
            approvalFileOutcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w92Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w92, ref w92Name, ref w92Content, ref w92Url, "W9s");
            w92Outcome.Text = "“" + w92Name.Text + "” was uploaded successfully!";
            cvW92.Enabled = false;
            w92Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile2Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile2, ref approvalFile2Name, ref approvalFile2Content, ref approvalFile2Url, "ApprovalDocuments");
            approvalFile2Outcome.Text = "“" + approvalFile2Name.Text + "” was uploaded successfully!";
            cvApprovalFile2.Enabled = false;
            approvalFile2Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w93Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w93, ref w93Name, ref w93Content, ref w93Url, "W9s");
            w93Outcome.Text = "“" + w93Name.Text + "” was uploaded successfully!";
            cvW93.Enabled = false;
            w93Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile3Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile3, ref approvalFile3Name, ref approvalFile3Content, ref approvalFile3Url, "ApprovalDocuments");
            approvalFile3Outcome.Text = "“" + approvalFile3Name.Text + "” was uploaded successfully!";
            cvApprovalFile3.Enabled = false;
            approvalFile3Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w94Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w94, ref w94Name, ref w94Content, ref w94Url, "W9s");
            w94Outcome.Text = "“" + w94Name.Text + "” was uploaded successfully!";
            cvW94.Enabled = false;
            w94Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile4Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile4, ref approvalFile4Name, ref approvalFile4Content, ref approvalFile4Url, "ApprovalDocuments");
            approvalFile4Outcome.Text = "“" + approvalFile4Name.Text + "” was uploaded successfully!";
            cvApprovalFile4.Enabled = false;
            approvalFile4Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w95Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w95, ref w95Name, ref w95Content, ref w95Url, "W9s");
            w95Outcome.Text = "“" + w95Name.Text + "” was uploaded successfully!";
            cvW95.Enabled = false;
            w95Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile5Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile5, ref approvalFile5Name, ref approvalFile5Content, ref approvalFile5Url, "ApprovalDocuments");
            approvalFile5Outcome.Text = "“" + approvalFile5Name.Text + "” was uploaded successfully!";
            cvApprovalFile5.Enabled = false;
            approvalFile5Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w96Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w96, ref w96Name, ref w96Content, ref w96Url, "W9s");
            w96Outcome.Text = "“" + w96Name.Text + "” was uploaded successfully!";
            cvW96.Enabled = false;
            w96Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile6Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile6, ref approvalFile6Name, ref approvalFile6Content, ref approvalFile6Url, "ApprovalDocuments");
            approvalFile6Outcome.Text = "“" + approvalFile6Name.Text + "” was uploaded successfully!";
            cvApprovalFile6.Enabled = false;
            approvalFile6Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w97Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w97, ref w97Name, ref w97Content, ref w97Url, "W9s");
            w97Outcome.Text = "“" + w97Name.Text + "” was uploaded successfully!";
            cvW97.Enabled = false;
            w97Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile7Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile7, ref approvalFile7Name, ref approvalFile7Content, ref approvalFile7Url, "ApprovalDocuments");
            approvalFile7Outcome.Text = "“" + approvalFile7Name.Text + "” was uploaded successfully!";
            cvApprovalFile7.Enabled = false;
            approvalFile7Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w98Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w98, ref w98Name, ref w98Content, ref w98Url, "W9s");
            w98Outcome.Text = "“" + w98Name.Text + "” was uploaded successfully!";
            cvW98.Enabled = false;
            w98Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile8Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile8, ref approvalFile8Name, ref approvalFile8Content, ref approvalFile8Url, "ApprovalDocuments");
            approvalFile8Outcome.Text = "“" + approvalFile8Name.Text + "” was uploaded successfully!";
            cvApprovalFile8.Enabled = false;
            approvalFile8Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w99Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w99, ref w99Name, ref w99Content, ref w99Url, "W9s");
            w99Outcome.Text = "“" + w99Name.Text + "” was uploaded successfully!";
            cvW99.Enabled = false;
            w99Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile9Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile9, ref approvalFile9Name, ref approvalFile9Content, ref approvalFile9Url, "ApprovalDocuments");
            approvalFile9Outcome.Text = "“" + approvalFile9Name.Text + "” was uploaded successfully!";
            cvApprovalFile9.Enabled = false;
            approvalFile9Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void w910Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref w910, ref w910Name, ref w910Content, ref w910Url, "W9s");
            w910Outcome.Text = "“" + w910Name.Text + "” was uploaded successfully!";
            cvW910.Enabled = false;
            w910Outcome.Visible = true;
        }

        // Methods of the form approvalFileNUpload_Click() or w9NUpload_Click() parse the uploaded document
        // and keep them on the page. These documents will stay until the form that contains it is submitted successfully.
        // e.g. if the user makes an error, the documents will stay on the page and not get deleted.
        // The message citing a successful upload will show and the validator for the field will be disabled.
        protected void approvalFile10Upload_Click(object sender, EventArgs e)
        {
            UploadFile(ref approvalFile10, ref approvalFile10Name, ref approvalFile10Content, ref approvalFile10Url, "ApprovalDocuments");
            approvalFile10Outcome.Text = "“" + approvalFile10Name.Text + "” was uploaded successfully!";
            cvApprovalFile10.Enabled = false;
            approvalFile10Outcome.Visible = true;
        }

        // Server-side validation procedures for required fields.
        // I chose not to use asp:RequiredFieldValidators because
        // there are multiple cirucumstances that can arise with
        // the recipient being an employee and not needing a W-9
        // but needing a branch,
        // or being a non-employee and needing a W-9 but not a branch.
        // The below methods all validate their respective conditions.
        // Most fields are required regardless.
        // These procedures are the same for all 10 forms.

        // Validates the email address textbox with a regular expression
        protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(email.Text) || !IsEmailValid())
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the requester textbox is filled
        protected void cvRequester_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(requester.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the recipient name textbox is filled
        protected void cvName_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(args.Value))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType) && IsNullEmptyOrWhitespace(branch.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType) && IsNullEmptyOrWhitespace(otherRecipient.Text))
            {
                cvOtherRecipient.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && IsEmployee(recipientType) && IsNullEmptyOrWhitespace(branch.SelectedValue))
            {
                cvOtherRecipient.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType) && IsNullEmptyOrWhitespace(yesNo.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType, yesNo, amount) && IsNullEmptyOrWhitespace(w9Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFileContent.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount.Text) || ParseAmount(amount.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date.Text) || !IsValidBusinessDay(date))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 2 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType2.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType2) && IsNullEmptyOrWhitespace(branch2.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType2.SelectedValue) && !IsEmployee(recipientType2) && IsNullEmptyOrWhitespace(otherRecipient2.Text))
            {
                cvOtherRecipient2.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType2.SelectedValue) && IsEmployee(recipientType2) && IsNullEmptyOrWhitespace(branch2.SelectedValue))
            {
                cvOtherRecipient2.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType2) && IsNullEmptyOrWhitespace(yesNo2.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW92_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType2, yesNo2, amount2) && IsNullEmptyOrWhitespace(w92Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile2Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount2.Text) || ParseAmount(amount2.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType2.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType2.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType2.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval2.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval2.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval2.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose2.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date2.Text) || !IsValidBusinessDay(date2))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 3 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType3.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType3) && IsNullEmptyOrWhitespace(branch3.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType3.SelectedValue) && !IsEmployee(recipientType3) && IsNullEmptyOrWhitespace(otherRecipient3.Text))
            {
                cvOtherRecipient3.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType3.SelectedValue) && IsEmployee(recipientType3) && IsNullEmptyOrWhitespace(branch3.SelectedValue))
            {
                cvOtherRecipient3.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType3) && IsNullEmptyOrWhitespace(yesNo3.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW93_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType3, yesNo3, amount3) && IsNullEmptyOrWhitespace(w93Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile3Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount3.Text) || ParseAmount(amount3.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType3.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType3.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType3.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval3.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval3.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval3.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose3.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date3.Text) || !IsValidBusinessDay(date3))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 4 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType4.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType4) && IsNullEmptyOrWhitespace(branch4.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType4.SelectedValue) && !IsEmployee(recipientType4) && IsNullEmptyOrWhitespace(otherRecipient4.Text))
            {
                cvOtherRecipient4.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType4.SelectedValue) && IsEmployee(recipientType4) && IsNullEmptyOrWhitespace(branch4.SelectedValue))
            {
                cvOtherRecipient4.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType4) && IsNullEmptyOrWhitespace(yesNo4.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW94_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType4, yesNo4, amount4) && IsNullEmptyOrWhitespace(w94Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile4Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount4.Text) || ParseAmount(amount4.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType4.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType4.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType4.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval4.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval4.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval4.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose4.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate4_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date4.Text) || !IsValidBusinessDay(date4))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 5 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType5.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType5) && IsNullEmptyOrWhitespace(branch5.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType5.SelectedValue) && !IsEmployee(recipientType5) && IsNullEmptyOrWhitespace(otherRecipient5.Text))
            {
                cvOtherRecipient5.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType5.SelectedValue) && IsEmployee(recipientType5) && IsNullEmptyOrWhitespace(branch5.SelectedValue))
            {
                cvOtherRecipient5.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType5) && IsNullEmptyOrWhitespace(yesNo5.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW95_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType5, yesNo5, amount5) && IsNullEmptyOrWhitespace(w95Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile5Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount5.Text) || ParseAmount(amount5.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType5.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType5.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType5.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval5.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval5.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval5.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose5.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void cvDate5_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date5.Text) || !IsValidBusinessDay(date5))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the recipient name textbox is filled
        protected void cvName6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType6.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType6) && IsNullEmptyOrWhitespace(branch6.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType6.SelectedValue) && !IsEmployee(recipientType6) && IsNullEmptyOrWhitespace(otherRecipient6.Text))
            {
                cvOtherRecipient6.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType6.SelectedValue) && IsEmployee(recipientType6) && IsNullEmptyOrWhitespace(branch6.SelectedValue))
            {
                cvOtherRecipient6.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType6) && IsNullEmptyOrWhitespace(yesNo6.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW96_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType6, yesNo6, amount6) && IsNullEmptyOrWhitespace(w96Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile6Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount6.Text) || ParseAmount(amount6.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType6.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType6.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType6.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval6.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval6.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval6.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose6.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate6_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date6.Text) || !IsValidBusinessDay(date6))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 6 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType7.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType7) && IsNullEmptyOrWhitespace(branch7.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType7.SelectedValue) && !IsEmployee(recipientType7) && IsNullEmptyOrWhitespace(otherRecipient7.Text))
            {
                cvOtherRecipient7.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType7.SelectedValue) && IsEmployee(recipientType7) && IsNullEmptyOrWhitespace(branch7.SelectedValue))
            {
                cvOtherRecipient7.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType7) && IsNullEmptyOrWhitespace(yesNo7.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW97_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType7, yesNo7, amount7) && IsNullEmptyOrWhitespace(w97Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile7Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount7.Text) || ParseAmount(amount7.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType7.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType7.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType7.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval7.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval7.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval7.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose7.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate7_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date7.Text) || !IsValidBusinessDay(date7))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 8 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType8.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType8) && IsNullEmptyOrWhitespace(branch8.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType8.SelectedValue) && !IsEmployee(recipientType8) && IsNullEmptyOrWhitespace(otherRecipient8.Text))
            {
                cvOtherRecipient8.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType8.SelectedValue) && IsEmployee(recipientType8) && IsNullEmptyOrWhitespace(branch8.SelectedValue))
            {
                cvOtherRecipient8.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType8) && IsNullEmptyOrWhitespace(yesNo8.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed        
        protected void cvW98_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType8, yesNo8, amount8) && IsNullEmptyOrWhitespace(w98Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile8Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount8.Text) || ParseAmount(amount8.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType8.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType8.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType8.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval8.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval8.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval8.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose8.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate8_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date8.Text) || !IsValidBusinessDay(date8))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 9 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType9.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType9) && IsNullEmptyOrWhitespace(branch9.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType9.SelectedValue) && !IsEmployee(recipientType9) && IsNullEmptyOrWhitespace(otherRecipient9.Text))
            {
                cvOtherRecipient9.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType9.SelectedValue) && IsEmployee(recipientType9) && IsNullEmptyOrWhitespace(branch9.SelectedValue))
            {
                cvOtherRecipient9.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType9) && IsNullEmptyOrWhitespace(yesNo9.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW99_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType9, yesNo9, amount9) && IsNullEmptyOrWhitespace(w99Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile9Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount9.Text) || ParseAmount(amount9.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType9.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType9.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType9.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval9.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval9.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval9.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose9.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate9_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date9.Text) || !IsValidBusinessDay(date9))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /* Form 10 validators */

        // Validates if the recipient name textbox is filled
        protected void cvName10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(name10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a recipient type has been chosen
        protected void cvRecipientType10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(recipientType10.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a branch has been chosen if the recipient is an employee
        protected void cvBranch10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsEmployee(recipientType10) && IsNullEmptyOrWhitespace(branch10.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the other recipient textbox is filled if needed
        protected void cvOtherRecipient10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType10.SelectedValue) && !IsEmployee(recipientType10) && IsNullEmptyOrWhitespace(otherRecipient10.Text))
            {
                cvOtherRecipient10.ErrorMessage = "Please enter the type of recipient";
                args.IsValid = false;
            }
            else if (!IsNullEmptyOrWhitespace(recipientType10.SelectedValue) && IsEmployee(recipientType10) && IsNullEmptyOrWhitespace(branch10.SelectedValue))
            {
                cvOtherRecipient10.ErrorMessage = "Please select a branch";
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if the yes/no field for W-9 submission is checked if needed
        protected void cvYesNo10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && !IsEmployee(recipientType10) && IsNullEmptyOrWhitespace(yesNo10.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates if a W-9 has been uploaded if needed
        protected void cvW910_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!IsNullEmptyOrWhitespace(recipientType.SelectedValue) && NeedsW9(recipientType10, yesNo10, amount10) && IsNullEmptyOrWhitespace(w910Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval file has been uploaded
        protected void cvApprovalFile10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approvalFile10Content.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a valid gift card amount has been entered
        protected void cvAmount10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(amount10.Text) || ParseAmount(amount10.Text) == -1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a gift card type has been chosen from its radio button list
        protected void cvGiftCardType10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType10.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative gift card type has been entered, if so desired
        protected void cvOtherGiftCardType10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(giftCardType10.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (giftCardType10.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherGiftCardType10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a street address has been entered
        protected void cvStreetAddress10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(streetAddress10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a city has been entered
        protected void cvCity10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(city10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a state has been entered
        protected void cvState10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(state10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a ZIP code has been entered
        protected void cvZipCode10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(zipCode10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an approval option has been selected
        protected void cvApproval10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval10.SelectedValue))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an alternative approval option has been entered
        protected void cvOtherApprovalText10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(approval10.SelectedValue))
            {
                args.IsValid = false;
            }
            else if (approval10.SelectedValue == "Other" && IsNullEmptyOrWhitespace(otherApprovalText10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that a purpose has been entered
        protected void cvPurpose10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(purpose10.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validates that an appropriate date has been entered
        protected void cvDate10_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsNullEmptyOrWhitespace(date10.Text) || !IsValidBusinessDay(date10))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Clear all of the invisible letter labels
        private void ClearLabels()
        {
            employeesA.Text = "";
            employeesB.Text = "";
            employeesC.Text = "";
            employeesD.Text = "";
            employeesE.Text = "";
            employeesF.Text = "";
            employeesG.Text = "";
            employeesH.Text = "";
            employeesI.Text = "";
            employeesJ.Text = "";
            employeesK.Text = "";
            employeesM.Text = "";
            employeesN.Text = "";
            employeesO.Text = "";
            employeesP.Text = "";
            employeesQ.Text = "";
            employeesR.Text = "";
            employeesS.Text = "";
            employeesT.Text = "";
            employeesU.Text = "";
            employeesV.Text = "";
            employeesW.Text = "";
            employeesX.Text = "";
            employeesY.Text = "";
            employeesZ.Text = "";
        }

        // Converts a list into a string, with each element delimited by tildes ("~").
        // For example, "Jones, Tom~Smith, Jedediah"
        private string ListToString(System.Collections.Generic.List<string> list)
        {
            string final = "";

            for (int index = 0; index < list.Count; index++)
            {
                if (index > 0)
                {
                    final += "~";
                }
                final += list[index].ToString();
            }
            return final;
        }

        // Loads the names of employees into hidden labels
        // to be parsed by JavaScript into an autocomplete widget.
        protected void LoadNames() 
        {
            System.Collections.Generic.List<string> names = new System.Collections.Generic.List<string>();
            // Load all the names into the active directory
            using (SPSite site = new SPSite("http://njspdevd01:2544/nhesaf/"))
            {
                using (SPWeb web = site.OpenWeb())
                {
                    SPList odoclib = web.Lists["Employees"];
                    if (odoclib != null && odoclib.ItemCount > 0)
                    {
                        SPListItemCollection listitemcoll = odoclib.GetItems();

                        // Clear out the labels to accommodate potentially new and different names from the last time this form was accessed
                        ClearLabels();

                        // Start at the letter A and go all the way to Z
                        int index = 0;
                        char letter = 'A';
                        System.Collections.Generic.List<string> group = new System.Collections.Generic.List<string>();
                        if (listitemcoll != null && listitemcoll.Count > 0)
                        {
                            foreach (SPListItem item in listitemcoll)
                            {
                                string nextName = item["Title"].ToString();
                                names.Add(nextName);
                            }

                            // Sort the names array; it could be out of order
                            names.Sort();

                            while (index < names.Count)
                            {
                                // Clear out the group list for the next letter
                                group.Clear();


                                while (names[index][0] == letter) // Loop letter by letter
                                {
                                    // Keep adding the next name if it starts with the current letter
                                    group.Add(names[index]);
                                    index++;
                                    if (index >= names.Count)
                                    {
                                        break;
                                    }
                                }
                                // Turn this list into a long string
                                string list = ListToString(group);

                                // Add each string to its respective letter
                                switch (letter)
                                {
                                    case 'A': employeesA.Text += list;
                                        break;
                                    case 'B': employeesB.Text += list;
                                        break;
                                    case 'C': employeesC.Text += list;
                                        break;
                                    case 'D': employeesD.Text += list;
                                        break;
                                    case 'E': employeesE.Text += list;
                                        break;
                                    case 'F': employeesF.Text += list;
                                        break;
                                    case 'G': employeesG.Text += list;
                                        break;
                                    case 'H': employeesH.Text += list;
                                        break;
                                    case 'I': employeesI.Text += list;
                                        break;
                                    case 'J': employeesJ.Text += list;
                                        break;
                                    case 'K': employeesK.Text += list;
                                        break;
                                    case 'L': employeesL.Text += list;
                                        break;
                                    case 'M': employeesM.Text += list;
                                        break;
                                    case 'N': employeesN.Text += list;
                                        break;
                                    case 'O': employeesO.Text += list;
                                        break;
                                    case 'P': employeesP.Text += list;
                                        break;
                                    case 'Q': employeesQ.Text += list;
                                        break;
                                    case 'R': employeesR.Text += list;
                                        break;
                                    case 'S': employeesS.Text += list;
                                        break;
                                    case 'T': employeesT.Text += list;
                                        break;
                                    case 'U': employeesU.Text += list;
                                        break;
                                    case 'V': employeesV.Text += list;
                                        break;
                                    case 'W': employeesW.Text += list;
                                        break;
                                    case 'X': employeesX.Text += list;
                                        break;
                                    case 'Y': employeesY.Text += list;
                                        break;
                                    case 'Z': employeesZ.Text += list;
                                        break;
                                    default: break;
                                }

                                // Go to the next letter
                                letter++;
                            }
                        }
                    }
                }
            }
        }
    }
}