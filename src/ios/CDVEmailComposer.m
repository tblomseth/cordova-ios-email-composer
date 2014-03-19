/*
 * Based on:
 */
//
//  EmailComposer.m
//
//
//  Created by Jesse MacFadyen on 10-04-05.
//  Copyright 2010 Nitobi. All rights reserved.
//

#import "EmailComposer.h"

@implementation EmailComposer

@synthesize callbackId = _callbackId;

- (void) showEmailComposer::(CDVInvokedUrlCommand *)command
{
  self.callbackId = command.callbackId;
  
	NSDictionary *options = [command.arguments objectAtIndex:0];
	NSString* toRecipientsString = [options valueForKey:@"toRecipients"];
	NSString* ccRecipientsString = [options valueForKey:@"ccRecipients"];
	NSString* bccRecipientsString = [options valueForKey:@"bccRecipients"];
	NSString* subject = [options valueForKey:@"subject"];
	NSString* body = [options valueForKey:@"body"];
	NSString* isHTML = [options valueForKey:@"bIsHTML"];
	
  MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
  picker.mailComposeDelegate = self;
  
	// Set subject
	if(subject != nil)
		[picker setSubject:subject];
	// set body
	if(body != nil)
	{
		if(isHTML != nil && [isHTML boolValue])
		{
			[picker setMessageBody:body isHTML:YES];
		}
		else
		{
			[picker setMessageBody:body isHTML:NO];
		}
	}
	
	// Set recipients
	if(toRecipientsString != nil)
	{
		[picker setToRecipients:[ toRecipientsString componentsSeparatedByString:@","]];
	}
	if(ccRecipientsString != nil)
	{
		[picker setCcRecipients:[ ccRecipientsString componentsSeparatedByString:@","]];
	}
	if(bccRecipientsString != nil)
	{
		[picker setBccRecipients:[ bccRecipientsString componentsSeparatedByString:@","]];
	}
  
  if (picker != nil) {
    [self.viewController presentModalViewController:picker animated:YES];
  }
  
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
  // Notifies users about errors associated with the interface
	int composeResult = 0;
	
  switch (result)
  {
    case MFMailComposeResultCancelled:
			composeResult = 0;
      break;
    case MFMailComposeResultSaved:
			composeResult = 1;
      break;
    case MFMailComposeResultSent:
			composeResult = 2;
      break;
    case MFMailComposeResultFailed:
      composeResult = 3;
      break;
    default:
			composeResult = 4;
      break;
  }
	
  [self.viewController dismissModalViewControllerAnimated:YES];
	 
  CDVPluginResult *pluginResult = [ CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:composeResult ];
  [ self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId ];
	
}

@end