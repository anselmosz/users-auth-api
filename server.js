import app from "./src/app.js";
import "./src/config/env.js";

import swaggerUi from "swagger-ui-express";
import swaggerDocsJson from "./swagger.json" with {type: "json"};

const port = process.env.PORT || 8080;
const env_type = process.env.NODE_ENV || "development";

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocsJson));

app.listen(port, () => {
  console.log(`\n (${env_type}) server running at port ${port}`);
});
