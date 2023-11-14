const express = require('express');
const router = express.Router();
const User = require('../models/user');

// Register route
router.post('/register', async (req, res) => {
  try {
    console.log('Register Request Body:', req.body); 
    const { username, password } = req.body;
    const user = new User({ username, password });
    await user.save();
    res.json({ message: 'Registration successful' });
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
    // console.log(error);
  }
});

// Login route
router.post('/login', async (req, res) => {
  try {
    console.log('Login Request Body:', req.body); 
    const { username, password } = req.body;
    const user = await User.findOne({ username, password });
    if (user) {
      res.json({ message: 'Login successful' });
    } else {
      res.status(401).json({ error: 'Invalid credentials' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
    // console.log(error);
  }
});

module.exports = router;

