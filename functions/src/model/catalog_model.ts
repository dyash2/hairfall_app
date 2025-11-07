
import mongoose from "mongoose";

const CatalogSchema = new mongoose.Schema({
    _id: { type: String, required: true },
    name: { type: String, required: true },
    type: { type: String, required: true },
    copy: { type: String, required: true },
    warnings: [{ type: String }]
});

export const Catalog = mongoose.model("catalog", CatalogSchema,"catalog_items");
