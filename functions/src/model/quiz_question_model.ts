import mongoose from "mongoose";

const QuizQuestionSchema = new mongoose.Schema({
    _id: { type: String, required: true },
    title: { type: String, required: true },
    options: [
        {
            key: { type: String, required: true },
            label: { type: String, required: true }
        }
    ],
    order: { type: Number, required: true },
    active: { type: Boolean, default: true }
});

export const QuizQuestion = mongoose.model(
    "QuizQuestion",
    QuizQuestionSchema,
    "quiz_questions" // Important fix
);
