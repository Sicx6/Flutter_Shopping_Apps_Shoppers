const express = require ('express');
const productRouter = express.Router ();
const auth = require('../middleware/auth');
const {Product} = require("../models/product");



productRouter.get ('/api/products', auth, async (req, res) => {
  try {
    console.log(req.query.category)
    const products = await Product.find ({category: req.query.category});
    res.json (products);
  } catch (e) {
    res.status (500).json ({error: e.message});
  }
});

productRouter.get ('/api/products/search/:name', auth, async (req, res) => {
  try {
    console.log (req.params.name);
    const products = await Product.find({
    name: { $regex: req.params.name, $options: "i" },
    });
    res.json (products);
  } catch (e) {
    res.status (500).json ({error: e.message});
  }
});

productRouter.post('/api/rate_product', auth, async (req, res) => {

  try{
    const {id, rating} = req.body;

    let product =  await Product.findById(id);

    for(let i = 0; i< product.rating.length; i++){

      if(product.rating[i].userId == req.user){
        product.rating.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.rating.push(ratingSchema);
    product = await product.save();
    res.json(product);


    


  }catch(e){
    res.status(500).json({error: e.message});
  }
})

productRouter.get('/api/deals-of-day', auth, async (req, res) => {
    try{

      let product = await Product.find({});

      product.sort((a, b) => {
        let aSum = 0;
        let bSum = 0;

        for(let i=0; i<a.length; i++){
          aSum = a.rating[i].rating;


        }
        for (let i = 0; i < b.length; i++) {
          bSum = b.rating[i].rating;
}
        return aSum < bSum ? 1 : -1;
      });

      res.json(product[0]);

    }catch(e){
      res.status(500).json({error: e.message})
    }
} )


module.exports = productRouter;
