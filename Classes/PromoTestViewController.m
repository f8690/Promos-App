//
//  PromoTestViewController.m
//  PromoTest
//
//  Created by WeiJian Wu on 13-04-16.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "PromoTestViewController.h"

@implementation PromoTestViewController
@synthesize textView;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Want to redeem: %@", textField.text);
	// Get device unique ID
	UIDevice *device = [UIDevice currentDevice];
	NSString *uniqueIdentifier = [device uniqueIdentifier];
	
	// Start request
	NSString *code = textField.text;
	NSURL *url = [NSURL URLWithString:@"http://promos.develop.local"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:@"1" forKey:@"rw_app_id"];
	[request setPostValue:code forKey:@"code"];
	[request setPostValue:uniqueIdentifier forKey:@"device_id"];
	[request setDelegate:self];
	[request startAsynchronous];
	
	// Hide keyword
	[textField resignFirstResponder];
	
	// Clear text field
	textView.text = @"";
	
	// Show progress
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Redeeming code...";
	
    return TRUE;
}

- (void) requestFinished:(ASIHTTPRequest *) request {
	
	// Hide progress
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	
	if (request.responseStatusCode == 400) {
		textView.text = @"Invalid code";
	} else if (request.responseStatusCode == 403) {
		textView.text = @"Code already used";
	} else if (request.responseStatusCode == 200) {
		NSString *responseString = [request responseString];
		NSDictionary *responseDict = [responseString JSONValue];
		NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
		
		if ([unlockCode compare:@"com.raeware.test.unlock.cake"] == NSOrderedSame) {
			textView.text = @"The cake is a lie";
		} else {
			textView.text = [NSString stringWithFormat: @"Received unexpected unlock code: %@", unlockCode];
		}
	} else {
		textView.text = @"Unexpected error";
	}
	
}

- (void) requestFailed:(ASIHTTPRequest *) request {
	
	// Hide progress
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	
	NSError *error = [request error];
	textView.text = error.localizedDescription;
}

@end
