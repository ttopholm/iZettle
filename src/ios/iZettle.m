//
//  iZettle.m
//  POS
//
//  Created by Tue Topholm on 19/05/15.
//
//

#import <Foundation/Foundation.h>
#import "iZettle.h"
#import <Cordova/CDV.h>
#import <iZettleSDK/iZettleSDK.h>

@implementation iZettle


- (void) chargeAmount:(CDVInvokedUrlCommand *)command {
    
    
    NSString* apiKey = [command.arguments objectAtIndex:0];
    NSDecimalNumber* amount = [NSDecimalNumber decimalNumberWithString:[command.arguments objectAtIndex:1]];
    NSString* currency = [command.arguments objectAtIndex:2];
    NSString* reference = [command.arguments objectAtIndex:3];
    if (amount > 0) {
        [[iZettleSDK shared] startWithAPIKey: apiKey];
        [[iZettleSDK shared] chargeAmount:amount currency:currency reference:reference presentFromViewController:self.viewController completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error) {
            if (paymentInfo != nil) {
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self convertPaymentInfo: paymentInfo]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            } else {
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.localizedDescription ];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
            
        }];
        
        
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void) settings:(CDVInvokedUrlCommand *)command {
    NSString* apiKey = [command.arguments objectAtIndex:0];
    [[iZettleSDK shared] startWithAPIKey: apiKey];
    [[iZettleSDK shared] presentSettingsFromViewController:self.viewController];
}

- (void) refundPaymentWithReference:(CDVInvokedUrlCommand *)command {
    NSString* apiKey = [command.arguments objectAtIndex:0];
    NSString* refundPaymentWithReference = [command.arguments objectAtIndex:1];
    NSString* refundReference = [command.arguments objectAtIndex:2];
    [[iZettleSDK shared] startWithAPIKey: apiKey];
    [[iZettleSDK shared] refundPaymentWithReference:refundPaymentWithReference refundReference: refundReference presentFromViewController:self.viewController completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error) {
        if (paymentInfo != nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self convertPaymentInfo: paymentInfo]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.localizedDescription ];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        
        
    }];
    
}

- (void) retrievePaymentInfoForReference:(CDVInvokedUrlCommand *)command {
    NSString* apiKey = [command.arguments objectAtIndex:0];
    NSString* retrievePaymentInfoForReference = [command.arguments objectAtIndex:1];
    [[iZettleSDK shared] startWithAPIKey: apiKey];
    [[iZettleSDK shared] retrievePaymentInfoForReference:retrievePaymentInfoForReference completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error) {
        if (paymentInfo != nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self convertPaymentInfo: paymentInfo]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.localizedDescription ];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) abortOperation:(CDVInvokedUrlCommand *)command {
    NSString* apiKey = [command.arguments objectAtIndex:0];
    [[iZettleSDK shared] startWithAPIKey: apiKey];
    [[iZettleSDK shared] abortOperation];
}

- (NSDictionary*) convertPaymentInfo:(iZettleSDKPaymentInfo *)paymentInfo {
    return @{
             @"referenceNumber": [NSString stringWithString:paymentInfo.referenceNumber],
             @"entryMode": [NSString stringWithString:paymentInfo.entryMode],
             @"obfuscatedPan": [NSString stringWithString:paymentInfo.obfuscatedPan],
             @"panHash": [NSString stringWithString:paymentInfo.panHash],
             @"cardBrand": [NSString stringWithString:paymentInfo.cardBrand],
             @"AID": [NSString stringWithString:paymentInfo.AID],
             @"TSI": [NSString stringWithString:paymentInfo.TSI],
             @"TVR": [NSString stringWithString:paymentInfo.TVR],
             @"applicationName": [NSString stringWithString:paymentInfo.applicationName]
             };
}

@end