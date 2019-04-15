using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFormExample.Data;
using WebFormExample.Models;

namespace WebFormExample
{
    public partial class CodeFuels : System.Web.UI.Page
    {
        private ToplivoContext db = new ToplivoContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowData();
            }
        }

        protected void GridViewFuel_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //Set the edit index.
            GridViewFuel.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            ShowData();

        }

        protected void GridViewFuel_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {

        }

        protected void GridViewFuel_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            

            //Update the values.
            GridViewRow row = GridViewFuel.Rows[e.RowIndex];
            int id = Convert.ToInt32(((TextBox)(row.Cells[1].Controls[0])).Text);
            var fuel = db.Fuels.Where(f => f.FuelID==id).FirstOrDefault();
            fuel.FuelType = ((TextBox)(row.Cells[2].Controls[0])).Text;
            fuel.FuelDensity = Convert.ToSingle(((TextBox)(row.Cells[3].Controls[0])).Text);

            //db.Entry(fuel).State = EntityState.Modified;
            db.SaveChanges();
            //Reset the edit index.
            GridViewFuel.EditIndex = -1;

            //Bind data to the GridView control.
            ShowData();

        }

        protected void GridViewFuel_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void GridViewFuel_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {

        }

        protected void GridViewFuel_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            //Reset the edit index.
            GridViewFuel.EditIndex = -1;
            //Bind data to the GridView control.
            ShowData();
        }
        protected void ShowData()
        {
            var fuels = db.Fuels.ToList();
            GridViewFuel.DataSource = fuels;
            GridViewFuel.DataBind();
        }
    }
}