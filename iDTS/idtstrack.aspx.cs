using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;
using System.Data;
using System.Configuration;

namespace iDTS
{
    public partial class idtstrack : System.Web.UI.Page
    {
        protected string CurrentYear = DateTime.Now.Year.ToString();
        protected string constring()
        { 
            return ConfigurationManager.ConnectionStrings["dtsConnectionString"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            grdHistory.Visible = false;
            lblmsg.Visible = false;
            lbl_voucher.Visible = false;
            lbl_type.Visible = false;
            docDetails.Visible = false;
            docDetailsHead.Visible = false;
            
            lblmsg.Text = "";
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            if (txt_search.Text.Length == 0)
            {
                // the textbox is empty
                lblmsg.Visible = true;
                lblmsg.Text = "SEARCH BOX IS EMPTY!!!";
            }
            if (txt_search.Text.Length > 0)
            {

                int NoOfRec;
                
                SqlConnection conn = null;


                string constring = System.Configuration.ConfigurationManager.ConnectionStrings["dtsConnectionString"].ConnectionString;
                conn = new SqlConnection(constring);
                conn.Open();

                string query = "SELECT [transno], [dochist_action], [dochist_date], [dochist_remarks], [dochist_processtime] " +
                                "FROM [tbl_dochist] " +
                                "WHERE transno = " + txt_search.Text + " ORDER BY [dochist_date] DESC";

                //string query2 = "";

                SqliDTSHist.SelectCommand = query;
                SqliDTSHist.DataBind();

                grdHistory.DataSource = SqliDTSHist;
                grdHistory.DataBind();

                NoOfRec = grdHistory.Rows.Count;

                grdHistory.Visible = true;
                docDetails.Visible = true;
                docDetailsHead.Visible = true;
                

                if (NoOfRec == 0)
                {
                    docDetailsHead.Visible = false;
                    docDetails.Visible = false;
                    lblmsg.Visible = true;
                    lblmsg.Text = "Barcode no. " + txt_search.Text + " cannot be found!";
                }
                else
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = NoOfRec + " historical record(s) found for barcode no. " + txt_search.Text + "!";
                    DocType();
                    if (lbl_type.Text == "DISBURSEMENT VOUCHER")
                    {
                        VoucherNoDV();
                    }
                    if (lbl_type.Text == "PURCHASE REQUEST")
                    {
                        VoucherNoPR();   
                    }
                }

                conn.Close();
            }
            
        }

        private void DocType()
        {
            string query = "SELECT [doc_type] " + 
                            "FROM [tbl_doc] " +
                            "WHERE [transno]= " + txt_search.Text + "";

            using (SqlConnection conn = new SqlConnection(constring()))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                lbl_type.Visible = true;
                                lbl_type.Text = reader["doc_type"].ToString();
                            }
                        }
                    }
                }
                conn.Close();
            }
        }

        private void VoucherNoDV()
        {
            //if (lbl_type.Text == "DISBURSEMENT VOUCHER" || lbl_type.Text == "PURCHASE REQUEST")
            //{
                string query = "SELECT [dvvoucherno] " +
                                "FROM [tbl_dv] " +
                                "WHERE [transno]= " + txt_search.Text + "";

                using (SqlConnection conn = new SqlConnection(constring()))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                if (reader.Read())
                                {
                                    lbl_voucher.Visible = true;
                                    lbl_voucher.Text = reader["dvvoucherno"].ToString();

                                    if (reader["dvvoucherno"].ToString() == "")
                                    {
                                        lbl_voucher.Visible = true;
                                        lbl_voucher.Text = "NO VOUCHER # YET!";
                                    }
                                }
                               
                            }  
                        }
                    }
                    conn.Close();
                }
            //}

            //else if (string.IsNullOrEmpty(lbl_type.Text))
            //{
            //    lbl_voucher.Text = "NO VOUCHER # YET!";
            //}
        }

        private void VoucherNoPR()
        {
            //if (lbl_type.Text == "DISBURSEMENT VOUCHER" || lbl_type.Text == "PURCHASE REQUEST")
            //{
            string query = "SELECT [prvoucherno] " +
                            "FROM [tbl_pr] " +
                            "WHERE [transno]= " + txt_search.Text + "";

            using (SqlConnection conn = new SqlConnection(constring()))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                lbl_voucher.Visible = true;
                                lbl_voucher.Text = reader["prvoucherno"].ToString();

                                if (reader["prvoucherno"].ToString() == "")
                                {
                                    lbl_voucher.Visible = true;
                                    lbl_voucher.Text = "NO VOUCHER # YET!";
                                }
                            }

                        }
                    }
                }
                conn.Close();
            }
            //}

            //else if (string.IsNullOrEmpty(lbl_type.Text))
            //{
            //    lbl_voucher.Text = "NO VOUCHER # YET!";
            //}
        }
    }
}