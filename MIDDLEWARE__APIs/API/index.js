import express from 'express';
import bodyParser from 'body-parser';

var app = express();
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }));



app.listen(4500, () => {
    console.log("server started.")
}
)