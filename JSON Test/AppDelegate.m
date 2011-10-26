//
//  AppDelegate.m
//  JSON Test
//
//  Created by Michael Dales on 26/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "TestOperation.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize runButton, progressIndicator;
@synthesize sbjsonDecodeResult, sbjsonEncodeResult, jsonkitDecodeResult, jsonkitEncodeResult;

///////////////////////////////////////////////////////////////////////////////
//
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}


///////////////////////////////////////////////////////////////////////////////
//
- (IBAction)runTest:(id)sender
{
    [runButton setEnabled: NO];
    [progressIndicator startAnimation: nil];
    [sbjsonDecodeResult setStringValue: @""];
    [sbjsonEncodeResult setStringValue: @""];
    [jsonkitDecodeResult setStringValue: @""];
    [jsonkitEncodeResult setStringValue: @""];
 
    // run tests in another thread
    if (queue == nil)
    {
        queue = [[NSOperationQueue alloc] init];
    }
    
    TestOperation *test = [[TestOperation alloc] init];
    [queue addOperation: test];
    [test release];
}



- (void)setTimeForSBJSONEncode: (NSNumber*)time
{
    NSString *timestr = [NSString stringWithFormat: @"%.07f", [time doubleValue]];
    [sbjsonEncodeResult setStringValue: timestr];
}


- (void)setTimeForSBJSONDecode: (NSNumber*)time
{
    NSString *timestr = [NSString stringWithFormat: @"%.07f", [time doubleValue]];
    [sbjsonDecodeResult setStringValue: timestr];
}


- (void)setTimeForJSONKitEncode: (NSNumber*)time
{
    NSString *timestr = [NSString stringWithFormat: @"%.07f", [time doubleValue]];
    [jsonkitEncodeResult setStringValue: timestr];
}


- (void)setTimeForJSONKitDecode: (NSNumber*)time
{
    NSString *timestr = [NSString stringWithFormat: @"%.07f", [time doubleValue]];
    [jsonkitDecodeResult setStringValue: timestr];
}

- (void)testDone
{
    [runButton setEnabled: YES];
    [progressIndicator stopAnimation: nil];
}

@end
