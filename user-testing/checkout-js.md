
<!--
Sara: Underrubriker i Checkout.js-menyn:

Constructor

Methods
  setLanguage()
  setTheme()
  send()
  freezeCheckout()
  thawCheckout()
  cleanup()

Events
  pay-initialized
  payment-completed
  address-changed

Supported languages

Theme


--->



# Checkout JavaScript API (frontend)

The `Checkout` object is the main object that dynamically builds the checkout page when embedding Easy Checkout on your site. The `Checkout` object also handles the communication between the frontend of your site and Nets.

<!-- that you use for communicating with Nets on the frontend of your site. -->

## Constructor
Constructs a new `Checkout` object. 

During construction, the `Checkout` object communicates with the Nets Easy Checkout servers and immediately starts generating the checkout page in an embedded `iframe`.

<!--
The `Checkout()` constructor communicates with the Nets Easy Checkout servers and dynamically builds the embedded checkout page. You are required to pass parameters for **identifying your site** and the **ongoing payment session**. Optionally, you can provide **UI theme settings** and **language** to be displayed on the checkout page.
is described in the following section.

When constructing a `Checkout` object, you are required to pass a `checkoutOptions` object with the following properties: 
-->

#### Syntax
```javascript
var checkout = new Dibs.Checkout(checkoutOptions);
```

#### Parameters
`checkoutOptions` - *required*

You are required to pass parameters for identifying **your site** and the **ongoing payment session**. Optionally, you can provide parameters that affect the **UI** of the checkout page.

The `checkoutOptions` object contains the following properties:

