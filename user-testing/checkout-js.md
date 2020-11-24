# Checkout.js


## Constructor

### Constructor parameters

| Parameter   | Required/Optional | Description
| :-----------| :-----------------: |:-----------
| `checkoutKey`  | Required | Identifier for your webshop, see [Integration keys](access-your-integation-keys.md)
| `paymentId`	| Required | Reference to the `paymentId` token
| `partnerMerchantNumber` | Optional  | Partner identifer
|  `containerId` |  Optional | ID of the DOM-element where the `iframe` will be loaded
| `language` | Optional | Set the language used on the checkout page. Defaults to `en-GB` if not specified. See [possible values](#checkout-languages) below.
| `` | Optional |
| `` | Optional |
| `` | Optional |


#### Checkout languages

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
	

#### **UI theme settings**

You can change the style of the checkout UI by specifying, fonts, colors, button styles etc by setting properties on the `theme` parameter object passed to the Checkout constructor.

 
All property values are strings, and must be valid css.
The following properties can be specified:


| Property              | Description
|-----------------------|-----------
| `textColor`           | Affects all text except links. <br>Panel text can be overridden separately.
| `linkColor`           | Color to be used for links. <br>Links with text can be overridden separately.
| `fontFamily`          | Any [Google font](https://fonts.google.com). String, default `"Roboto"`
| `backgroundColor`     | Background color. Any CSS color.
| `placeholderColor`    | Placeholder color. Any CSS color.
| `outlineColor`        | Color of the outline and separation lines for panels
| `primaryOutlineColor` | Border color for radio buttons and checkboxes
| `panelColor`          | Panel color. Any CSS color
| `panelTextColor`      | Text color within the panel
| `panelLinkColor`      | Link color within the panel
| `primaryColor`        | Affects the pay button, <br> default button outlines, <br> and radio buttons
| `buttonRadius`        | Radius of the buttons. Number, default 0.
| `buttonTextColor`     | Text color for all buttons. Any CSS color.
| `buttonFontWeight`    | [Font weight](https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight) Number (for example `500`) or <brr> string (for example `"bold"`)
| `buttonFontStyle`     | [Font style](https://developer.mozilla.org/en-US/docs/Web/CSS/font-style) such as `"italic"` and `"oblique"`. <br>String, default `"normal"`
| `buttonTextTransform` | [Text transform](https://developer.mozilla.org/en-US/docs/Web/CSS/text-transform). String, default `"none"`.
| `footerBackgroundColor` | Footer background color
| `footerOutlineColor`    | Footer outline color
| `footerTextColor`       | Text color for footer
| `useLightIcons`         | Use light icons. Boolean, default `false`.
| `useLightFooterIcons`   | Use light icons in footer. Boolean, default `false`



## The `send()` method


    public send(eventName: string, value?: any)
Can be used to send an eventName that will be triggered within the checkout.
For now the only eventName supported is 'payment-order-finalized', where the value should be a boolean set to true.
An example of usage for this is when you listen to the event 'pay-initialized'.
By listening to this event, the checkout flow will not proceed the payment when clicking pay unless you send this event.
It can be sent with the follow js code: this.send('payment-order-finalized', true);
When this code snippet is run the checkout will continue the pay flow.

public freezeCheckout()
Should be used when you want to update the order items of an active checkout. Activating this will freeze the checkout, and you will not be able to click "Pay". After this is trigged you do the API call to update order items. Should be followed by also running thawCheckout().

public thawCheckout()
Should be used after freezeCheckout(). This method will unfreeze the checkout, and it will also trigger to get the latest data on the payment. Normally used to update the order items, so if this is run after order items is updated, the pay amount will also be updated to the correct amount.

public setTheme(theme: any)
Can be used to change the theme while having the checkout running.
Allowed theme should be the same as defined for theme sent in with the CheckoutOptions.

public setLanguage(language: string)
Can be used to change the display language while having the checkout running.
Allowed languages should be the same as the language sent in with the CheckoutOptions.

public cleanup()
Can be used to help clean up all eventlisteners. It will remove all eventlisteners.
1:06

public send metoden er litt tåpelig.. burde kanskje bare laget en ny metode som heter continuePayFlow() eller noe sånt :stuck_out_tongue: haha.. støtter jo bare et eventName
Men men.. vi kan ikke fjerne den siden folk har tatt den i bruk