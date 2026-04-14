namespace ASPCoreWebAPINewDemos.Data
{
    public partial class AppDbContext
    {
        public override int SaveChanges()
        {
            //code 
            try
            {
                var selectedEntityList = ChangeTracker.Entries().ToList();
                foreach (var entity in selectedEntityList)
                {
                    if (entity.State == EntityState.Added)
                    {
                        ((IBaseEntity)entity.Entity).CreateId = 1;
                        ((IBaseEntity)entity.Entity).CreateDate = DateTime.Now;
                        ((IBaseEntity)entity.Entity).UpdateId = 1;
                        ((IBaseEntity)entity.Entity).UpdateDate = DateTime.Now;
                        ((IBaseEntity)entity.Entity).isDeleted = false;
                    }
                    else
                    {
                        if (entity.State == EntityState.Modified && ((IBaseEntity)entity.Entity).isDeleted == false)
                        {
                            ((IBaseEntity)entity.Entity).UpdateId = 1;
                            ((IBaseEntity)entity.Entity).UpdateDate = DateTime.Now;
                        }
                        else if (entity.State == EntityState.Modified && ((IBaseEntity)entity.Entity).isDeleted == true)
                        {
                            //If TACKING BEHAVIOR IS DELETED, THEN ACTUALLY DELETE THE ENTITY FROM DATABASE
                            ((IBaseEntity)entity.Entity).isDeleted = true;
                        }
                    }
                }
                base.SaveChanges();
                //return await base.SaveChangesAsync();
                //var result = await base.SaveChangesAsync();
                return selectedEntityList.Count;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
