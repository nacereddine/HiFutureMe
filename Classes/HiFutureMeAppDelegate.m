//
//  HiFutureMeAppDelegate.m
//  HiFutureMe
//
//  Created by nacereddine on 8/10/10.
//  Copyright nacereddine 2010. All rights reserved.
//

#import "HiFutureMeAppDelegate.h"

@implementation HiFutureMeAppDelegate

@synthesize window;
@synthesize messageContent;
@synthesize receiveTime;
@synthesize hideKbrdButton;

- (IBAction) sendMessage{
	
	UIAlertView* aView = [[UIAlertView alloc] initWithTitle:@"Message Sent" 
													message:@"Future You has received it." 
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	UILocalNotification* localNotif = [[UILocalNotification alloc] init];
	
	[localNotif setFireDate:[receiveTime date]];
	[localNotif setAlertBody:[messageContent text]];
	[localNotif setHasAction:NO];
	[localNotif setSoundName:UILocalNotificationDefaultSoundName];
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
	[localNotif release];
	[aView show];
	[aView release];
}

- (IBAction) clear{
	[messageContent setText:@" "];
}

- (IBAction) hideTheKeyboard{
	[hideKbrdButton setTitle:@"Set Date/Time" forState:(UIControlState)UIControlStateNormal];
	if ([receiveTime isHidden]) {
		[messageContent resignFirstResponder];
		[receiveTime setHidden:NO];
		[hideKbrdButton setTitle:@"Send" forState:(UIControlState)UIControlStateNormal];
	}else {
		[receiveTime setHidden:YES];
		[hideKbrdButton setHidden:YES];
		//Send the notification
		[self sendMessage];
	}

}

-(IBAction) justHideTheKeyboard{
	[messageContent resignFirstResponder];
	[hideKbrdButton setHidden:YES];
	[receiveTime setHidden:YES];
	[hideKbrdButton setTitle:@"Set Date/Time" forState:(UIControlState)UIControlStateNormal];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	//[hideKbrdButton setHidden:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
	[hideKbrdButton setHidden:NO];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after application launch.

	NSDate* now = [[NSDate alloc] init];
	[receiveTime setTimeZone:[NSTimeZone localTimeZone]];
	[receiveTime setMinimumDate:now];
	[receiveTime setDate:now];
	[now release];

    [window makeKeyAndVisible];
	
	return YES;
}


//notification handling for when the app is in the foreground.
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
	UIAlertView* alertNotification = [[UIAlertView alloc] initWithTitle:@"Hi, Future Me" 
																message:[notification alertBody] 
															   delegate:nil 
													  cancelButtonTitle:@"Thanks" 
													  otherButtonTitles:nil];
	[alertNotification show];
	[alertNotification release];
	

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	NSDate* now = [[NSDate alloc] init];
	[receiveTime setMinimumDate:now];
	[receiveTime setDate:now];
	[now release];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}





- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
