---
icon: react
---

# Host React Application

## Create Simple ReactJs Application and Host in XAMPP

In this blog we are going to create a very simple react application and host in XAMPP.

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*M76kEH8ff8N2ElzdUK4lqQ.jpeg" alt="" height="467" width="700"><figcaption><p>Photo by <a href="https://unsplash.com/@flowforfrank?utm_source=unsplash&#x26;utm_medium=referral&#x26;utm_content=creditCopyText">Ferenc Almasi</a> on <a href="https://unsplash.com/?utm_source=unsplash&#x26;utm_medium=referral&#x26;utm_content=creditCopyText">Unsplash</a></p></figcaption></figure>

## Prerequisite <a href="#id-264c" id="id-264c"></a>

1. XAMPP
2. Node

If XAMPP and node are not installed in your system, then install first and after that follow next step. You can use following links to download and install.

[https://www.apachefriends.org/download.html](https://www.apachefriends.org/download.html)

[https://nodejs.org/en/download/](https://nodejs.org/en/download/)

### Check Node and NPM version <a href="#id-2efb" id="id-2efb"></a>

Open command prompt and type following commands.

```
node -v
npm -v
```

<figure><img src="https://miro.medium.com/v2/resize:fit:257/1*yPqjitFAec5x4jSX-HsY0Q.png" alt="" height="163" width="257"><figcaption></figcaption></figure>

## Install create-react-app <a href="#id-8f76" id="id-8f76"></a>

If you’ve previously installed create-react-app globally via npm install -g create-react-app, we recommend you uninstall the package using npm uninstall -g create-react-app or yarn global remove create-react-app to ensure that npx always uses the latest version.

```
npm install -g create-react-app
```

## Create a new react app <a href="#id-6a37" id="id-6a37"></a>

Open command prompt and go to directory where you want to create project. My project directory is F:\javascript-projects\react-projects. You can choose project directory according to your choice.

```
F:
F:\javascript-projects\react-projects
```

### Create a project <a href="#c819" id="c819"></a>

```
npx create-react-app my-react-app
```

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*YFJoC4ud3t1dQd1Tn-KIzg.png" alt="" height="381" width="700"><figcaption></figcaption></figure>

### Run the project <a href="#id-07fc" id="id-07fc"></a>

```
cd my-react-app
npm start
```

We can see application started in command prompt:

<figure><img src="https://miro.medium.com/v2/resize:fit:535/1*xh4oil4xG0G-7kcaLlZVTw.png" alt="" height="210" width="535"><figcaption></figcaption></figure>

### Check in browser <a href="#bbf1" id="bbf1"></a>

[http://localhost:3000/](http://localhost:3000/)

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*asLcWQx6g6nhpY4_gX6KtQ.png" alt="" height="435" width="700"><figcaption></figcaption></figure>

## Let us create two webpages home and aboutus in our application <a href="#id-027f" id="id-027f"></a>

### Install react router <a href="#id-2625" id="id-2625"></a>

```
npm install react-router-dom
```

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*XPAw39rGPaHciTYgQZivlA.png" alt="" height="230" width="700"><figcaption></figcaption></figure>

### Create webpages folder inside src folder. <a href="#id-17c9" id="id-17c9"></a>

Create three files:

1. src/webpages/index.js
2. src/webpages/home.js
3. src/webpages/aboutus.js

### Write following code in src/webpages/home.js <a href="#a001" id="a001"></a>

```
import React from 'react';const Home = () => {
    return (
        <div>
            <h1>Welcome to Xcelvations</h1>
            <p>This is home page</p>
        </div>
    );
};export default Home;
```

### Write following code in src/webpages/aboutus.js <a href="#id-7769" id="id-7769"></a>

```
import React from 'react';const Aboutus = () => {
    return (
        <div>
            <h1>About us</h1>
            <p>This is about us page</p>
        </div>
    );
};export default Aboutus;
```

### Write following code in src/webpages/index.js <a href="#id-99bd" id="id-99bd"></a>

```
import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";import Home from './home';
import Aboutus from './aboutus';const Webpages = () => {
    return(
        <Router>
            <Route exact path="/" component= {Home} />
            <Route path = "/aboutus" component = {Aboutus} />
        </Router>
    );
};export default Webpages;
```

### Modify src/App.js <a href="#id-3e06" id="id-3e06"></a>

Remove all default code which is not required.

```
import './App.css';
import Webpages from './webpages';function App() {
  return (
    <div>
      <Webpages />
    </div>
  );
}export default App;
```

### Run the application <a href="#id-0618" id="id-0618"></a>

```
npm start
```

Browse urls:

[http://localhost:3000/](http://localhost:3000/)\
[http://localhost:3000/aboutus](http://localhost:3000/aboutus)

<figure><img src="https://miro.medium.com/v2/resize:fit:560/1*FUbjs-KB1cX7SIb_67wyZQ.png" alt="" height="365" width="560"><figcaption></figcaption></figure>

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:626/1*oPMEhh2T0DEmjxcIykT5JQ.png" alt="" height="319" width="626"><figcaption></figcaption></figure>

## Build the react application for deployment <a href="#id-357c" id="id-357c"></a>

Stop the application, if it is running and run following command:

```
npm run build
```

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*vhhUl5C3qmTAWBYaaAsMGg.png" alt="" height="634" width="700"><figcaption></figcaption></figure>

We can see build folder created inside our project.

<figure><img src="https://miro.medium.com/v2/resize:fit:681/1*ZULHnc_APzJI98_KTa66fA.png" alt="" height="323" width="681"><figcaption></figcaption></figure>

## Setup a virtual host <a href="#a57e" id="a57e"></a>

### Create a virtual host <a href="#id-4dc5" id="id-4dc5"></a>

Open C:\xampp\apache\conf\extra\httpd-vhosts.conf file

Note: DocumentRoot and Directory will be your build folder, which just now we generated for production.

```
<VirtualHost 127.0.0.1:80>
    ServerName my-react-app.com
    ServerAlias 
    ServerAdmin     DocumentRoot "F:/javascript-projects/react-projects/my-react-app/build"
     <Directory F:/javascript-projects/react-projects/my-react-app/build>
        Options Indexes FollowSymLinks MultiViews
  AllowOverride all
  Order Deny,Allow
        Allow from all
        Require all granted
    </Directory>
</VirtualHost>
```

Save and close the file.

### Make a domain name entry in hosts file <a href="#id-0b79" id="id-0b79"></a>

Open command prompt as administrator. Open hosts file.

```
cd C:/Windows/System32/drivers/etc
notepad hosts
```

Add following line in hosts file.

```
127.0.0.1    
```

Save and close the hosts file.

## Start your Xampp and browse url <a href="#id-6292" id="id-6292"></a>

[http://www.my-react-app.com](http://www.my-react-app.com/)

<figure><img src="https://miro.medium.com/v2/resize:fit:564/1*Jk74zm5J-CxtJdjdtHvm1w.png" alt="" height="293" width="564"><figcaption></figcaption></figure>

[http://www.my-react-app.com/aboutus](http://www.my-react-app.com/aboutus)

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*mvLC9ZWWO48FY2mXh34CWA.png" alt="" height="265" width="700"><figcaption></figcaption></figure>

We can see homepage is working but aboutus page is not working. So let us add .htaccess file inside public folder.

## Add .htaccess file in public folder <a href="#id-339c" id="id-339c"></a>

### What is .htaccess file? <a href="#b710" id="b710"></a>

.htaccess files (or “distributed configuration files”) provide a way to make configuration changes on a per-directory basis. A file, containing one or more configuration directives, is placed in a particular document directory, and the directives apply to that directory, and all subdirectories thereof.

### Create a public/.htaccess file <a href="#fc88" id="fc88"></a>

Create a public/.htaccess file and write following lines of code in that file.

```
Options -MultiViews
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^ index.html [QSA,L]
```

<figure><img src="https://miro.medium.com/v2/resize:fit:687/1*gq6-zl-6XPWUPyraVpODqA.png" alt="" height="410" width="687"><figcaption></figcaption></figure>

### Add homepage in package.json file <a href="#id-72db" id="id-72db"></a>

```
"homepage": "http://www.my-react-app.com",
```

Press enter or click to view image in full size

<figure><img src="https://miro.medium.com/v2/resize:fit:700/1*CSRQ-LhCUszfMChdqFECeg.png" alt="" height="497" width="700"><figcaption></figcaption></figure>

## Rebuild react application <a href="#id-38f8" id="id-38f8"></a>

```
npm run build
```

## Stop and restart your XAMPP again and browse url <a href="#id-1774" id="id-1774"></a>

<figure><img src="https://miro.medium.com/v2/resize:fit:671/1*ldkpKoDwKinPGtoBqFP3qw.png" alt="" height="432" width="671"><figcaption></figcaption></figure>

[http://www.my-react-app.com/](http://www.my-react-app.com/)

<figure><img src="https://miro.medium.com/v2/resize:fit:536/1*vBP_avO5ewbtndOYc1tFYg.png" alt="" height="268" width="536"><figcaption></figcaption></figure>

[http://www.my-react-app.com/aboutus](http://www.my-react-app.com/aboutus)

<figure><img src="https://miro.medium.com/v2/resize:fit:555/1*3lwqzipehkL1wPaDidUx7Q.png" alt="" height="293" width="555"><figcaption></figcaption></figure>

Thanks for reading.



***

## REFERENCES

* [https://medium.com/@nutanbhogendrasharma/create-simple-reactjs-application-and-host-in-xampp-4dae8e466c50](https://medium.com/@nutanbhogendrasharma/create-simple-reactjs-application-and-host-in-xampp-4dae8e466c50)
* [https://dev.to/writech/deploying-and-hosting-a-react-app-on-an-apache-server-1d46](https://dev.to/writech/deploying-and-hosting-a-react-app-on-an-apache-server-1d46)
