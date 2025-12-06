---
icon: cat
---

# Develop Servlets with Tomcat on XAMPP

> **I. Tomcat Setup**

**1. Start the Tomcat Service**

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*sX7XK9kdur7gwmJz3lIyBg.png" alt="" height="457" width="700"><figcaption></figcaption></figure>

The server has been initiated and is actively receiving requests, prepared to deliver responses on port 8080.

**2.** You should now be able to see the below page on your browser on localhost:8000 / 127.0.0.1:8080 :

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*M26hLFXdRK8bwkfVyNJsHQ.png" alt="" height="431" width="700"><figcaption></figcaption></figure>

**3. Manager Setup:** Access the **tomcat-users.xml** file found in the _`C:\xampp\tomcat\conf\tomcat-users.xml`_ file, remove the commenting from the specified role and user, and update the password to a memorable one.

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*jXo6D1qcwk6I5B24H2Q6XQ.png" alt="" height="295" width="700"><figcaption></figcaption></figure>

**4. Access the manager** application from the browser using _localhost:8080/manager_ or from the front end.

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*9ocX2o2eQNzmM_wF7_JR0g.png" alt="" height="265" width="700"><figcaption></figcaption></figure>

The Tomcat Web Application Manager will showcase all applications residing in the _**`webapps`**_&#x66;older. (_C:\xampp\tomcat\webapps)_

> **II. Developing and Deploying the Servlet**

1. Open the _**webapps**_ folder in VSCODE.

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*T4RgUSzDLv5IbCwchHUiaQ.png" alt="" height="94" width="700"><figcaption></figcaption></figure>

2\. Install the `Extension Pack for Java` plugin.

3\. Create Java Project.

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*cTc21xGMv0Vqr0F4hPV_bQ.png" alt="" height="182" width="700"><figcaption></figcaption></figure>

4\. Choose `No Build Tools` followed by `webapps` folder as Project Location.

### Get Aditya Padhi’s stories in your inbox

Join Medium for free to get updates from this writer.

Subscribe

Project Name: `auth` \[Can be any name without spaces and hyphens]

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*JJO0pCHbsuCdbcmTnMSiUw.png" alt="" height="61" width="700"><figcaption></figcaption></figure>

> _**Note:**_**&#x20;webapps** folder must be open when creating the project so that the project named auth can be created inside the folder.

VSCode will automatically open the auth folder in a separate window. Now go ahead and close the _**`webapps`**_&#x66;older window.

5\. Modify the `.vscode/settings.json` file to incorporate the necessary adjustments for compiling and placing the class files in a suitable location within the `WEB-INF`, enabling Tomcat to recognize them.

```
{
    "java.project.sourcePaths": ["src"],
    "java.project.outputPath": "WEB-INF/classes",
    "java.project.referencedLibraries": [
        "lib/**/*.jar"
    ]
}
```

6\. Now copy `servlet-api.jar` from the Tomcat library path `xampp\tomcat\lib` and place the same in the lib folder inside the project path.

> **VVIMP Note:** In an application development lifecycle, libraries are required in two places one during the compilation and one during the running of the instance. **During compilation** VSCode picks the libaries from the folder path we provide in settings.json i.e the project \`auth\lib\` path of the application **but while** the application is **running** in the server Tomcat expects the library to be present in the \`tomcat\lib\` folder. So the jar must be kept in both the locations or VSCode must be provided with the appropriate path \`tomcat\lib\` directory for the successful compilation of a java servlet.

7\. Create a folder structure in the source `src` folder for the application.

`src\com\fire\App.java`

```
package com.fire; 

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.IOException;
import javax.servlet.ServletException;

public class App extends HttpServlet {

 public void doGet(HttpServletRequest request, 
  HttpServletResponse response) 
  throws ServletException, IOException {
  
  PrintWriter out = response.getWriter();
  out.println("<html>");
  out.println("<head>");
  out.println("<title>Servlet App</title>");
  out.println("</head>");
  out.println("<body>");
  out.println("Welcome to the Servlet App");
  out.println("</body>");
  out.println("</html>");
 }
}
```

8\. Upon saving the `App.java` file, a directory named `WEB-INF\classes` is automatically generated, and the `App.class` file is also located within the same folder.

**Not required:** Compiling the old way with all libraries from lib:

```
javac -cp C:\xampp\tomcat\lib\* -d C:\xampp\tomcat\webapps\auth\WEB-INF\classes App.java
```

9\. Add `web.xml` with the following content to the `WEB-INF` folder.

`WEB-INF\web.xml`

```
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                      http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
  version="3.1"
  metadata-complete="true">
    <display-name>Auth</display-name>
    <description>
        Welcome to Auth
    </description>
    <servlet>
        <servlet-name>App</servlet-name>
        <servlet-class>com.fire.App</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>App</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>
```

10\. Refresh the manager page & **Reload** the auth application if required and click on the `/auth` link.

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*Ci6uHPg_TFplpEQ4XdtVmQ.png" alt="" height="266" width="700"><figcaption></figcaption></figure>

> **Result:**

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*EuDBzEjuiTHi8h4xVBEWvw.png" alt="" height="170" width="700"><figcaption></figcaption></figure>

**Task:** Now add JSON library to the lib directory in both tomcat/lib and auth/lib and test the working of the library.

> **Conclusion:**

In wrapping up our exploration of servlet development with Tomcat and XAMPP on Windows, we’ve navigated through the fundamentals of setting up your environment and crafting dynamic web applications.





***

## REFERENCES

* [https://adityacodes.medium.com/develop-servlets-with-tomcat-on-xampp-6ceaf4d79bf9](https://adityacodes.medium.com/develop-servlets-with-tomcat-on-xampp-6ceaf4d79bf9)
* [https://tomcat.apache.org/tomcat-7.0-doc/html-manager-howto.html](https://tomcat.apache.org/tomcat-7.0-doc/html-manager-howto.html)
