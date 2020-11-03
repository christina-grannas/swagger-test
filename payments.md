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
      

x order required object  
  A customer order.  

xx amount required integer   
   Total amount of the order including VAT.  
xx currency required string   
   Possible values are SEK, NOK
xx reference required string  
   Payment referene.  
xx items required array  
   Array of order items.  

xxx reference required string  
    Product reference.  
xxx name required string
    Product name.
xxx quantity required string
    Product quantity.
xxx unit required string
    Product unit, for instance pcs or Kg
xxx unitPrice required string
    Product price per unit without VAT.
xxx grossTotalAmount required number
    Product total amount including VAT
xxx netTotalAmount required 
    Product total amount excluding VAT
xxx taxRate optional number
    Product tax rate. Defaults to 0 if not provided.
xxx taxAmount optional number
    Product tax/VAT amount. Defaults to 0 if not provided. Should include the total tax amount for the entire order row.
xxx grossTotalAmount required number
    Product total amount including VAT
xxx netTotalAmount required 
    Product total amount excluding VAT
       
x checkout required object
  Settings for the checkout page

xx integrationType optional string
   Any of HostedPaymentPage or EmbeddedCheckout. Default is EmbeddedCheckout.
xx url optional string
   Required if using EmbeddedCheckout. The URL to your checkout page which will embed the checkout view. Required so that load Checkout.js loads correctly. 
xx returnUrl optional string
   Required if using HostedPaymentPage. A URL pointing at the page on your site that the customer should return to when the customer has completed the payment. Only relevant if using HostedPaymentPage.
xx termsUrl required string
   URL to your terms and conditions

x notifications optional object
  Receive status notifications of a ongoing payment.
xx webhooks required array
   The webhooks you want to register for the payment. Maximum number of webhooks is 32.
xxx url required string
    Your endpoint URL to be called when an event is triggered. The endpoint should support HTTPS. Maximum lenght is 256 characters.
xxx authorization optional string
    An authorization header value that will be added to the callback request from Nets to your webhook endpoint. Must be a alphanumeric string with a length between 8 to 32  characters.
xxx eventName required string
    The event you want to receive notifications about. Possible values are:
    - payment.created - A payment was created.
    - payment.reservation.created.v2- A customer has successfully created a reservation.
    - payment.charge.created.v2 - A payment has been charged (partially or fully).
    - payment.charge.failed - A charge did fail.
    - payment.refund.initiated.v2 - A refund was initiated.
    - payment.refund.failed - A refund did fail.
    - payment.refund.completed - A refund has successfully been completed.
    - payment.cancel.created - A reservation has been canceled.
    - payment.cancel.failed - A cancellation did fail.
       
       
</pre>
       
     
