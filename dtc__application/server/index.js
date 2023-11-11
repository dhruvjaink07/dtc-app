require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/auth');


const app = express();
const port = 3000; 

// Body parser middleware
app.use(bodyParser.json());
const connectionString = 'mongodb+srv://imbetter27:dtcbackend094@cluster0.b1e7573.mongodb.net/CustomAuth';
// console.log(process.env.DB_URI);

// MongoDB connection
mongoose.connect(connectionString, {
})
.then(() => console.log('MongoDB connected'))
.catch(err => console.log(err));

// Routes
app.use('/auth', authRoutes);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
 
