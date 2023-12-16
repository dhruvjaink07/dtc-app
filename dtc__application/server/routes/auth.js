const express = require('express'); 
const router = express.Router();
const bcrypt = require('bcrypt') // package required to hash the password so can be stored safely
const User = require('../models/user');
const fetchuser = require('../middleware/fetchUser');


// Register route 
router.post('/register', async (req, res) => {
  try {
    // Debug Statements very useful sometimes
    // console.log('Register Request Body:', req.body); 
    const { name, email,password } = req.body;

    // Hashing the password 
    const hashedPassword = await bcrypt.hash(password, 10);

    // Creating a new User 
    const user = new User({ name, email,password: hashedPassword });
    // Saving the User on Database
    await user.save();
    // Response After Successful user creation
    res.json({ message: 'Registration successful' });

  } 
  // To Handle Conditions like Server Error or If User with same username tries to register 
  catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
    // console.log(error);
  }
});

// Login route
router.post('/login', async (req, res) => {
  try {
    // Debug Statements very useful sometimes
    // console.log('Login Request Body:', req.body); 
    const { email, password } = req.body;

    // Fetching a particular user from Database
    const user = await User.findOne({ email });

    // Executes only when the user with that username is found
    if (user) {
      // Compare the entered password with the hashed password
      const passwordMatch = await bcrypt.compare(password, user.password);

      // if user entered password and hashed password matches
      if(passwordMatch){
      
      // User Logged In
      res.json({ message: 'Login successful' });
      }

      // else if user not found
    } else {
      res.status(401).json({ error: 'Invalid credentials' });
    }
  } 
  // Handle Exceptional Conditions
  catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
    // console.log(error);
  }
});


// forget password or update password
// Update password route
// router.put('/update-password', fetchuser, async (req, res) => {
router.put('/update-password', async (req, res) => {
  console.log('Update Password Request Body:', req.body);
  try {
    const { email,oldPassword, newPassword } = req.body;
    const user = await User.findOne({email:email});

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Verify the old password
    const passwordMatch = await bcrypt.compare(oldPassword, user.password);

    if (passwordMatch) {
      // Hash and update the new password
      const hashedPassword = await bcrypt.hash(newPassword, 10);
      user.password = hashedPassword;
      await user.save();

      res.json({ message: 'Password updated successfully' });
    } else {
      res.status(401).json({ error: 'Incorrect old password' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
module.exports = router;

