const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const config = require('./config');
const sqlManager = require('./models/sql');
const morgan = require('morgan');

const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());
app.use('/images', express.static('public/images/'));
app.use(morgan('dev'));

//api routes
app.use('/brand', require('./routes/brand.routes.js'));
app.use('/cartype', require('./routes/carType.routes.js'));
app.use('/user', require('./routes/user.routes.js'));
app.use('/car', require('./routes/car.routes.js'));
app.use('/insurance', require('./routes/insurance.routes.js'));
app.use('/order', require('./routes/order.routes.js'));
app.use('/faq', require('./routes/faq.routes.js'));
app.use('/fueltype', require('./routes/fuelType.routes.js'));

sqlManager.connectDB(function (err) {
    if (err) {
        throw err;
    }
    console.log("Database connected");
});

app.listen(config.port, () => {
    console.log(`Server is running on port ${config.port}.`);
});
