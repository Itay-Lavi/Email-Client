 const config = {
    port: +process.env.PORT!,
     jwt: {
      key: process.env.JWT_SECRET as string
     }
  }
  
  export default config;