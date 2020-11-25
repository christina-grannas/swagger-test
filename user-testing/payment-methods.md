# Easy Checkout Payment Methods

Easy Checkout by Nets includes the following payment methods:

- **Card**, both [Visa](https:://visa.com/) and [Mastercard](https://www.mastercard.com/) are supported
- **Invoice** offers your customer to pay within 30 days  
- **Installments** splits a purchase into multiple payments
- **Digital wallets** such as [Swish](https://www.swish.nu) (Sweden), [Vipps](https://www.vipps.no) (Norway), and [MobilePay](https://www.mobilepay.dk/) (Denmark)

This page describes how to set up and use each of these payment methods correctly on your site.


## Card
The Easy checkout supports Visa and Mastercard payments. A card payment is handled in two stages, reservations and charges.

We recommend that you charge a card payment when shipping the goods.
Please be aware that the payment reservation is valid up to 30 days, you must charge the payment within this time frame.
We recommend that you use webhooks for card payments, visit this page and go to the Webhooks section for more information.
Card payments on Easy requires 3D Secure, which affects the payment flow. For more information on how 3D Secure is handled, see section 2. Initialize the checkout on this page.
 

## Invoice
An invoice payment is completed in two steps: **reservation** and **charge**.

The reservation period for an invoice payment is 30 days, in order to receive funds for the payment you must make the charge within this period. You can attempt charging the payment after 30 days, however there is no guarantee that the charge will be accepted at this point.
 
## Installments

TBD

## Digital wallets 

Vipps is based on card transactions, please read the information about Card payments above.

Since the MobilePay, Swish and Vipps payments are handled in an app, consumer shopping on a mobile device may not return to your webshop and Easy Checkout after confirming the payment in the app. To ensure the correct update of the payment status from Easy Checkout, we recommend that you use webhooks.

Use the webhook called `payment.checkout.completed`, which is documented under the [Webhook section](http://example.com/). By using this webhook, you will receive a notification from Easy Checkout once the checkout process has been completed.
 