//
//  iZettle.h
//  POS
//
//  Created by Tue Topholm on 19/05/15.
//
//

#import <Cordova/CDV.h>

@interface iZettle : CDVPlugin

- (void) chargeAmount:(CDVInvokedUrlCommand*)command;
- (void) settings:(CDVInvokedUrlCommand*)command;
- (void) retrievePaymentInfoForReference:(CDVInvokedUrlCommand*)command;
- (void) refundPaymentWithReference:(CDVInvokedUrlCommand*)command;
- (void) abortOperation:(CDVInvokedUrlCommand*)command;
- (NSDictionary*) convertPaymentInfo: (id)paymentInfo;


@end
