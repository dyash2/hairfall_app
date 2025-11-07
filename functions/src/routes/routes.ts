import Express from "express";
import { verifyFirebaseAuth } from "../middleware/auth";
import QuizController from "../controllers/QuizController";
import RecommendController from "../controllers/RecommendController";
import CatalogController from "../controllers/CatalogController";


const router = Express.Router();

router.get("/quiz", verifyFirebaseAuth, QuizController.getQuiz);
router.post("/recommend", verifyFirebaseAuth, RecommendController.createRecommendation);
router.get("/catalog", verifyFirebaseAuth, CatalogController.getCatalog);

export default router;