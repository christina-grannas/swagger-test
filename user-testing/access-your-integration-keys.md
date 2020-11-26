# Integrate Easy Checkout (web)

## Who is this guide for?

This guide is for developers who want to add online payments to their website using Easy Checkout.

## Before you start

Before you start you need:

1. An [Easy Portal account](https://portal.dibspayment.eu). Need [help](create-account.md)?
2. Your [Integration keys](https://portal.dibspayment.eu/integration) for the website you are developing. Need [help](access-your-integration-keys.md)?
3. A running web server which can host static HTML pages and execute server side scripts. We will use PHP in this guide.
4. Basic skills in PHP, HTML, JavaScript, and JSON (JavaScript Object Notation)

## Overview

Easy Checkout is a platform for online payments. It supports one-time payments and recurring payments (subscriptions). [Payment methods](payment-methods.md) supported by Easy Checkout include card, invoice, installments, and digital wallets such as Swish, Vipps, and MobilePay.

The backend of your website communicates with Nets Easy Checkout over RESTful APIs using your Secret API key. The frontend of your website uses Checkout.js provided by Nets to handle the API integration with Easy Checkout. The frontend of your site uses the Merchant key to identify your webshop when communicating with Nets.

Nets Easy, also provides a ready-made checkout page that can be customized and embedded into your webshop.

## What you are building

In this guide, you will embed a checkout page to your webshop in six steps:

1. Initiate the checkout from your site (frontend)
2. Create a payment object (backend)
3. Add a checkout page (frontend)
4. Embed the checkout iframe using [Checkout.js](checkout-js.md) (frontend)
5. Add a "payment completed" page (frontend)
6. Test your checkout page

## Step 1: Initiate the checkout from your site (frontend)

The checkout is initiated from the client. We will start implementing the checkout flow from the frontend by adding:

- A `<button>` that will allow the customer to initiate the checkout
- An JavaScript event handler attached to the button

Create a file named `cart.html`. The content below will serve as a minimal starting point for the
payment flow:

```html
<!DOCTYPE html>
<!-- 
  cart.html 
-->
<html>
  <head>
    <title>Shopping Cart</title>
  </head>
  <body>
    <h1>Shopping Cart</h1>
    <button id="checkout-button">Proceed to Checkout</button>
    <script src="cart-helper.js"></script>
  </body>
</html>
```

The page contains a checkout button and embeds the JavaScript `cart-helper.js` which we will implement next.

Create the file `cart-helper.js` and add the following event listener for the checkout button:

```javascript
/*
  cart-helper.js
*/ 

document.getElementById('checkout-button').addEventListener('click', function () {
  var request = new XMLHttpRequest();
  request.open('GET', 'create-payment.php', true);
  request.onload = function () {
    if (this.status == 200) { 
      // Success!
      console.log('response: ' + this.response);
      const data = JSON.parse(this.response);
      window.location = 'checkout.html?paymentId=' + data.paymentId;
    } else {
      console.log('error: ', this.status); // Ignore errors for now
    }
  }
  request.onerror = function () {
    console.log('connection error');
  }
  request.send();
});

```

When clicking the checkout button, this event handler will send an asynchronous request over HTTPS to the backend of your site. If you try clicking the Checkout button now, you will receive a HTTP 404 error, because the script `create-payment.php` is not found yet. (You can verify this by inspecting the JavaScript Console in your browser). 

Let's fix this 404 error and turn to the backend and implement the `create-payment.php` script.

<!-- which in turn will create a new payment object. Let's turn to the backend and implement the `create-payment.php` script.-->

## Step 2: Create a payment object (backend)

Each payment session is represented by a payment object. In order to start a checkout flow for your customer, you first need to create a payment object and retrieve the `paymentId` referencing that object. Creating a payment object requires your [Secret API key](access-your-integration-keys.md). Therefore, this request has to be initiated from the backend of your site. Creating the payment object is the responsibility of the script `create-payment.php`.

Create a file called `create-payment.php` and add the following code to it:

```php
<?php
  /*
    create-payment.php
  */

  function get_request_body() {
    // Generate your JSON request body here...
    return '<YOUR_JSON_OBJECT_HERE>'; 
  }

  $payload = get_request_body(); // Returns a JSON string
   $ch = curl_init('https://test.api.dibspayment.eu/v1/payments');
   curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
   curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
   curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
   curl_setopt($ch, CURLOPT_HTTPHEADER, array(
       'Content-Type: application/json',
       'Accept: application/json',
       'Authorization: <YOUR_SECRET_API_KEY>') // Important: Replace with your key
   );
   $result = curl_exec($ch);
   echo($result);        // Forward result back to frontend
?>
```
Replace the text `<YOUR_SECRET_API_KEY>` with your [Secret API key](https://portal.dibspayment.eu/integration).

In this example, the function `get_request_body()` is just an empty placeholder.
This is the place where you should dynamically create a JSON object based on
your customers' order items. For now, you can just add a static JSON string. 
Below is an example that can be used for testing:


```json
{
  "checkout": {
    "integrationType": "EmbeddedCheckout",
    "url": "https://<YOUR_SERVER>/checkout.html",
    "termsUrl": "https://<YOUR_SERVER>/terms.htmtl"
  },
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
  }
}
```

The request body includes:

- **Integration type**: specifies whether you want to *embed* a checkout `iframe` on your page or use a pre-built checkout page hosted by Nets.
- **Checkout URL**: The URL to your checkout page. This URL need to match the URL to your checkout page exactly, including protocol (http/https) and the fully qualified domain name (FQDN).
- **Terms URL**: A URL to a page on your site that describes the payment terms for your webshop.
- **Order details**: Includes order items, total amount, and currency

---
**NOTE**

Make sure you replace the line:
```json
    "url": "https://<YOUR_SERVER>/checkout.html",
```
with the URL to the checkout page on your site, or the page will fail to load later on when using [Checkout.js](checkout-js.md). You should eventually replace the [`termsUrl`](https://example.com/api) as well, with a URL to your site describing your Payment Terms.

---


This is a minimal example just to get started. There are numerous settings that can be specified when creating or updating a payment object that are not covered here. See the guides Updating order, Add shipping cost, and the API reference for more info.

You should now be able to click the "Proceed to Checkout" button and thereafter see the `paymentId` printed to the JavaScript console in your web browser. Here an example of how the console should look after clicking the button:

Now when the backend is implemented it's time to go back to the frontend code and use the `paymentId` to create the checkout page with the payment view.

## Step 3: Add a checkout page (frontend)

It's time to create the HTML page that will embed the checkout `iframe`. Add the following HTML code into a new file called `checkout.html`:

```javascript
<!DOCTYPE html>
<!--
  checkout.html
-->
<html>
 <head><title>Checkout</title></head>
 <body>
  <h1>Checkout</h1>
   <div id="checkout-container-div">
     <!-- checkout iframe will be embedded here -->
   </div>
   <script src="https://test.checkout.dibspayment.eu/v1/checkout.js?v=1"></script>
   <script src="checkout-helper.js"></script>
 </body>
</html>
```


The container element `<div id="checkout-container-div">` is the place where we  will embed the checkout `iframe` eventually. Two JavaScripts are embedded: `checkout.js` from Nets and our own `checkout-helper.js` which we will implement in the next step.

Two JavaScripts are embedded:
- `checkout.js` provided by Nets. Since we are using the [test environment](test-environment.md) in this guide, you should load the JavaScript from `test.checkout.dibspayment.eu`.
- `checkout-helper.js`, our own JavaScript helper which we will implement in the next step.

The `checkout.html` page should always be requested with a URL parameter called `paymentId` since the `paymentId` is needed in order to identify the current payment session when communicating with Nets. 


## Step 4: Generate checkout iframe using `Checkout.js`

It's time to create the final JavaScript that will communicate with Nets Easy Checkout using `Checkout.js`. 

Create a file called `checkout-helper.js` and add the following JavaScript code:

```javascript
/*
  checkout-helper.js
*/

document.addEventListener('DOMContentLoaded', function () {
  const urlParams = new URLSearchParams(window.location.search);
  const paymentId = urlParams.get('paymentId');
  if (paymentId) {
    const checkoutOptions = {
      checkoutKey: '<YOUR_CHECKOUT_KEY>', // Replace!
      paymentId: paymentId,
      containerId: "checkout-container-div",
      theme: {
        buttonRadius: "5px"
      }
    };
    const checkout = new Dibs.Checkout(checkoutOptions);
    checkout.on('payment-completed', function (response) {
      window.location = 'payment-completed.html';
    });
  } else {
    console.log("Expected a paymentId");   // No paymentId provided, 
    window.location = 'cart.html';         // go back to cart.html
  }
});
```

Replace `<YOUR_CHECKOUT_KEY>` with your [checkout key](https://portal.dibspayment.eu/integration) for the [test environment](test-environment.md).

For the `Checkout.js` script to load correctly, it's important that you have specified the correct URL to your checkout page in step 3.

The checkout object will fire the event `'payment-completed'` once the payment has completed. The callback function we provide navigate to `payment-completed.html` which we will create in the next step.


## Step 5: Add a complete payment page

Add the following page to your site and name it payment-completed.html:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Payment completed</title>
  </head>
  <body>
    <h1>Payment completed!</h1>
    <a href="cart.html">Try again</a>
  </body>
</html>
```

That's it! Now it's time test and verify that your new embedded checkout page is working.

## Step 6: Test your checkout page

You should now have a rudimentary checkout page that can be tested using the test cards that can be found at the page [Test environment](test-environment.md).

Here is how you test your new checkout page:

1. Reload the `cart.html` page
2. Click the "Proceed to Checkout" button
3. Fill out the address form using your email, phone, and postal code
4. Insert any of the sample card numbers
5. Fill the "Expire date" field with the month and year of today
6. Fill the "CVC" field with three arbitrary digits (123 for example)
7. Click the "Pay" button

The simulated payment processing should now start and eventually get you back to the `payment-completed.html` page you created in the previous step.

## Troubleshooting

- Verify that you are using the correct [Integration keys](access-your-integration-keys.md) for the [test environment](test-environment.md).
- `Checkout.js` will fail to load unless you provide the correct checkout URL in the JSON body specified in the server-to-server request when creating the `paymentId`.
- When changing the checkout URL, make sure you reload `cart.html` so that a new payment session is created (and a new `paymentId`).


## Next steps

- Recurring payments
- Customize payment UI
- Add shipping cost
- Add payment methods

## Report a problem

support@nets.se
