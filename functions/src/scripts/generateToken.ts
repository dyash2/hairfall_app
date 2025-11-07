import admin from "../index"; // your initialized admin
import dotenv from "dotenv";

dotenv.config();

async function main() {
  const uid = "test-user-123";
  try {
    const customToken = await admin.auth().createCustomToken(uid);
    console.log("Custom Token (for Postman/frontend login):");
    console.log(customToken);
  } catch (err) {
    console.error("Error generating token:", err);
  }
}

main();
