# 🗄️ Database Automatic Population Guide

## Overview
The EMS application now automatically populates the MySQL database with all necessary tables and seed data when you start the Docker containers.

## How It Works

### 1. **Docker MySQL Built-in Initialization**
When the MySQL container starts for the **first time**, it automatically:
- Creates the database specified in `MYSQL_DATABASE` environment variable
- Creates the user specified in `MYSQL_USER`/`MYSQL_PASSWORD` environment variables  
- Executes any `.sql`, `.sh`, or `.sql.gz` files found in `/docker-entrypoint-initdb.d/`
- **No custom scripts needed** - this is built into the official MySQL Docker image!

### 2. **File Mapping**
The `docker-compose.yaml` maps your local `new-database` folder to MySQL's initialization directory:

```yaml
volumes:
  - ./EMS-Database/new-database:/docker-entrypoint-initdb.d
```

### 3. **Automatic Execution Order**
The MySQL container executes files in **alphabetical order**. Our files are numbered to ensure proper dependency order:

```
01-ate.sql          ← Creates 'ate' table + inserts data
02-roles.sql        ← Creates 'roles' table + inserts data  
03-registration.sql ← Creates 'registration' table + inserts data
04-permission.sql   ← Creates 'permission' table + inserts data
05-directorydetails.sql ← Creates 'directorydetails' table + inserts data
06-employeedetails.sql  ← Creates 'employeedetails' table + inserts data
07-leavedetails.sql     ← Creates 'leavedetails' table + inserts data
08-leaves.sql           ← Creates 'leaves' table + inserts data
09-payment.sql          ← Creates 'payment' table + inserts data
10-employeedocs.sql     ← Creates 'employeedocs' table + inserts data
```

## 🚀 **Quick Start**

### Start Fresh Database
```bash
# Stop containers and remove database volume
docker compose down -v

# Start containers (will auto-populate database)
docker compose up -d
```

### Verify Database Population
```bash
# Check that all tables exist
docker exec -it ems_mysql_db mysql -u ems_user -pems_password ems_database -e "SHOW TABLES;"

# Check sample data
docker exec -it ems_mysql_db mysql -u ems_user -pems_password ems_database -e "SELECT * FROM roles;"
```

## ✅ **What Gets Created**

### Tables Created:
- `ate` - Attendance and Time Entry
- `roles` - User roles (Admin, Manager, Employee)  
- `registration` - User accounts
- `permission` - Access permissions (Public, Private, Protected, Default)
- `directorydetails` - Directory management
- `employeedetails` - Employee profile information
- `leavedetails` - Leave request details
- `leaves` - Leave management
- `payment` - Payroll information
- `employeedocs` - Document storage

### Sample Data Included:
- **4 roles**: Admin, Manager, Employee, NA
- **4 permissions**: Public, Private, Protected, Default
- **9 sample users** with different roles
- **Various directory structures** for testing
- **Sample leave requests** and **payroll data**

## 🔧 **Customization**

### Adding Your Own Data
1. Create new `.sql` files in `EMS-Database/new-database/`
2. Use numbered prefix (e.g., `11-my-custom-data.sql`)
3. Restart containers: `docker compose down -v && docker compose up -d`

### Modifying Existing Data
1. Edit the relevant `.sql` file in `EMS-Database/new-database/`
2. Restart containers to apply changes

### File Format Example:
```sql
-- 11-custom-users.sql
INSERT INTO ems_database.registration (firstname, lastname, email, username, password, role, managerstatus, managerId, activitystatus, date) 
VALUES 
('John', 'Doe', 'john.doe@company.com', 'john.doe', 'password123', 3, false, 0, true, NOW()),
('Jane', 'Smith', 'jane.smith@company.com', 'jane.smith', 'password456', 2, true, 0, true, NOW());
```

## 🛠️ **Troubleshooting**

### Database Not Populated?
- **Check logs**: `docker logs ems_mysql_db`
- **Verify file permissions**: Make sure `.sql` files are readable
- **Check syntax**: Ensure SQL files have valid syntax

### Container Won't Start?
- **Check file paths**: Verify `./EMS-Database/new-database/` exists
- **Check SQL syntax**: Invalid SQL will prevent container startup

### Reset Database?
```bash
# Complete reset
docker compose down -v
docker compose up -d
```

## 📋 **Current Database State**

After initialization, your database contains:
- ✅ **10 tables** fully created
- ✅ **Seed data** for testing
- ✅ **User accounts** ready for login testing
- ✅ **Role-based permissions** configured
- ✅ **Sample business data** for development

## 🎯 **Next Steps**

1. **Test Login**: Access `http://localhost:8080/ems/` and try logging in
2. **Add Your Data**: Create additional `.sql` files for your specific needs
3. **Backup**: Use `mysqldump` to backup your populated database
4. **Production**: Use the same pattern for production deployments

---

**🎉 Your database is now automatically populated every time you start fresh containers!**
