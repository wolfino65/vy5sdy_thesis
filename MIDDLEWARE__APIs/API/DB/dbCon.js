const { MongoClient } = require("mongodb");

const client = new MongoClient(process.env.MONGO_CON_URI);
try {
    await client.connect();
}
catch (e) {
    console.log(e);
}
export default client;