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


| Card type   | Number           | Expire date | CVC          | Result
| :---------: | :---------------:|:-----------:|:------------:|:------
| VISA        | 4925000000000004 | > today     | Any 3 digits | Success
| VISA        | 4925000000000087 | > today     | Any 3 digits | Reservation will fail
| VISA        | 4925000000000079 | > today     | Any 3 digits | Non-recurring charge will fail
| MasterCard  | 5413000000000000 | > today     | Any 3 digits | Success


---

**NOTE**

If the Create Payment request contain `"charge":true` then charge with test card 4925000000000079 will not fail.

---



## Sample invoice addresses

**Addresses** and **sample personal identification numbers** (**PNO**) to be used in the test environment when testing **invoice payments**.


### Invoice addresses in Sweden


| PNO         | Postal code | Address   | Result
|:-----------:|:--------:|:------------:|:------
| 420913-1111 | 79021    | Vasavägen    | Success
| 421101-1111 | 83162    | Centralvägen | Success
| 440424-1111 | 14552    | Bruksgatan   | Reservation not approved


### Invoice addresses Denmark


| PNO         | Postal code | Address    | Result
|:-----------:|:--------:|:-------------:|:------
| 1105900199  | 6330     | Hærvejen 2    | Success
| 0402490180  | 8930     | Åstrupvej 2   | Success
| 3108620065  | 9320     | Nobilisvej 11 | Success