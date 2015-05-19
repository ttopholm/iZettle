# iZettle
Plugin for Cordova


Until I get the time, this is the quick install

1. Add platform ios
2. Build ios
3. Follow the instructions on https://github.com/iZettle/sdk-ios
4. add plugin
5. Ready

#Functions

##Charge
Perform a payment with an amount and a reference.
	
	chargeAmount( apiKey, amount, currency, reference );

- **apiKey**: The API key from iZettle
- **amount**: The amount to be charged in the logged in users currency.
- **currency**: Only used for validation. If the value of this parameter doesn't match the users currency the user will be notified and then logged out. For a complete list of valid currency codes, see [ISO 4217](http://www.xe.com/iso4217.php)
- **reference**: The payment reference. Used to identify an iZettle payment, used when retrieving payment information at a later time or performing a refund. Max length 128.
