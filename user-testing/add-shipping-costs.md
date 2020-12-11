# Add shipping cost

It's possible to add shipping cost to your customer's order. Shipping costs are usually affected at the end of the payment flow when your customer's address is specified. To handle this, your site need to interact with the Easy Checkout during the payment session.

Shipping costs are added to the order as a regular item in the `order` object. However, 
To enable destination based shipping cost, merchant must set the shipping cost flag when creating the payment (checkout.shipping.merchantHandlesShippingCost):



![Update shipping cost](images/update-shipping-cost.png)



As a part of the shipping cost feature, we have implemented generic cart-updates. 

This guide will show you how to update the order items in an ongoing payment session using the Payment API. 


This method can be used to add or remove items to the cart, change the amount, quantity, etc on existing items or add or update shipping cost. Please note that shipping cost is an order line like any other order line. If the merchant handles shipping cost, the update cart must be invoked with shipping.costSpecified as shown in the example body:





## Before you start
This guide assumes that you already have a 

Merchant can update the order items in a cart by utilizing the new api-method: PUT "v1/payments/{paymentId}/orderitems". 


This method can be used to add or remove items to the cart, change the amount, quantity, etc on existing items or add or update shipping cost. Please note that shipping cost is an order line like any other order line. If the merchant handles shipping cost, the update cart must be invoked with shipping.costSpecified as shown in the example body:


A typical scenario where you want to update an existing payment session is when the customer changes the quantity of an item. 



To update the shipping cost we need to `PUT` a new `items` object to the path `/v1/payments/{paymentId}/orderitems`. The following code shows how calculate a new random shipping cost and update the shipping cost item in the order:

```php
<?php

$inputJSON = file_get_contents('php://input');
$body = json_decode($inputJSON, TRUE);

$paymentId = $body['paymentId'];
$postalCode = $body['postalCode'];
$countryCode = $body['countryCode'];

// Update shipping cost to some new random value
// Normally, the JSON object would have been
// created dynamically from the customer's 
// shopping cart
$payloadJSON = file_get_contents('shipping-cost.json');
$payload = json_decode($payloadJSON, true);
$shippingCost = rand(1000, 5000);
$totalAmount = 160000 + $shippingCost;
$payload['amount'] = $totalAmount;
$payload['items'][1]['grossTotalAmount'] = $shippingCost;

$ch = curl_init('https://test.api.dibspayment.eu/v1/payments/' . $paymentId . '/orderitems');
 curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
 curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
 curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                         
         'Content-Type: application/json',
         'Accept: application/json',
         'Authorization: b17758ca569047bdb574aaa2c32f1446'));                                                
 $result = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
 echo($result);

?>
```

We are usinga hard coded JSON template 
The JSON object that we will use for this example looks like this:

```json
{
  "amount": 162000,
  "items": [
    {
      "reference": "42",
      "name": "Demo product",
      "quantity": 2,
      "unit": "hours",
      "unitPrice": 80000,
      "grossTotalAmount": 160000,
      "netTotalAmount": 160000
    },
    {
      "reference": "shipping-cost",
      "name": "Delivery service",
      "quantity": 1.0,
      "unit": "NA",
      "unitPrice": 0,
      "taxRate": 0,
      "taxAmount": 0,
      "grossTotalAmount": 2000,
      "netTotalAmount": 0
    },

  ],
  "shipping": {
    "costSpecified": true
  }
}
```


Whenever





## Step 1: Set the merchantHandlesShippingCost flag in the "create payment" request

To be able to handle shipping costs, you need to pass the flag `merchantHandlesShippingCost` when creating the payment object using the method `POST /vi/payments` using the Payment API.


When the backend of your site creates the creating the payment object 
merchantHandlesShippingCost

```json
{
  "order": {
      "items": [
          {
              "reference": "42",
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
      "url": "https://<YOUR_SERVER>/checkout.html",
      "termsUrl": "https://<YOUR_SERVER>/terms.html",
      "shipping": {
        "countries": [],
        "merchantHandlesShippingCost": true
      }
  }
}
```

In the JSON object we specify that we want to add shipping cost to 
our order by setting `merchantHandlesShippingCost` to `true`. This will have the effect that Easy Checkout will not proceed with a payment unless a shipping cost has been added to the order.

Step 2: (frontend)

2. On the front-end (javascript), listen to the new event "address-changed"

3. When the address has changed (for example when the consumer changes the delivery address, or when the consumer was initially identified in the checkout):
 3.1 Recalculate the shipping cost
 3.2 Update the cart using the new update cart functionality in the payment api (see the "update cart" documentation above), remember to set the shipping.costSpecified flag when updating the cart 

4. If the cart has been updated with the shipping cost (pt 3.2 above), the consumer can continue by clicking pay.