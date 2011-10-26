//
//  AppDelegate.h
//  JSON Test
//
//  Created by Michael Dales on 26/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSOperationQueue *queue;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField *sbjsonDecodeResult;
@property (assign) IBOutlet NSTextField *sbjsonEncodeResult;
@property (assign) IBOutlet NSTextField *jsonkitDecodeResult;
@property (assign) IBOutlet NSTextField *jsonkitEncodeResult;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;
@property (assign) IBOutlet NSButton *runButton;

- (IBAction)runTest:(id)sender;

- (void)setTimeForSBJSONEncode: (NSNumber*)time;
- (void)setTimeForSBJSONDecode: (NSNumber*)time;
- (void)setTimeForJSONKitEncode: (NSNumber*)time;
- (void)setTimeForJSONKitDecode: (NSNumber*)time;
- (void)testDone;

@end
