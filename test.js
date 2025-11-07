import mongoose from "mongoose";

const uri = "mongodb+srv://appuser:yash123@cluster0.fbxe5bc.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

mongoose
  .connect(uri)
  .then(() => console.log("✅ Connected"))
  .catch(err => console.log("❌ Error:", err));
