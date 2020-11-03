# Payments


Initializes a new payment object which is the object used through out the checkout flow for a particular customer and order. Creating a payment object is the first step when you intent to accept a payment from you customer. Typically you provide the following information:
      
- The **order details** including order items, total amount, and currency
      
- **Checkout page settings** which specifies what type of integration you want: a checkout page **embedded** on your site or a pre-built checkout page **hosted** by Nets. You can also specify data about your customer to have the form on the checkout page prepopulated.
      
      
Optionally, you can also provide information regarding:
      
- **Notifications** if you want to be notified through **webhooks** when the status of the payment changes
      
- What **payment methods** you want to offer your customers
      
      
On success, this method returns a <code>paymentId</code> which can be used in subsequent request to refer to the newly created payment object. Optionally, the response object will also contain a <code >hostedPaymentPageUrl</code> which is the URL you should redirect to when using a hosted pre-built checkout page. 


## Parameters

<code>Authorization</code> **required** string

Private API key.


<code>CommercePlatformTag</code> optional string

A tag that identifies the e-commerce platform, if any. 


## Request body

* <code>order</code> **required** object
 A customer order.

 * amount required integer
  Total amount of the order including VAT.

 * currency required string
  Possible values are <code>SEK</code>, <code>NOK</code>

 * <code>items</code> required array
  Array of order items.

  * <code>L3</code> 

 L2: <code>reference</code> required string

Payment referene.


L1: 
      
      
      
      
