/*
Name: Backend for DTC
Developers (Current): Dhruv & Maaz 
Initiate Date: 10-11-23
Last Updated: 15-11-23
*/

// require('dotenv').config();
const express = require('express'); // Provides Routing Mechanism
const mongoose = require('mongoose'); // used for Database Connectivity
const bodyParser = require('body-parser');
const fetchuser = require('./middleware/fetchUser'); // Importing the fetch User Middleware to keep the user signed In
const authRoutes = require('./routes/auth'); // path for routes (i.e. register and Login)
var cors = require('cors'); // Used to follow cors policy 

// app is an instance of the Express.js framework, representing the web application, used to define and configure routes and middleware for handling HTTP requests
const app = express();
const port = 3000; // Port Number on which the backend Runs


app.use(cors())
app.use(express.json())
app.use(cors({ origin: 'http://localhost:' }));



app.options('*', cors());
const connectionString = 'mongodb+srv://imbetter27:dtcbackend094@cluster0.b1e7573.mongodb.net/CustomAuth';
// console.log(process.env.DB_URI);

// MongoDB connection
mongoose.connect(connectionString, {
})
.then(() => console.log('MongoDB connected'))
.catch(err => console.log(err));

// Routes
// app.use('/auth',fetchuser,authRoutes);
app.use('/auth',authRoutes);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
 
