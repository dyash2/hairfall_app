import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import admin from "firebase-admin";
import * as serviceAccount from "../serviceAccountKey.json";
import { onRequest } from "firebase-functions/v2/https";
import { verifyFirebaseAuth } from "./middleware/auth";
import QuizController from "./controllers/QuizController";
import CatalogController from "./controllers/CatalogController";
import RecommendController from "./controllers/RecommendController";

dotenv.config();

const app = express();
app.listen(5000, "0.0.0.0", () => {
  console.log("Server running on http://0.0.0.0:5000");
});

app.use(express.json());

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

export default admin;

// ------------------ MONGO CONNECTION ------------------
const MONGO_URI = process.env.MONGO_URI;

if (!MONGO_URI) {
    throw new Error(" MONGO_URI missing in .env");
}

mongoose
    .connect(MONGO_URI, { dbName: "hairfall_db" })
    .then(() => console.log(" MongoDB Connected"))
    .catch((err) => console.log(" MongoDB Error:", err));

// ------------------ ROUTES ------------------
app.get("/", (req, res) => {
    res.json({ message: "Backend Working ✅" });
});

app.get("/quiz",QuizController.getQuiz);
app.get("/catalog", CatalogController.getCatalog);
app.post("/recommend", verifyFirebaseAuth,RecommendController.createRecommendation);


// ------------------ EXPORT FUNCTION ------------------
export const api = onRequest(
    { region: "asia-south1" },
    app
);
