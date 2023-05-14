const express = require ('express');
const bcryptjs = require ('bcryptjs');
const User =  require("../models/users");
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

authRouter.post('/api/signup', async (req, res)=>{

    try{
        const {name, email, password} =  req.body;
  
   const existUser =  await user.findOne({email});
   if(existUser){
    return res.status(400).json({msg: 'User with the email already exist'});
   }

   const  hashedPass = await bcryptjs.hash(password, 8)

  let users =  new User({
    email,
    password: hashedPass,
    name,
   })

   users = await users.save();
   res.json(users);
    }catch(e){
        res.status(500).json({error: e.message});
    }
   
    //post data to db
    //return data
});



authRouter.post('/api/signin', async(req, res)=> {
    try{
        const  {email, password} = req.body;

        const users = await User.findOne({email});

        if(!users){
            return res.status(400).json({msg: "user email doesn't exist"});
            
        }

        const isMatch = bcryptjs.compare(password, users.password);

        if(!isMatch){
            return res.status(400).json({error: 'Incorrect password'})
        }

       const token = jwt.sign({id: users._id}, "passwordKey");
       res.json({token, ...users._doc})

    }catch(e){
        res.status(500).json({error: e.message});
    }
});

authRouter.post ('/tokenIsValid', async (req, res) => {
  try {
    const token = req.header ('x-auth-token');
    if (!token) return res.json (false);
    const verified = jwt.verify (token, 'passwordKey');
    if (!verified) return res.json (false);

    const user = await User.findById (verified.id);
    if (!user) return res.json (false);
    res.json (true);
  } catch (e) {
    res.status (500).json ({error: e.message});
  }
});


authRouter.get('/', auth, async(req, res) => {
    const users = await User.findById(req.user);
    res.json({...users._doc, token: req.token});
})

module.exports = authRouter;