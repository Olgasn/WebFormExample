//Класс контекста, отвечающий за связь с базой данных

using System.Data.Entity;
using WebFormExample.Models;
namespace WebFormExample.Data
{

    public class ToplivoContext : DbContext
    {
        
        public ToplivoContext() : base("name=toplivoConnectionString")
        {
        }
        public virtual DbSet<Fuel> Fuels { get; set; }
        public virtual DbSet<Operation> Operations { get; set; }
        public virtual DbSet<Tank> Tanks { get; set; }
    }
}