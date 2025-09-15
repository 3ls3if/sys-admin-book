---
icon: plug
---

# Connect to PostgreSQL database server using pgAdmin

### Connect to PostgreSQL database server using pgAdmin <a href="#id-2-connect-to-postgresql-database-server-using-pgadmin" id="id-2-connect-to-postgresql-database-server-using-pgadmin"></a>

The second way to connect to a database is by using a pgAdmin application.

The pgAdmin application allows you to interact with the PostgreSQL database server via an intuitive user interface.

The following illustrates how to connect to a database using the pgAdmin application:

First, launch the pgAdmin application from the Start menu

The pgAdmin application will launch on the web browser as shown in the following picture:

Second, right-click the Servers node and select **Register > Server…** menu to create a server

<figure><img src="https://neon.com/_next/image?url=%2Fpostgresqltutorial%2FpgAdmin-4.png&#x26;w=640&#x26;q=75&#x26;dpl=dpl_73Xft78rjpqXCzC69zT1uJZZchzi" alt=""><figcaption></figcaption></figure>

Third, enter the server name such as `Local`, and click the **Connection** tab:

<figure><img src="https://neon.com/_next/image?url=%2Fpostgresqltutorial%2FConnect-to-PostgreSQL-pgadmin4.png&#x26;w=640&#x26;q=75&#x26;dpl=dpl_73Xft78rjpqXCzC69zT1uJZZchzi" alt=""><figcaption></figcaption></figure>

Fourth, enter the host and password for the `postgres` user and click the **Save** button:

<figure><img src="https://neon.com/_next/image?url=%2Fpostgresqltutorial%2FConnect-to-PostgreSQL-pgadmin4-server-name.png&#x26;w=640&#x26;q=75&#x26;dpl=dpl_73Xft78rjpqXCzC69zT1uJZZchzi" alt=""><figcaption></figcaption></figure>

Fifth, click on the `Servers` node to expand the server. By default, PostgreSQL has a database named `postgres`:

<figure><img src="https://neon.com/_next/image?url=%2Fpostgresqltutorial%2FConnect-to-PostgreSQL-pgadmin4-connection.png&#x26;w=640&#x26;q=75&#x26;dpl=dpl_73Xft78rjpqXCzC69zT1uJZZchzi" alt=""><figcaption></figcaption></figure>

Sixth, open the query tool by selecting the menu item **Tool > Query Tool**:

<figure><img src="https://neon.com/_next/image?url=%2Fpostgresqltutorial%2FConnect-to-PostgreSQL-pgadmin4-databases.png&#x26;w=640&#x26;q=75&#x26;dpl=dpl_73Xft78rjpqXCzC69zT1uJZZchzi" alt=""><figcaption></figcaption></figure>

Seventh, enter the query in the **Query Editor** and click the **Execute** button, you will see the result of the query displayed in the **Data Output** tab:

<figure><img src="https://neon.com/_next/image?url=%2Fpostgresqltutorial%2FConnect-to-PostgreSQL-pgadmin4-query-tool.png&#x26;w=640&#x26;q=75&#x26;dpl=dpl_73Xft78rjpqXCzC69zT1uJZZchzi" alt=""><figcaption></figcaption></figure>

![](https://neon.com/_next/image?url=%2Fpostgresqltutorial%2FConnect-to-PostgreSQL-pgadmin4-execute-query.png\&w=640\&q=75\&dpl=dpl_73Xft78rjpqXCzC69zT1uJZZchzi)



***

## REFERENCES

* [https://neon.com/postgresql/postgresql-getting-started/connect-to-postgresql-database](https://neon.com/postgresql/postgresql-getting-started/connect-to-postgresql-database)
