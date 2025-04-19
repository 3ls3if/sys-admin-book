---
icon: gear
---

# Build and Run Node.js Project with Next.js



## Set Up Your Next.js Project

```
npx create-next-app@latest my-next-app
cd my-next-app
```

You’ll now have a basic Next.js project scaffolded.

## Run in Development Mode

To start the development server:

```bash
npm run dev
```

This will launch the app on `http://localhost:3000` by default.

## Build the Project (for Production)

To build the app for production:

```bash
npm run build
```

This creates an optimized production build in the `.next` directory.

## **Run the Production Build**

After building, you can start the production server:

```bash
npm run start
```

This serves the pre-built app on `http://localhost:3000`&#x20;

## Typical Scripts in `package.json`

```json
"scripts": {
  "dev": "next dev",
  "build": "next build",
  "start": "next start",
  "lint": "next lint"
}
```

## Additional Notes

* **API routes:** You can use Node.js-style API routes inside `pages/api/`. Next.js handles them like a serverless function.
* **Custom server (optional):** If you want full control over the Node.js server (e.g., with Express), you can do it, but it's **not required** for standard Next.js apps.



***

## REFERENCES

* [https://nextjs.org/docs/pages/building-your-application/deploying](https://nextjs.org/docs/pages/building-your-application/deploying)
