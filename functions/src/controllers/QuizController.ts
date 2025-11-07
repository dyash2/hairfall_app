import { Request, Response } from "express";
import { QuizQuestion } from "../model/quiz_question_model";

class QuizController {
    getQuiz = async (_req: Request, res: Response) => {
        try {
            const questions = await QuizQuestion.find({ active: true }).sort({ order: 1 });
            return res.status(200).json({ questions });
        } catch (err) {
            console.error(err);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    };
}

export default new QuizController();
