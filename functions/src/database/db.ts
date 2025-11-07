import { MongoClient, Db } from "mongodb";

let cachedDb: Db | null = null;

export async function getDb(): Promise<Db> {
  if (cachedDb) return cachedDb;

  const uri = process.env.MONGO_URI;
  if (!uri) throw new Error("MONGO_URI missing");

  const client = new MongoClient(uri);
  await client.connect();
  cachedDb = client.db();
  return cachedDb;
}
