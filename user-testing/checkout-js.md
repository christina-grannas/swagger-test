# Checkout JavaScript API (frontend)

The `Checkout` object is the main object that dynamically builds the checkout form when embedding a checkout form on your site. The Checkout object is also the controller object that you use for communicating with Nets on the frontend of your site.

## Constructor

**Syntax**

```
var checkout = Checkout(checkoutOptions);
```
The `Checkout()` constructor communicates with the Nets Easy Checkout servers and dynamically builds the embedded checkout page. You are required to pass parameters for **identifying your site** and the **ongoing payment session**. Optionally, you can provide **UI theme settings** and **language** to be displayed on the checkout page.

The `checkoutOptions` is described in the following section.

### Constructor parameters

When constructing a `Checkout` object, you are required to pass a `checkoutOptions` object with the following properties: 

| Property   | Required/Optional | Description
| :-----------| :-----------------: |:-----------
| `checkoutKey`  | Required | Identifies your web site, see [Integration keys](access-your-integation-keys.md)
| `paymentId`	| Required | The `paymentId` token that identifies the ongoing payment session. The `paymentId` should be created by the backend of your site when initiating the checkout. See also [Payment API](https://www.example.com/payment).
| `partnerMerchantNumber` | Optional  | Partner identifer
|  `containerId` |  Optional | ID of the DOM-element where the `iframe` will be loaded
| `language` | Optional | Set the language used on the checkout page. Defaults to `en-GB` if not specified. See [supported values](#supported-languages) below.


## Methods

The `Checkout` object contains the following methods.


### setTheme()

Changes the UI theme on an active checkout session. See [UI theme][#ui-theme] section below.

#### Syntax
```
checkout.setTheme(theme);
```

#### Parameters
```theme``` - *required*

A [theme](#ui-theme) dictionary specifying the style settings to be used.

### setLanguage()

Set the display language used on the checkout page for an ongoing payment session.

#### Syntax
```
checkoutt.setLanguage(language);
```

#### Parameters

`language` - *required*
An string 

### send()

 Send an event with a name that will be triggered within the checkout.

#### Syntax
```
checkout.send(eventName, value)
```

#### Parameters

`eventName` - *required*
A string identifying the event to be sent. 

`value` - *optional*
An optional value for the specified event.


| Event name                | Value                   | Description
|---------------------------|-------------------------|--------------
| `payment-order-finalized` | Boolean, always `true`  | Continues the pay flow

Can be used to send an eventName that will be triggered within the checkout.
For now the only eventName supported is 'payment-order-finalized', where the value should be a boolean set to true.

#### Example

An example of usage for the event `'payment-order-finalized'`  is when you listen to the event `'pay-initialized'`.

By listening to this event, the checkout flow will not proceed the payment when clicking pay unless you send this event.
It can be sent with the follow js code: this.send('payment-order-finalized', true);
When this code snippet is run the checkout will continue the pay flow.

### freezeCheckout()

Temporarily freezes (pauses) the checkout by disabling the payment button. Call this method before updating the order items of an active checkout session. Once the order items have been updated, you should resume the checkout session by calling `thawCheckout()`.

#### Syntax
```
checkout.freezeCheckout();
```


### thawCheckout()

Resumes a frozen checkout and triggers a reloading of the payment information. 

If this method is invoked after the order items has been updated, the amount will also be updated to the correct amount.

#### Syntax
```
checkout.thawCheckout();
```

### setLanguage()

Changes the display language on an active checkout session.

#### Syntax
```
setLanguage(language)
```

#### Parameters
```language``` - *required*
 
 A string specifying the language.  See [supported language](#supported-languages).

### cleanup()

Removes all event listeners. 

#### Syntax
```
cleanup()
```



## Supported languages

The following languages can be specified on the checkout page:

| Code    | Language  
|:-------:|:------- 
| `en-GB` | English (default)
| `da-DK` | Danish 
| `sv-SE` | Swedish |
| `nb-NO` | Norwegian 
| `de-DE` | German    
| `pl-PL` | Polish    
| `fr-FR` | French    
| `es-ES` | Spanish   
| `nl-NL` | Dutch     
| `fi-FI` | Finnish   
	

## UI theme

You can change the style of the checkout UI by specifying, fonts, colors, button styles and more using a `theme` dictionary. It can be passed to the `Checkout` [constructor](#constructor) or by using the [`setTheme()`](#the-settheme-method) method. A `theme` object can contain the following properties:


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
| `buttonFontWeight`    | [Font weight](https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight) Number (for example `500`) or <brr> string (for example `"bold"`)
| `buttonFontStyle`     | [Font style](https://developer.mozilla.org/en-US/docs/Web/CSS/font-style) such as `"italic"` and `"oblique"`. <br>String, default `"normal"`
| `buttonTextTransform` | [Text transform](https://developer.mozilla.org/en-US/docs/Web/CSS/text-transform). String, default `"none"`.
| `footerBackgroundColor` | Footer background color
| `footerOutlineColor`    | Footer outline color
| `footerTextColor`       | Text color for footer
| `useLightIcons`         | Use light icons for dark background. Boolean, default `false`.
| `useLightFooterIcons`   | Use light icons in footer for dark background. Boolean, default `false`