// FILE: src/seed/seeder.ts
import mongoose from "mongoose";
import dotenv from "dotenv";
import { catalogItemsData, quizQuestionsData, recRuleV1Data } from "../database/data/data";
import { QuizQuestion } from "../model/quiz_question_model";
import { Catalog } from "../model/catalog_model";
import { RecRule } from "../model/rec_rule_model";

dotenv.config();

const MONGO_URI = process.env.MONGO_URI;
if (!MONGO_URI) throw new Error("MONGODB_URI missing in .env");

// Connect to MongoDB
async function connectDB() {
  try {
    await mongoose.connect(MONGO_URI as string, {
      dbName: "hairfall_db",
      serverSelectionTimeoutMS: 30000,
      tls: true,
    });
    console.log("MongoDB Connected ✅");
  } catch (err) {
    console.error("MongoDB connection error ❌", err);
    process.exit(1);
  }
}

// Seed function
async function seed() {
  await connectDB();

  try {
    console.log("Seeding Quiz Questions...");
    await QuizQuestion.deleteMany({});
    await QuizQuestion.insertMany(quizQuestionsData);
    console.log("Quiz questions seeded ✅");

    console.log("Seeding Catalog...");
    await Catalog.deleteMany({});
    await Catalog.insertMany(catalogItemsData);
    console.log("Catalog seeded ✅");

    console.log("Seeding Recommendation Rules...");
    await RecRule.deleteMany({});
    await RecRule.insertMany(recRuleV1Data);
    console.log("Recommendation rules seeded ✅");

    await mongoose.connection.close();
    console.log("MongoDB connection closed. Seeder finished ✅");
    process.exit(0);
  } catch (err) {
    console.error("Seeding error ❌", err);
    await mongoose.connection.close();
    process.exit(1);
  }
}

seed();
