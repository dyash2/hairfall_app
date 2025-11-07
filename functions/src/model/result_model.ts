import mongoose from "mongoose";

const ResultSchema = new mongoose.Schema({
  user_id: { type: String, required: true },

  answers: { type: Object, required: true },

  scores: { type: Object, required: true },

  primary_cause: { type: String, required: true },

  products: [{ type: String, required: true }],

  created_at: { type: Date, default: Date.now }
});

export const Result = mongoose.model("recommendations", ResultSchema);
