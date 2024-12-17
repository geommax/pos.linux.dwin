Here are **basic and administrative queries and commands** for MariaDB/MySQL to help you manage databases, users, and permissions effectively.

---

## **1. Basic Queries and Commands**

### **a. Show Databases**
List all existing databases:

```sql
SHOW DATABASES;
```

---

### **b. Create a New Database**
Create a database named `test_db`:

```sql
CREATE DATABASE test_db;
```

---

### **c. Use a Database**
Select a specific database to work with:

```sql
USE test_db;
```

---

### **d. Show Tables**
Display all tables in the currently selected database:

```sql
SHOW TABLES;
```

---

### **e. Create a Table**
Create a table named `users` with columns:

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

### **f. Insert Data**
Insert records into a table:

```sql
INSERT INTO users (name, email) 
VALUES ('Alice', 'alice@example.com'),
       ('Bob', 'bob@example.com');
```

---

### **g. Select Data**
Fetch all records from the `users` table:

```sql
SELECT * FROM users;
```

Fetch specific columns:

```sql
SELECT name, email FROM users;
```

---

### **h. Update Data**
Update a specific row:

```sql
UPDATE users 
SET email = 'alice_updated@example.com' 
WHERE name = 'Alice';
```

---

### **i. Delete Data**
Delete a row from the table:

```sql
DELETE FROM users WHERE name = 'Bob';
```

---

### **j. Drop Table**
Delete a table completely:

```sql
DROP TABLE users;
```

---

### **k. Drop Database**
Delete a database:

```sql
DROP DATABASE test_db;
```

---

## **2. User Administration**

### **a. Create a New User**
Create a user named `admin_user` with a password:

```sql
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'secure_password';
```

---

### **b. Grant Privileges**
Grant all privileges on a specific database to a user:

```sql
GRANT ALL PRIVILEGES ON test_db.* TO 'admin_user'@'localhost';
```

Grant privileges on all databases:

```sql
GRANT ALL PRIVILEGES ON *.* TO 'admin_user'@'localhost';
```

---

### **c. Show User Privileges**
Check the privileges for a specific user:

```sql
SHOW GRANTS FOR 'admin_user'@'localhost';
```

---

### **d. Revoke Privileges**
Revoke specific privileges from a user:

```sql
REVOKE ALL PRIVILEGES ON test_db.* FROM 'admin_user'@'localhost';
```

---

### **e. Delete a User**
Remove a user:

```sql
DROP USER 'admin_user'@'localhost';
```

---

### **f. Apply Changes**
Reload the privilege tables to apply changes:

```sql
FLUSH PRIVILEGES;
```

---

## **3. Administrative Commands**

### **a. Check Database Size**
Check the size of all databases:

```sql
SELECT table_schema "Database", 
       ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) "Size (MB)" 
FROM information_schema.tables 
GROUP BY table_schema;
```

---

### **b. Check Table Structure**
View the structure of a table:

```sql
DESCRIBE users;
```

Or:

```sql
SHOW COLUMNS FROM users;
```

---

### **c. Repair a Table**
Fix table errors:

```sql
REPAIR TABLE users;
```

---

### **d. Optimize a Table**
Optimize table storage:

```sql
OPTIMIZE TABLE users;
```

---

### **e. Backup a Database**
To back up a database, use the command line (outside MariaDB):

```bash
mysqldump -u root -p test_db > test_db_backup.sql
```

---

### **f. Restore a Database**
Restore a database from a backup file:

```bash
mysql -u root -p test_db < test_db_backup.sql
```

---

### **g. Show Process List**
View currently running processes in MariaDB:

```sql
SHOW PROCESSLIST;
```

---

### **h. Check Server Status**
View MariaDB server status:

```sql
STATUS;
```

Or from the terminal:

```bash
mariadb-admin -u root -p status
```

---

### **4. Useful Administrative Tips**

1. **Check Version**  
   To check the MariaDB version:

   ```sql
   SELECT VERSION();
   ```

2. **List All Users**  
   Display all users:

   ```sql
   SELECT User, Host FROM mysql.user;
   ```

3. **Change a User Password**  
   Update a user's password:

   ```sql
   ALTER USER 'admin_user'@'localhost' IDENTIFIED BY 'new_password';
   ```

---

## **Summary of Key Tasks**

| **Task**                      | **Command**                                    |
|-------------------------------|-----------------------------------------------|
| Create Database               | `CREATE DATABASE dbname;`                     |
| Create User                   | `CREATE USER 'user'@'host' IDENTIFIED BY 'pass';` |
| Grant Privileges              | `GRANT ALL PRIVILEGES ON db.* TO 'user'@'host';` |
| Backup Database               | `mysqldump -u root -p dbname > file.sql`      |
| Restore Database              | `mysql -u root -p dbname < file.sql`          |
| Show Databases                | `SHOW DATABASES;`                             |
| Show Tables                   | `SHOW TABLES;`                                |
| View Table Structure          | `DESCRIBE tablename;`                         |
| Optimize Table                | `OPTIMIZE TABLE tablename;`                   |
| Delete User                   | `DROP USER 'user'@'host';`                    |

---

Let me know if you need help with any specific query or task! 🚀