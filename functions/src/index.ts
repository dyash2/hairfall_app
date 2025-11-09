import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import { onRequest } from "firebase-functions/v2/https";
import admin from "firebase-admin";
import QuizController from "./controllers/QuizController";
import CatalogController from "./controllers/CatalogController";
import RecommendController from "./controllers/RecommendController";
// import { verifyFirebaseAuth } from "./middleware/auth";

dotenv.config();

const app = express();
app.use(express.json());

// Firebase Admin (Local Mode)
if (!admin.apps.length) {
    admin.initializeApp({
        credential: admin.credential.cert(require("../serviceAccountKey.json")),
    });
}

// MongoDB Connection
const MONGO_URI = process.env.MONGO_URI;
if (!MONGO_URI) {
    throw new Error("MONGO_URI missing in .env");
}
mongoose.connect(MONGO_URI, { dbName: "hairfall_db" })
    .then(() => console.log("MongoDB Connected"))
    .catch((err) => console.log(" MongoDB Error:", err));

// Routes
app.get("/", (req, res) => res.json({ msg: "Backend Running" }));
app.get("/quiz", QuizController.getQuiz);
app.get("/catalog", CatalogController.getCatalog);
app.post("/recommend", RecommendController.createRecommendation);

// // Run server on LAN so Android Device can connect
// app.listen(5000, "0.0.0.0", () => {
//     console.log("Server running at http://0.0.0.0:5000");
// });

export const api = onRequest(
    { region: "asia-south1" },
    app
);