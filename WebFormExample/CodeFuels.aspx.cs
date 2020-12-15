using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;
using WebFormExample.Data;
using WebFormExample.Models;

namespace WebFormExample
{
    public partial class CodeFuels : System.Web.UI.Page
    {
        private ToplivoContext db;
        private string strFindFuel="";

        protected void Page_Load(object sender, EventArgs e)
        {
            db = new ToplivoContext();
            strFindFuel = TextBoxFindFuel.Text;
            ShowData(strFindFuel);


        }

        protected void GridViewFuel_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //Set the edit index.
            GridViewFuel.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            ShowData(strFindFuel);

        }


        protected void GridViewFuel_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {            

            //Update the values.
            GridViewRow row = GridViewFuel.Rows[e.RowIndex];
            int id = Convert.ToInt32(((TextBox)(row.Cells[1].Controls[0])).Text);
            Fuel fuel = db.Fuels.Where(f => f.FuelID==id).FirstOrDefault();
            fuel.FuelType = ((TextBox)(row.Cells[2].Controls[0])).Text;
            fuel.FuelDensity = Convert.ToSingle(((TextBox)(row.Cells[3].Controls[0])).Text);

            db.SaveChanges();
            //Reset the edit index.
            GridViewFuel.EditIndex = -1;

            //Bind data to the GridView control.
            ShowData(strFindFuel);

        }

        protected void GridViewFuel_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //Update the values.
            GridViewRow row = GridViewFuel.Rows[e.RowIndex];
            int id = Convert.ToInt32(((TextBox)(row.Cells[1].Controls[0])).Text);
            Fuel fuel = db.Fuels.Where(f => f.FuelID == id).FirstOrDefault();
            db.Fuels.Remove(fuel);

            //db.Entry(fuel).State = EntityState.Modified;
            db.SaveChanges();
            //Reset the edit index.
            GridViewFuel.EditIndex = -1;

            //Bind data to the GridView control.
            ShowData(strFindFuel);

        }


        protected void GridViewFuel_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            //Reset the edit index.
            GridViewFuel.EditIndex = -1;
            //Bind data to the GridView control.
            ShowData(strFindFuel);
        }


        protected void ButtonFindFuel_Click(object sender, EventArgs e)
        {
            strFindFuel = TextBoxFindFuel.Text;
            ShowData(strFindFuel);
        }

        protected void ButtonAddFuel_Click(object sender, EventArgs e)
        {
            Fuel fuel = new Fuel
            {
                FuelDensity = Convert.ToSingle(TextBoxFuelDensity.Text),
                FuelType = TextBoxFuelType.Text
            };

            db.Fuels.Add(fuel);
            db.SaveChanges();
            TextBoxFuelDensity.Text = "";
            TextBoxFuelType.Text = "";
            ShowData(strFindFuel);
                                 
        }
        protected void ShowData(string strFindFuel = "")
        {
            System.Collections.Generic.List<Fuel> fuels = db.Fuels.Where(s => s.FuelType.Contains(strFindFuel)).ToList();
            GridViewFuel.DataSource = fuels;
            GridViewFuel.DataBind();
        }
    }
}