# Nets EASY API Reference


The Nets Easy APIs provide a secure way to add online payments to your website or application by sending JSON over HTTPS. 

One-time payments and subscriptions are carried out using the [Payment API](#payment-api.md). 

Payouts from your customers are reported in the [Easy Portal](https://portal.dibspayment.eu/payouts). In addition, you can use the [Reporting API](reporting-api.md) to programmatically fetch information about payouts.

The [Checkout JS SDK](checkout-js.md) allows you to embed a custom checkout page on your website. 

This is the complete API reference for the Nets Easy APIs.


## Environments and Base Addresses

All communication between your site and Nets Easy is handled over HTTPS. The Easy API are collected under the following base addresses:

| Environment | Base address
|-------------|---------------
| Test        | https://test.api.dibspayment.eu 
| Live        | https://api.dibspayment.eu

## Requests and Responses

The Nets Easy APIs follow the RESTful architectural style. A set of resources can be accessed using some of the endpoints provided by the APIs. To retrieve, add, or update resources, you use the associated HTTP methods for these actions:

| Method | Description
|--------|-------------
| GET    | Retrieves a resource (idempotent, will never mutate a resource)
| POST   | Creates a new resource. A JSON object, provided by you, describes the resource.
| PUT    | Updates an existing resource. A JSON object, provided by you, describes the changes. 

## Parameters

You can pass parameters to the Nets Easy APIs using:

- **Header parameters**. For example, the `Authorization` header specifying the private API key is always sent as an HTTP header.
- **Path parameters**. For example, the numerical payment identifier `paymentId` in the path `/v1/payment/{paymentId}`.
- **Query parameters**. For example, the `fromDate` parameter in the request `/v1/payouts?fromDate=2020-09-10`.
- **JSON objects**. Some requests, typically POST and PUT, expect you to pass JSON objects to the Nets Easy APIs. 


## Authentication

Most API requests are required to include a valid `Authorization` header. This header should contain your [secret API key](#https://portal.dibspayment.eu/integration) for the environment (Test or Live) you are currently using. For more information, please see the articles [Access your integration keys](access-your-integration-keys.md) and [Use the test environment](test-environment.md).

The secret API key is should only be passed between your server and a Nets Easy endpoint. The secret API key should **never** be used from the client side of your site / app for security reasons.


## Retries and idempotent keys

Most HTTP methods are **idempotent**, meaning that sending the same HTTP request multiple times to the server will not change the state of the server. In case of a network failure, it should always be safe to resend an idempotent request. For example, sending multiple identical GET requests to a server should not. In other words, it should be safe to retry a GET request if you didn't get any response from the server due to some network failure.

However, POST requests usually create new resources on the server side and cannot be 



POST 
Calling a API GET POST

### The problem

Imagine that you send an HTTP request for creating a new payment. 
- The client sends a POST request to the server 
- The request reaches the server and creates a new payment object on the server.
- The server also reserves the amount of the payment of the customer's payment card.
- The client's network become unreachable
- The response from the server never reaches the client

In this state, the client doesn't know whether a new payment has been created or not. Neither did the client receive a paymentId back from the server, so there is no way for the client to check whether the payment object has been created or not.

The client could potentially send a new HTTP request, asking the server to create a new payment object. But that would reserve an additional amount on the customer's payment card which is not acceptable.

### The solution

The solution to this problem is to have the client generate a **unique idempotency key**. The client adds this key to the initial HTTP request. If The server will respond with the same HTTP status code and response object (if any) as it did the first time. The server can use the idempotency key to detect whether the client is sending a retry to avoid performing the same operation multiple times on the server.



Using a idempotency key makes it safe for clients to retry requests that failed due to network failures.

## Data types and formats



Regardless of how parameters are sent, they all support the same set of data types:

- `string`: a sequence of characters. The set of valid characters are defined by... 
- `integer`: a signed integer ranging in value from -2,147,483,648 to 2,147,483,647
- `long`: a singed integer ranging in value from −9,223,372,036,854,775,807 to 9,223,372,036,854,775,807. Typically used for identifiers.
- `decimal`: a double-precision floating-point number as defined in IEEE-754.

### Date time



### Currency

Currency should always be specified using a 3-letter code ([ISO-4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes)). The following table lists all currencies supported by Easy:

| Code | Currency
|------|-------------------
| DKK  | Danish krone
| EUR  | Euro
| NOK  | Norwegian krone
| SEK  | Swedish krona/kronor


### Country codes and phone prefixes

Country codes and phone prefixes are both used in the checkout. **Country codes** are used when limiting the set of [countries available for shipping](#payment-api.md). **Phone prefixes** appears in the [customer data object](#payment-api.md).

The following table lists all countries supported by Easy:

| Country | ISO Code | Phone Prefix
|---------|----------|-------------
| Albania | ALB | 355
| Andorra | AND | 376
| Armenia | ARM | 374
| Austria | AUT | 43
| Azerbaijan | AZE | 994
| Belgium | BEL | 32
| Bulgaria | BGR | 359
| Bosnia | BIH | 387
| Belarus | BLR | 375
| Switzerland | CHE | 41
| Cyprus | CYP | 357
| Czechia | CZE | 420
| Germany | DEU | 49
| Denmark | DNK | 45
| Spain | ESP | 34
| Estonia | EST | 372
| Finland | FIN | 358
| France | FRA | 33
| UK | GBR | 44
| Georgia | GEO | 995
| Greece | GRC | 30
| Croatia | HRV | 385
| Hungary | HUN | 36
| Ireland | IRL | 353
| Iceland | ISL | 354
| Italy | ITA | 39
| Kazakhstan | KAZ | 7
| Liechtenstein | LIE | 423
| Lithuania | LTU | 370
| Luxembourg | LUX | 352
| Latvia | LVA | 371
| Monaco | MCO | 377
| Moldova | MDA | 373
| Macedonia | MKD | 389
| Malta | MLT | 356
| Montenegro | MNE | 382
| Netherlands | NLD | 31
| Norway | NOR | 47
| Poland | POL | 48
| Portugal | PRT | 351
| Romania | ROU | 40
| Russia | RUS | 7
| San Marino | SMR | 378
| Serbia | SRB | 381
| Slovakia | SVK | 421
| Slovenia | SVN | 386
| Sweden | SWE | 46
| Turkey | TUR | 90
| Ukraine | UKR | 380
| Vatican City | VAT | 39
| US | USA | 1
| Greenland | GRL | 299
| Afghanistan | AFG | 93
| Angola | AGO | 244
| United Arab Emirates | ARE | 971
| Argentina | ARG | 54
| Antigua & Barbuda | ATG | 1
| Australia | AUS | 61
| Burundi | BDI | 257
| Benin | BEN | 229
| Burkina Faso | BFA | 226
| Bangladesh | BGD | 880
| Bahrain | BHR | 973
| Bahamas | BHS | 1
| Belize | BLZ | 501
| Bolivia | BOL | 591
| Brazil | BRA | 55
| Barbados | BRB | 1
| Brunei | BRN | 673
| Bhutan | BTN | 975
| Botswana | BWA | 267
| Central African Republic | CAF | 236
| Canada | CAN | 1
| Chile | CHL | 56
| China | CHN | 86
| Côte d’Ivoire | CIV | 225
| Cameroon | CMR | 237
| Congo - Kinshasa | COD | 243
| Congo - Brazzaville | COG | 242
| Colombia | COL | 57
| Comoros | COM | 269
| Cape Verde | CPV | 238
| Costa Rica | CRI | 506
| Cuba | CUB | 53
| Djibouti | DJI | 253
| Dominica | DMA | 1
| Dominican Republic | DOM | 1
| Algeria | DZA | 213
| Ecuador | ECU | 593
| Egypt | EGY | 20
| Eritrea | ERI | 291
| Ethiopia | ETH | 251
| Fiji | FJI | 679
| Micronesia | FSM | 691
| Gabon | GAB | 241
| Ghana | GHA | 233
| Guinea | GIN | 224
| Gambia | GMB | 220
| Guinea-Bissau | GNB | 245
| Equatorial Guinea | GNQ | 240
| Grenada | GRD | 1
| Guatemala | GTM | 502
| Guyana | GUY | 592
| Honduras | HND | 504
| Haiti | HTI | 509
| Indonesia | IDN | 62
| India | IND | 91
| Iran | IRN | 98
| Iraq | IRQ | 964
| Israel | ISR | 972
| Jamaica | JAM | 1
| Jordan | JOR | 962
| Japan | JPN | 81
| Kenya | KEN | 254
| Kyrgyzstan | KGZ | 996
| Cambodia | KHM | 855
| Kiribati | KIR | 686
| St. Kitts & Nevis | KNA | 1
| South Korea | KOR | 82
| Kuwait | KWT | 965
| Laos | LAO | 856
| Lebanon | LBN | 961
| Liberia | LBR | 231
| Libya | LBY | 218
| St. Lucia | LCA | 1
| Sri Lanka | LKA | 94
| Lesotho | LSO | 266
| Morocco | MAR | 212
| Madagascar | MDG | 261
| Maldives | MDV | 960
| Mexico | MEX | 52
| Marshall Islands | MHL | 692
| Mali | MLI | 223
| Myanmar | MMR | 95
| Mongolia | MNG | 976
| Mozambique | MOZ | 258
| Mauritania | MRT | 222
| Mauritius | MUS | 230
| Malawi | MWI | 265
| Malaysia | MYS | 60
| Namibia | NAM | 264
| Niger | NER | 227
| Nigeria | NGA | 234
| Nicaragua | NIC | 505
| Nepal | NPL | 977
| Nauru | NRU | 674
| New Zealand | NZL | 64
| Oman | OMN | 968
| Pakistan | PAK | 92
| Panama | PAN | 507
| Peru | PER | 51
| Philippines | PHL | 63
| Palau | PLW | 680
| Papua New Guinea | PNG | 675
| North Korea | PRK | 850
| Paraguay | PRY | 595
| Qatar | QAT | 974
| Rwanda | RWA | 250
| Saudi Arabia | SAU | 966
| Sudan | SDN | 249
| Senegal | SEN | 221
| Singapore | SGP | 65
| Solomon Islands | SLB | 677
| Sierra Leone | SLE | 232
| El Salvador | SLV | 503
| Somalia | SOM | 252
| South Sudan | SSD | 211
| São Tomé & Príncipe | STP | 239
| Suriname | SUR | 597
| Swaziland | SWZ | 268
| Seychelles | SYC | 248
| Syria | SYR | 963
| Chad | TCD | 235
| Togo | TGO | 228
| Thailand | THA | 66
| Tajikistan | TJK | 992
| Turkmenistan | TKM | 993
| Timor-Leste | TLS | 670
| Tonga | TON | 676
| Trinidad & Tobago | TTO | 1
| Tunisia | TUN | 216
| Tuvalu | TUV | 688
| Taiwan | TWN | 886
| Tanzania | TZA | 255
| Uganda | UGA | 256
| Uruguay | URY | 598
| Uzbekistan | UZB | 998
| St. Vincent & Grenadines | VCT | 1
| Venezuela | VEN | 58
| Vietnam | VNM | 84
| Vanuatu | VUT | 678
| Samoa | WSM | 685
| Yemen | YEM | 967
| South Africa | ZAF | 27
| Zambia | ZMB | 260
| Zimbabwe | ZWE | 263
| Hong Kong | HKG | 852