| Property   | Required/Optional | Description
| :-----------| :-----------------: |:-----------
| `checkoutKey`  | Required | Identifies your site (webshop), see [Integration keys](access-your-integation-keys.md)
| `paymentId`	| Required | The `paymentId` token that identifies the ongoing payment session. The `paymentId` should be created by the backend of your site when initiating the checkout. See also [Payment API](https://www.example.com/payment).
| `partnerMerchantNumber` | Optional  | Partner identifer
|  `containerId` |  Optional | ID of the DOM element on your site where the `iframe` will be loaded
| `language` | Optional | Language used on the checkout page. Defaults to `en-GB` if not specified. See [supported values](#supported-languages) below.
| `theme` | Optional | A dictionary. See UI [theme](#theme) below.

#### Example

The following example embeds a checkout `iframe` in the DOM element on your site with id `'checkout-container-div'`. The display language is set to English and buttons will have slightly rounded corners:

```javascript
var checkoutOptions = {
    checkoutKey: "test-checkout-key-003345054979023400345",
    paymentId : "8b464458f2524bc39fe5d31deb8bedc1",
    containerId : "checkout-container-div",
    language: "en-GB",
    theme: {
        buttonRadius: "5px"
    }
};
var checkout = new Dibs.Checkout(checkoutOptions);
```


## Methods

The `Checkout` object contains the following methods.


### setLanguage()

Changes the display language on an active checkout session.

#### Syntax

```javascript
checkout.setLanguage(language);
```

#### Parameters

`language` - *required*
 A string specifying the language.  See [supported language](#supported-languages).



### setTheme()

Changes the UI theme on an active checkout session. See UI [theme](#theme) section below.

#### Syntax

```javascript
checkout.setTheme(theme);
```

#### Parameters
`theme` - *required*

A UI [theme](#theme) dictionary specifying the style settings to be used.

### send()

 Send an event with a name that will be triggered within the checkout.

#### Syntax

```javascript
checkout.send(eventName, value);
```

#### Parameters

`eventName` - *required*

A string identifying the event to be sent. 

`value` - *optional*

An optional value for the specified event.


| Event name                  | Value                   | Description
|-----------------------------|-------------------------|--------------
| `'payment-order-finalized'` | Boolean, always `true`  | Continues the pay flow

Can be used to send an event that will be triggered within the checkout.
For now the only event supported is `'payment-order-finalized'`, where the value should be a boolean set to `true`.

#### Example

An example of usage for the event `'payment-order-finalized'` is when you listen to the event `'pay-initialized'`. By listening to this event, the checkout flow will not proceed the payment when your customer clicks *pay* unless you send the event `'payment-order-finalized'`.

```javascript
checkout.on('pay-initialized', function(response) {
  // Complete the desired operations such as update payment
  // ...
  checkout.send('payment-order-finalized', true);
});
```

When this code snippet is run, the `Checkout` object will continue the pay flow.

### freezeCheckout()

Temporarily freezes (pauses) the checkout by disabling the payment button. Call this method before updating the order items of an active checkout session. Once the order items have been updated, you should resume the checkout session by calling `thawCheckout()`.

#### Syntax

```javascript
checkout.freezeCheckout();
```

### thawCheckout()

Resumes a frozen checkout and triggers a reloading of the payment information. 

If this method is invoked after the order items has been updated, the amount will also be updated to the correct amount.

#### Syntax

```javascript
checkout.thawCheckout();
```


### cleanup()

Removes all event listeners. 

#### Syntax

```javascript
checkout.cleanup();
```


## Events

This section describes the checkout events that you can listen for and handle programmatically.

### pay-initialized

Triggers when your customer clicks the pay button and is sent to the [3-D Secure](https://en.wikipedia.org/wiki/3-D_Secure) page for securing the authenticity of the parties involved in the payment.


#### Syntax
```javascript
checkout.on('pay-initialized', event_handler);
```


#### Parameters

`event_handler` - *required*

An event handler accepting a `response` parameter. 
The response parameter contains the `paymentId`.

#### Example

```javascript
checkout.on('pay-initialized', function(response) {
  // Complete the desired operations such as update payment
  // ...

  checkout.send('payment-order-finalized', true);
});
```

### payment-completed

Triggers after a successful payment. 
This is the event that you should listen to in order to redirect your customer to a "Payment Success" page.

#### Syntax
```javascript
checkout.on('payment-completed', event_handler);
```

#### Parameters

`event_handler` - *required*

An event handler accepting a `response` parameter with the following properties:

| Property      | Description
|---------------|---------------
| `paymentId`  | string 
| `countryCode` | string
The response parameter contains the `paymentId`.

#### Example

```javascript

this is the event that the merchant should listen to redirect to the “payment-is-ok” page
checkout.on('payment-completed', function(response) {
  var paymentId = response['paymentId'];
  // Register a successful payment in your DB using the paymentId
  // ...
    
  // Redirect your customer to a "Payment success" page
  window.location = '/PaymentSuccessful';
});
```


### address-changed

Triggers whenever your customer updates address information.
This is the event that you should listen to in order to update shipping cost based on your customer's location.

#### Syntax
```javascript
checkout.on('address-changed', event_handler);
```

#### Parameters

`event_handler` - *required*

An event handler accepting an `address` parameter. The `address` object contains the following properties:

| Property      | Description
|---------------|---------------
| `postalCode`  | String 
| `countryCode` | String


#### Example

This example demonstrates how to update shipping cost whenever the customer updates the address. 

```javascript
checkout.on('address-changed', function(address) { 
  if (address) {                // Address has changed
    checkout.freezeCheckout();  // Freeze checkout while updating shipping cost

    var zip = address.postalCode;
    var country = address.countryCode;

    calculateShippingCost(zip, country).then(function(response) {
      // Call "update cart" method on the Payment API 
      // with the updated shipping cost.
      // ...

      checkout.thawCheckout();  // Resume checkout
    });
  }
});
```

For more information about adding and updating shipping costs to your site, see [Add shipping cost](add-shipping-cost.md).

## Supported languages

The following languages can be used on the checkout page:

| Code    | Language  
|:-------:|:------- 
| `en-GB` | English (default)
| `da-DK` | Danish 
| `sv-SE` | Swedish 
| `nb-NO` | Norwegian 
| `de-DE` | German    
| `pl-PL` | Polish    
| `fr-FR` | French    
| `es-ES` | Spanish   
| `nl-NL` | Dutch     
| `fi-FI` | Finnish   
	

## Theme

You can change the style of the checkout UI by specifying, fonts, colors, button styles and more using the `theme` dictionary. It can be passed to the `Checkout` [constructor](#constructor) or by using the [`setTheme()`](#settheme) method. A `theme` object can contain the following properties:


| Property              | Description
|-----------------------|-----------
| `textColor`           | Affects all text except links. Panel text can be overridden separately.
| `linkColor`           | Color to be used for links. Links with text can be overridden separately.
| `fontFamily`          | Any [Google font](https://fonts.google.com). String, default `"Roboto"`
| `backgroundColor`     | Background color. Any CSS color.
| `placeholderColor`    | Placeholder color. Any CSS color.
| `outlineColor`        | Color of the outline and separation lines for panels
| `primaryOutlineColor` | Border color for radio buttons and checkboxes
| `panelColor`          | Panel color. Any CSS color
| `panelTextColor`      | Text color within the panel
| `panelLinkColor`      | Link color within the panel
| `primaryColor`        | Affects the pay button, default button outlines, and radio buttons
| `buttonRadius`        | Radius of the buttons. Number, default 0.
| `buttonTextColor`     | Text color for all buttons. Any CSS color.
| `buttonFontWeight`    | [Font weight](https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight) for buttons. Number (for example `500`) or string (for example `"bold"`)
| `buttonFontStyle`     | [Font style](https://developer.mozilla.org/en-US/docs/Web/CSS/font-style) such as `"italic"` and `"oblique"`. <br>String, default `"normal"`
| `buttonTextTransform` | [Text transform](https://developer.mozilla.org/en-US/docs/Web/CSS/text-transform). String, default `"none"`.
| `footerBackgroundColor` | Background color of the footer
| `footerOutlineColor`    | Footer outline color
| `footerTextColor`       | Text color for footer
| `useLightIcons`         | Use light icons for dark background. Boolean, default `false`.
| `useLightFooterIcons`   | Use light icons in footer for dark background. Boolean, default `false`