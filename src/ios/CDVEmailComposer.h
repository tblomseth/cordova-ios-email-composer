/*
 * Based on:
 */
//
//  EmailComposer.h
//
//
//  Created by Jesse MacFadyen on 10-04-05.
//  Copyright 2010 Nitobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Cordova/CDVPlugin.h>

@interface EmailComposer : CDVPlugin < MFMailComposeViewControllerDelegate > {
  
}

@property (nonatomic, copy) NSString* callbackId;

- (void) showEmailComposer::(CDVInvokedUrlCommand *)command;

@end