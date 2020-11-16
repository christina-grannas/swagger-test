# Integrate Easy Checkout (web)


## Who is this guide for?


This guide is for developers who want to add online payments to their website using Easy Checkout.


## Before you start

Before you start you need:

1. An Easy Portal Account (Why?)
2. Your Integration keys for the website you are developing
3. Basic skills in HTML, JavaScript, and JSON (JavaScript Object Notation)


## Overview

Easy Checkout is a platform for online payments. It supports one-time payments and recurring payments (subscriptions). Payment methods supported by Easy Checkout include cards, invoices, installments, and digital wallets such as Swish, Vipps, and MobilePay.


The backend server of your website communicates with Nets Easy Checkout over RESTful APIs using your Secret API key. The frontend of your website uses Checkout.js provided by Nets to handle the API integration with Easy Checkout. The frontend of your site uses the Merchant key to identify your webshop when communicating with Nets.
  

Nets Easy, also provides a ready-made checkout page that can be customized and embedded into your webshop. 
What you are building
In this guide, you will embed a checkout page to your webshop in five steps:

1. Initiate the checkout from your site (frontend)
2. Create a payment object (backend)
3. Use Checkout.js to build checkout iframe (frontend)
4. Add a complete payment page (frontend)
5. Test your checkout page
  



## 1. Initiate the checkout from your site (frontend)
The checkout is initiated from the client. We will start implementing the checkout flow from the frontend by adding:
* A `<button>` that will allow the customer to initiate the checkout
* A `<div>` that will embedded the checkout page.
* An JavaScript event handler attached to the button
We'll begin with a minimal HTML page:

```html
<!DOCTYPE html>
<html>
 <head><title>Your site</title></head>
 <body>
   <button id="checkout-button">Checkout!</button>
   <div id="checkout-container-div"></div>
   <script src="https://test.checkout.dibspayment.eu/v1/checkout.js?v=1"></script>
   <script src="shop.js"></script>
 </body>
</html>
```

Two JavaScripts are embedded: Checkout.js and our custom shop.js where we will put all our JavaScript code for this example.


The id of the `<div>` element, checkout-container-div, is needed later on so that Checkout.js knows where to embed the checkout content. Next, let's create an event listener for our button: 



```javascript
var button = document.getElementById('checkout-button');
button.addEventListener('click', function () {
   var request = new XMLHttpRequest();
   request.open('GET', 'your-backend/create-payment', true);
   request.onload = function () {
       if (this.status == 200) {               // Ignore errors for now
           // Success!
           var data = JSON.parse(this.response);
           var paymentId = data.paymentId;
           checkout_func(paymentId);       
       }
   };
   request.send();
});
var checkout_func = function (paymentId) { 
   console.log(paymentId);
  // To be implemented... 
}
```

When the customer clicks the button, this event handler will send an HTTP request to the backend of your site, which in turn will create a new payment object. We will get back to the frontside JavaScript in a while. But first, let's implement the backend responsible for creating the payment object.


## 2. Create a payment object (backend)


Each payment session is represented by a payment object. In order to start a checkout flow for your customer, you first need to create a payment object and retrieve the paymentId for that object. Creating a payment object requires your Secret API key. Therefore, this request has to be initiated from the backend of your site: 



```php
<?php   
  $payload = get_request_body(); // Returns a JSON string  
   $ch = curl_init('https://test.api.dibspayment.eu/v1/payments');                                                                    
   curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");                                                                   
   curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);                                                                
   curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);                                                                    
   curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                        
       'Content-Type: application/json',
       'Accept: application/json',
       'Authorization: b17758ca569047bdb574aaa2c32f1446')                                                                 
   );                                                                                                                                                              
   $result = curl_exec($ch);
   echo($result);        // Forward result back to frontend
?>
```

The request body we send JSON object defined like this:

```json
{
  "order": {
    "items": [
      {
        "reference": "ref42",
         "name": "Demo product",
         "quantity": 2,
         "unit": "hours",
         "unitPrice": 80000,
         "grossTotalAmount": 160000,
         "netTotalAmount": 160000
       }
     ],
     "amount": 160000,
     "currency": "SEK",
     "reference": "Demo Order"
  },
  "checkout": {
    "integrationType": "EmbeddedCheckout",       
    "url": "https://example.se/shop/checkout",   // Replace!
    "termsUrl": "https://example.com/shop/terms" // Replace!
  }
}
```

Make sure you replace the line:
```json
  "url": "https://example.se/shop/checkout",
```
with the URL to the checkout page on your site, or the page will fail to load later on when we use the JavaScript library Checkout.js. 


The request body includes:

* Order details including order items, total amount, and currency
* Checkout page settings which specify that you want to embed the checkout view on your page (rather than using a pre-built checkout page hosted by Nets).
* The url to your site
This is a minimal example just to get started. There are numerous settings that can be specified when creating or updating a payment object that are not covered here. See the guides Updating order, Add shipping cost, and the API reference for more info.


You should now be able to click the "Checkout!" button and thereafter see the paymentId printed to the JavaScript console in your web browser. Here an example of how the console should look after clicking the button:  






Now when the backend part is implemented it's time to go back to the frontend code and use the paymentId to create the payment view.


## 3. Use Checkout.js to build checkout iframe

Once we have a paymentId, we can create the payment form using a JavaScript library provided by Nets, called Checkout.js which is fully documented in the  API reference. First you need to load it:

```html
<script src="https://test.checkout.dibspayment.eu/v1/checkout.js?v=1"></script>
```

Since we are using the test environment, you should load the JavaScript from test.checkout.dibspayment.eu. 


Now we are ready to implement the function checkout_func() which we left empty in step 1. Here is the code for creating the checkout view using Checkout:
 
 ```javascript
var checkout_func = function (paymentId) {
  console.log(paymentId);
   var checkoutOptions = {
       checkoutKey: "YOUR_CHECKOUT_KEY",    // Replace!
       paymentId: paymentId,
       containerId: "checkout-container",
   };
   var checkout = new Dibs.Checkout(checkoutOptions);
   checkout.on('payment-completed', function (response) {
      // Redirect to a custom pay created in the next step
      window.location = '/shop/payment-completed.html';
   });
}
```

For the Checkout.js script to load correctly, it's important that you have specified the correct URL to your checkout page in step 3. 


The checkout object will fire the event 'payment-completed' once the payment has completed. The callback function we provide navigate to payment-completed.html which we will create in the next step. 


## 4. Add a complete payment page


Add the following page to your site and name it payment-completed.html:

```html
<!DOCTYPE html>
<html>
 <head><title>Payment completed</title></head>
 <body>
  <h1>Payment completed!</h1>
  <a href="index.html">Try again</a>
 </body>
</html>
```

That's it! Now it's time test and verify that your new embedded checkout page is working.


## 5. Test your checkout page

You should now have a rudimentary checkout page that can be tested using the test cards that can be found at the page Test environment.


Here is how you test your new checkout page:


1. Reload the index.html page
2. Click the "Checkout!" button
3. Fill out the address form using your email, phone, and postal code
4. Insert any of the sample card number 
5. Fill the Expire date field with the month and year of today
6. Fill the CVC field with three arbitrary digits (123 for example)
7. Click the "Pay" button


The simulated payment processing should now start and eventually get you back to the payment-completed.html page you created in the previous step.


Troubleshooting






Report a problem
support@nets.se