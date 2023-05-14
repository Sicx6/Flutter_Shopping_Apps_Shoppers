const express = require ('express');
const adminRouter = express.Router();
const admin = require ('../middleware/admin');
const {Product} = require ('../models/product');
const Order = require('../models/orders');


// Add product
adminRouter.post('/admin/add-product', admin, async (req, res) => {
  try {
    const {name, description, images, quantity, price, category} = req.body;

    console.log (req.body);

    let product = new Product ({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save ();
    res.json(product);
  } catch (e) {
    res.status(500).json({error: e.message});
  }
});

adminRouter.get('/admin/get-products', admin,  async(req, res) =>{
    try{
      const products = await Product.find({});
      res.json(products);
    }catch(e){
      res.status(500).json({error: e.message});
    }
});

adminRouter.post('/admin/delete-products', admin, async (req, res) => {
  try{
    const {id} = req.body;
    let product = await Product.findByIdAndDelete(id); 


    res.json(product);


  }catch(e){
     res.status(500).json({error: e.message});
  }
})


adminRouter.get('/admin/get-orders', admin, async(req, res) => {
  try{

    const order = await Order.find({});
    res.json(order);  

  }catch(e){
    res.status(500).json({error: e.message});
  }
})


adminRouter.post ('/admin/change-order-products', admin, async (req, res) => {
  try {
    const {id, status} = req.body;
    let order = await Order.findById(id);
    order.status = status;

    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status (500).json ({error: e.message});
  }
});

adminRouter.get('/admin/analytics', admin,  async(req, res)=> {
  try{
  const orders = await Order.find({});
  let totalEarning  = 0;
  for(let i = 0; i<orders.length; i++){
    for(let j= 0; j<orders.product[j];  j++){
      totalEarning += orders[i].product[j].quantity * orders[i].product[j].price;

    }
  }

  //category wise orders fetching
  let mobileEarning = await fetchCategoriesWiseProduct('Mobiles');
  let essentialsEarning = await fetchCategoriesWiseProduct('Essentials');
  let appliancesEarning = await fetchCategoriesWiseProduct('Appliances');
  let booksEarning = await fetchCategoriesWiseProduct('Books');
  let fashionEarning = await fetchCategoriesWiseProduct('Fashions');

  let earnings = {
    totalEarning,
    mobileEarning,
    essentialsEarning,
    appliancesEarning,
    booksEarning,
    fashionEarning,
  };

  res.json(earnings);


  }catch(e){
res.status (500).json ({error: e.message});

  }
})

async function fetchCategoriesWiseProduct (category){
  let earnings = 0;
  let categoryOrders = await Order.find({
    'products.product.category' : category,
  });

  for (let i = 0; i < categoryOrders; i++) {
  for (let j = 0; j <categoryOrders; j++) {
    earnings += categoryOrders[i].product[j].quantity * categoryOrders;[i].product[j].price;

    
  }
}
return earnings;

}


module.exports = adminRouter;



