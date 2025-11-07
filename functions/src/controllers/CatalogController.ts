import Express from "express";
import { Catalog } from "../model/catalog_model";

class CatalogController {
    getCatalog = async (request: Express.Request, response: Express.Response) => {
        try {
            const catalog = await Catalog.find({});
            return response.status(200).json({ data: catalog });
        } catch (error) {
            console.error("Error fetching catalog:", error);
            return response.status(500).json({ error: "Server Error" });
        }
    }

}

export default new CatalogController();

