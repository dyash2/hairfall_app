
import mongoose from "mongoose";

const RecRuleSchema = new mongoose.Schema({
  _id: { type: String, required: true }, 

  weights: { type: Object, required: true },

  priority: [{ type: String, required: true }],

  mapping: { type: Object, required: true },

  rationale: { type: Object, required: true },

  active: { type: Boolean, default: true }
});

export const RecRule = mongoose.model("rec_rules", RecRuleSchema,"rec_rules");
