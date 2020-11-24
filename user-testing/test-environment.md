# Test environment

You can verify that your Easy Checkout integration is working using the test environment provided by Nets. The test environment allows you to perform test purchases using card and invoice payments. 

The test environment comprises:

- Integration keys for testing
- Test API available at the base address [https://test.api.dibspayment.eu](https://test.api.dibspayment.eu)
- Checkout.js available at [https://test.checkout.dibspayment.eu/v1/checkout.js?v=1](https://test.checkout.dibspayment.eu/v1/checkout.js?v=1)
- Sample credit cards (see below)
- Sample addresses (see below)
- Personal identification numbers (see below)

---

**NOTE**

You need to make sure you are sending the request towards the test API base address and that you also are using your integration keys for testing.

---




## Sample cards

Cards to be used in the test environment checkout. 


| Syntax      | Description |
| ----------- | ----------- |
| Header      | Title       |
| Paragraph   | Text        |


---

**NOTE**

If the Create Payment request contain "charge":true then charge with test card 4925000000000079 will not fail.

---

