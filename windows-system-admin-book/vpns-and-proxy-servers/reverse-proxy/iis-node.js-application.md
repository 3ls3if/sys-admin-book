---
icon: windows
---

# IIS - Node.js Application

## Reverse-Proxying Node.js Apps on Windows with IIS

You can run Node.js apps on Windows with the added layer of a reverse-proxy with the built-in web service manager IIS. Together with a process manager like PM2, it’s a viable strategy to run apps for production.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410027256/cygUJIQDa.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

#### Why use a reverse proxy? <a href="#why-use-a-reverse-proxy" id="why-use-a-reverse-proxy"></a>

Having a dedicated web server like IIS fielding your HTTP requests makes things more manageable and enables standard web server features like SSL termination, compression, and load balancing. For more information, I recommend Thomas Hunter II’s post “[Why should I use a Reverse Proxy if Node.js is Production-Ready?](https://medium.com/intrinsic/why-should-i-use-a-reverse-proxy-if-node-js-is-production-ready-5a079408b2ca)”

Another big benefit is being able to redirect traffic to appropriate web services by using URL rules. Let’s explore this last benefit further.

#### Run a Node.js web service <a href="#run-a-nodejs-web-service" id="run-a-nodejs-web-service"></a>

If you already have a running Node.js app that you want to use, you can skip this step. Otherwise, let’s create a really simple Node.js web server that will reply to HTTP requests.

1. Create a new directory and initialize an npm project within it. Make sure the name of the directory makes sense in relation to the name of the app. In this case, we’re just making a simple test app.

```
mkdir testapp
cd testapp
npm init -y
```

1. Install Fastify. It is a fast and low-overhead web framework for Node.js.

```
npm i fastify
```

1. Create a file called `server.js` with the following contents.

```
const fastify = require("fastify")({ logger: true });

fastify.get("/", async () => {
  return { hello: "world" };
});

const start = async () => {
  try {
    await fastify.listen(process.env.PORT || 3000);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();
```

1. Run the server and check if it responds correctly in your browser. By default, it will listen on port 3000.

```
node server
```

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410028991/KYeSLMWah.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

#### Manage your Node.js web services with PM2 <a href="#manage-your-nodejs-web-services-with-pm2" id="manage-your-nodejs-web-services-with-pm2"></a>

Again, if you already have this part taken care of, you can skip this step. Otherwise, let’s manage our service(s) with PM2. PM2 is an advanced process manager for production Node.js applications.

1. Make sure you kill any running Node.js processes, such as the one we started in the last section.
2. Install PM2.

```
npm i -g pm2
```

1. Create a PM2 configuration file called `ecosystem.config.js` somewhere appropriate. This might be in the root of your server or in your user directory. This file will contain configuration for all of your Node.js web apps.

```
module.exports = {
  apps: [
    {
      name: "Test App",
      script: "path/to/testapp/server.js",
      env: {
        PORT: 3000,
      },
    },
  ],
};
```

You can put as many apps in here as necessary. Make sure they all have different `PORT` values. I recommend naming each app something useful that matches the app’s directory name. This makes management easier.

1. Run PM2 and start the apps by using the ecosystem configuration.

```
pm2 start ecosystem.config.js
```

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410030403/pWcQioFex.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

With the app up and running, head back to your web browser and make sure everything is still working.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410031883/6WFmJ4TR-W.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

It’s worth noting that any time you make a change to `ecosystem.config.js`, such as when you create a new Node.js app and you add it to the list, you can reload the configuration.

```
pm2 reload ecosystem.config.js
```

#### Turn on Internet Information Services <a href="#turn-on-internet-information-services" id="turn-on-internet-information-services"></a>

Running the application like this works great, but you’d ideally want a dedicated web server like IIS fielding your HTTP requests for all of the reasons mentioned earlier in this post. Here, we’ll set up directing traffic to appropriate Node.js web services by using URL rules.

IIS is a web server product from Microsoft that you can turn on in Windows 10.

1. Click the **Start** button or press the **Windows** key. Type “**Turn Windows features on or off**” and press **Enter**. The **Windows Features** window appears.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410033580/p2ByOHpG4.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

1. Check the box for **Internet Information Services**. The box will be filled in with a square, indicating that some features within it are selected. The features that are selected by default are fine. So just click **OK**.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410035063/6freOuBvx.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

Make sure IIS is up and running by starting your web browser and navigating to [http://localhost](http://localhost/). If a site appears similar to the one below, you’re in business.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410036623/sC1x6aSY2.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

#### Install Application Request Routing and URL Rewrite <a href="#install-application-request-routing-and-url-rewrite" id="install-application-request-routing-and-url-rewrite"></a>

These two products from Microsoft are essential to using IIS as a reverse proxy.

1. Click the **Start** button or press the **Windows** key. Type “**Microsoft Web Platform Installer**” and press **Enter**.

Note: If you do not have it installed, you can download [Web Platform Installer from Microsoft](https://www.microsoft.com/web/downloads/platform.aspx) .

1. If a **User Account Control** box appears, click **Yes**. The **Web Platform Installer** window appears.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410038238/I7m1WX4Hr.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

1. In the search box in the upper right corner, type “**Application Request Routing**” and press **Enter**.
2. Click the **Add** button in the row labeled **Application Request Routing 2.5 with KB2589179**. If there’s a newer version, you could choose that one instead, but this is the one I’m familiar with.
3. Back in the search box, type “**URL Rewrite**” and press **Enter**.
4. Click the **Add** button in the row labeled **URL Rewrite 2.1**.
5. Click the **Install** button.

#### Set up a URL Rewrite rule <a href="#set-up-a-url-rewrite-rule" id="set-up-a-url-rewrite-rule"></a>

1. Open IIS Manager by clicking **Start** or pressing the **Windows** key, typing “Internet Information Services” and pressing **Enter**. The manager window appears.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410039981/1hCay_rXn.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

1. In the **Connections** pane, click the arrow next to your PC’s name, then the arrow next to **Sites**. Finally, click on **Default Web Site** to select it.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410042357/sf5ziDd0kS.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

1. Double-click **URL Rewrite** to open its features. There will probably be no rules in place by default.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410044096/XmCBgWe-R.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

1. In the **Actions** pane on the right, click **Add Rule(s)…**

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410045733/aZlrgwzmF.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

1. Click to select **Reverse Proxy** and then click **OK**.

You may see a message about enabling **Application Request Routing**. Go ahead and accept it.

1. Enter the server name or IP address where HTTP requests will be forwarded. This is where your Node.js server is listening. If you set up your environment according to this guide, this will be `localhost:3000`. You can leave the other options set to their default and click **OK**.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410047299/89_1lvsG_t.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

We’re almost done. With that rule saved, IIS will proxy any traffic heading towards `localhost` to `localhost:3000`. You can test that in your web browser.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410048937/htkHle3KP9.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

Notice we didn’t have to specify the port this time.

This is great, except when you have multiple Node.js apps running and you want to direct users to the correct one based on the URL they are visiting. In our case, we want any user who visits [http://localhost/testapp](http://localhost/testapp) to see our Node.js test app.

1. To make management easier, let’s give this rule a name. Click to select the newly created rule, then click **Rename** under **Inbound Rules** on the right.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410050492/r5er2UIDl.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

Name it “**Test App**” or something else appropriate. I recommend naming it exactly the same as the name in your PM2 configuration.

1. With the rule still selected, click **Edit…** under **Inbound Rules** on the right.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410052075/ThFJXERfj.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>

1. In the **Pattern** box, type `testapp/?(.*)` and click **Apply**. You can replace `testapp` with whatever you like, but I recommend naming it similar to the Node.js app directory, the PM2 name, and the URL Rewrite rule.

Now any request to [http://localhost/testapp](http://localhost/testapp) any any URLs deeper in that path will be proxied to our Node.js app.

Load up the web browser one more time and check it out.

<figure><img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1627410053576/BrDS7owVQ.png?auto=compress,format&#x26;format=webp" alt=""><figcaption></figcaption></figure>



***

## REFERENCES

* [https://travishorn.com/reverse-proxying-node-js-apps-on-windows-with-iis-acee318b6759](https://travishorn.com/reverse-proxying-node-js-apps-on-windows-with-iis-acee318b6759)



