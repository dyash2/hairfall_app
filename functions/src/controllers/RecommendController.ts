import { Request, Response } from "express";
import { RecRule } from "../model/rec_rule_model";
import { Catalog } from "../model/catalog_model";
import { Result } from "../model/result_model";

class RecommendController {
  createRecommendation = async (req: Request, res: Response) => {
  try {
    const { answers, rules_version = "v1" } = req.body;
    const userId = req.user?.uid;
    if (!userId) return res.status(401).json({ error: "Unauthorized" });
    if (!answers || typeof answers !== "object") return res.status(400).json({ error: "Invalid answers object" });

    const rule = await RecRule.findById(rules_version);
    if (!rule) return res.status(400).json({ error: "Rules version not found" });

    // Compute scores
    let scores: Record<string, number> = {};
    for (const key in answers) {
      const option = answers[key];
      const weightObj = rule.weights[key]?.[option];
      if (weightObj) {
        for (const cause in weightObj) {
          scores[cause] = (scores[cause] || 0) + weightObj[cause];
        }
      }
    }

    // Determine primary cause
    const maxScore = Math.max(...Object.values(scores));
    const topCauses = Object.keys(scores).filter(cause => scores[cause] === maxScore);
    const primary_cause = topCauses.find(cause => rule.priority.includes(cause)) || null;

    // Get product info
    const productIds = primary_cause ? rule.mapping[primary_cause] : [];
    const products = await Catalog.find({ _id: { $in: productIds } });

    // Save recommendation
    await Result.create({
      user_id: userId,
      answers,
      scores,
      primary_cause,
      products: productIds,
      created_at: new Date()
    });

    return res.status(200).json({
      scores,
      primary_cause,
      products,
      rationale: primary_cause ? rule.rationale[primary_cause] : null
    });

  } catch (error) {
    console.error("Recommend Error:", error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

}

export default new RecommendController();
