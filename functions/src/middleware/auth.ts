import admin from "firebase-admin";
import { Request, Response, NextFunction } from "express";

declare global {
  namespace Express {
    interface Request {
      user?: any;
    }
  }
}

// export const verifyFirebaseAuth = async (
//   req: Request,
//   res: Response,
//   next: NextFunction
// ): Promise<void> => {
//   try {
//     const token = req.headers.authorization?.split(" ")[1];
//     if (!token) {
//       res.status(401).json({ error: "No token provided" });
//       return;
//     }

//     const decoded = await admin.auth().verifyIdToken(token);
//     req.user = decoded;
//     next();
//   } catch (err) {
//     res.status(401).json({ error: "Invalid token" });
//   }
// };


export const verifyFirebaseAuth = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      res.status(401).json({ error: "No token provided" });
      return
    }

    const token = authHeader.split(" ")[1]; // "Bearer <token>"
    if (!token) {
      res.status(401).json({ error: "Invalid auth header" });
      return;
    }
    const decodedToken = await admin.auth().verifyIdToken(token);
    req.user = decodedToken; // contains uid, email, etc.
    next();
  } catch (err) {
    console.error("Auth error:", err);
    res.status(401).json({ error: "Invalid token" });
  }
};