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
<pre>
      

1 order required object  
1 A customer order.  

 2 amount required integer   
 2 Total amount of the order including VAT.  

 2 currency required string   
 2 Possible values are SEK, NOK
  
 2 reference required string  
 2 Payment referene.  
  
 2 items required array  
 2 Array of order items.  
 
  3 reference required string  
  3 Product reference.  
  
  3 name required string
  3 Product name.
       
  3 quantity required string
  3 Product quantity.

  3 unit required string
  3 Product unit, for instance pcs or Kg
  
  3 unitPrice required string
  3 Product price per unit without VAT.
  
  3 grossTotalAmount required number
  3 Product total amount including VAT

  3 netTotalAmount required 
  3 Product total amount excluding VAT

  3 taxRate optional number
  3 Product tax rate. Defaults to 0 if not provided.

  3 taxAmount optional number
  3 Product tax/VAT amount. Defaults to 0 if not provided. Should include the total tax amount for the entire order row.
  
  3 grossTotalAmount required number
  3 Product total amount including VAT

  3 netTotalAmount required 
  3 Product total amount excluding VAT

       
</pre>
       
       
       
    - 




L1: 
      
      
      
      
