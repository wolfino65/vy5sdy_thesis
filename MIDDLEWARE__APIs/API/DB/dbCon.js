import { MongoClient } from "mongodb"

const client = new MongoClient("mongodb+srv://wolfino6565:Dell25L65!@szakdolgozat.uqwvi.mongodb.net/?retryWrites=true&w=majority&appName=szakdolgozat");
try {
    await client.connect();
}
catch (e) {
    console.log(e);
}
let db = client.db("szakd");
//console.log( await db.listCollections())

export default db;