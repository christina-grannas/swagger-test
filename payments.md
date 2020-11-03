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

L1 <code>order</code> **required** object  
   A customer order.
  L2 <code>amount</code> required integer  
     Total amount of the order including VAT.
  L2 <code>currency</code> required string  
     Possible values are <code>SEK</code>, <code>NOK</code>
  L2 <code>reference</code> required string
     Payment referene.
  L2 <code>items</code> required array
    Array of order items.
    L3 <code>reference</code> required string
      Product reference.
    L3 <code>name</code> 
       Product name
       
       
       
       
       
       
    - quantity - Product quantity (mandatory)
unit - Product unit, for instance pcs or Kg (mandatory)
unitPrice - Product price per unit without VAT (mandatory)
taxRate - Product tax rate - defaults to 0 if not provided.
taxAmount - Product tax/VAT amount  - defaults to 0 if not provided. taxAmount should include the total tax amount for the entire order row.
grossTotalAmount - Product total amount including VAT (mandatory)
netTotalAmount - Product total amount excluding VAT (mandatory)





L1: 
      
      
      
      
