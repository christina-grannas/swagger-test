# Manage payments

Whenever your customer buy something on your site, a new **payment** is created in Easy Checkout. Payments can be managed directly in [Easy Portal](https://portal.dibspayment.eu/payments) or programmatically through the [Easy APIs](api-overview.md). 

New payments require your action. When you ship the order, make sure to **charge** the payment in order to receive the funds from Nets. If the order is canceled by the customer, make sure to **cancel** the payment in order to release the reservation on the customer's payment card. 

## Charge payments
 
Charge a payment on the same day as you ship the matching order. 

Card payments need to be **charged within 30 days**, or else the payment will be canceled automatically. It will then require a new order from your customer if you wish to charge after the 30 days. 
 
A payment can be fully charged (default) or partially charged by choosing **Edit and charge**.

### Full charge

To fully charge a single payment, select the order in the payment overview and choose **Charge** in the **QUICK ACTIONS** drop-down menu. To charge several payments at once, select the payments you want to charge and choose **CHARGE**. 
 
The charge action will charge the full amount of the order. It's also possible to charge parts of an order by editing the order before charge.

 
### Edit order before charge

Orders may be partially charged. Below we have listed three common scenarios with examples. 
 
#### **Scenario 1: Charge a specific product**
 
To Charge one or several products you check the select boxes. The total sum of the refund will be calculated based on the selected order lines. Control the amount and choose Charge. 
 
**Example:** You have received an order of 1 red T-shirt and 1 yellow T-shirt, but it turns out you only have the red T-shirt in stock. You want to deliver the red T-shirt now and the yellow as soon as it arrives from your supplier. Check the order line for the red T-shirt and choose Charge. The yellow T-shirt will be possible to charge at a later stage (as long as it is within 30 days*). 
 
 
#### **Scenario 2: Change quantity before Charging**

 
You can edit the quantity on an order line by entering a new value in the quantity field. The total will be updated according to your changes. Control the amount and choose **Charge**. 
 
**Example:** You have received an order of 100 red T-shirts. You only have 80 in stock and the customer wants you to send what you have as soon as possible. To do this you write "80" in the quantity field. The system will update the total automatically and you can choose **CHARGE** to complete the order. 
 
 
#### Scenario 3: Change the amount before charging 
 
You can change the amount on an order line by entering a new value in the price field. The total will be updated according to your changes. Control the amount and choose **Charge**.
 
Example: Your customer has called to cancel the order. You, however, are a great seller and have managed to persuade the customer to go through with the purchase - with 20 SEK discount. Lower the amount to the agreed price in the input field. The system will calculate the total according to your changes.
 
When lowering the price, a new order line will be created containing the remaining part of the reserved amount. Also, note that it is not possible to charge an amount that exceeds the original order. The system will tell when you exceed the limit.
 

#### Reset if you lose track of changes
 
All of the changes above can also be made in combination. If you make changes and get lost, you always have the possibility to reset the changes to get back to the starting point when you opened the modal.
 
 
 

 

## View payment details

The payment details page allows you to inspect the details about the charges and refunds associated with the selected payment. It is also possible to perform actions directly from the payment details page.

To view the details for a payment, click the order row or choose **View details** in the **QUICK ACTIONS** drop-down menu from the [payment overview page](https://portal.dibspayment.eu/payments). 
 

There are three tabs on the payment details page:

- The **Order details** tab shows the **name of the customer** and the **payment status** of the order line(s). This will show who made the order and what specific status the order lines are in. 
 
- The **Transaction details** tab shows information that may be useful when in contact with our support team.
 
- The **History** tab shows all events related to a specific payment, including which user performed a particular action.
 
  
## Cancel payments

Release reserved amounts on card payments

If a customer cancels an order before the goods are shipped, you have the possibility to cancel the payment. By canceling a payment, the reserved money will be released to the customer's payment card and **Nets will not charge a fee for the payment.**

To cancel one payment, simply select the payment in the payment overview and choose **Cancel** in the **QUICK ACTIONS** drop-down menu. To cancel several payments at once, select all desired payments and choose **CANCEL**.
 
  
Please note that it is not possible to change the status of a canceled payment.
 
 

## Refunds
Refund total or parts of a payment.

### Full Refund
In order to refund the total amount you simply choose Refund in the Quick actions drop down menu. 

---
**Important!**

Please note! If the payment has been Partially Charged and you want to refund the full payment, you need to make one refund per charge. To find all charges that are related to the same original payment you choose View details on any line related to the order in the payments lists.

---
 

### Edit and Refund 

All Charged payments, including single or multiple order lines, may be partially Refunded. To partially Refund a payment, choose Edit and refund in the Quick actions drop down menu, select the desired order lines and/or edit the fields before choosing **REFUND**.  You can use several actions depending on your needs. We have listed three examples below.

 

### Not enough money to make a refund?

If there are not enough funds on your account when you have initiated a refund, the transaction will appear as “refunding” until the balance equals or exceeds the amount you wish to refund plus the transaction fee. A refund can be completed in two ways:

1. Charge new payments
2. Make a deposit

If you don’t have any payments to charge you can make a deposit to your account by a regular bank transfer.

The deposit does not need to match the exact amount of the refund and transaction fee. The exceeding amount will be booked as a deposit and included in your next payout.

The deposited funds will be visible on the payout page of your Easy account a couple of days after the bank transfer.

You can find more information on how to make a deposit, including account details and reference number, in the account section and on the payout page in case the balance is negative.

 
---
**Important!**
- It normally takes a few days before the funds are transferred to your customer's account depending on the card issuer's (normally your customer's bank) routines.
- Your balance needs to be larger than the amount you want to refund including transaction fees. Make a deposit or charge new payments if your balance is too low. 

---



