# Nets EASY API Reference


The Nets Easy APIs provide a secure way to add online payments to your website or application by sending JSON over HTTPS. 

One-time payments and recurring payments are carried out using the Payment API. 

Payouts from your customers are reported in the Easy Portal. In addition, you can use the [Reporting API](reporting-api.md) to programmatically fetch information about payouts.

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



## Parameters

You can pass parameters to the Nets Easy APIs using:

- Header parameters. For example, the Authorization header specifying the private API key is always sent as an HTTP header. 
- Path parameters. For example, the numerical payment identifier paymentId in the path /v1/payment/{paymentId}.
- Query parameters. For example, the fromDate parameter in the request /v1/payouts?fromDate=2020-09-10
- JSON objects. Some requests, typically POST and PUT, expect you to pass JSON objects to the Nets Easy APIs. 


Regardless of how parameters are sent, they all support the same set of data types:

- `string`: a sequence of characters. The set of valid characters are defined by... 
- `integer`: a signed integer ranging in value from -2,147,483,648 to 2,147,483,647
- `long`: a singed integer ranging in value from −9,223,372,036,854,775,807 to 9,223,372,036,854,775,807. Typically used for identifiers.
- `decimal`: a double-precision floating-point number as defined in IEEE-754.

## Authentication

Some API requests required to include a valid Authorization header. This header should contain your API key for the environment (Test or Live) you are currently using. You can find your secret API keys in the Easy Portal under Company -> Integration. 

The secret API key is always passed between your server and a Nets Easy endpoint. The secret API key should never be used from the client side of your site / app for security reasons.


## Inde