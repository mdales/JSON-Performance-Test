//
//  TestOperation.m
//  JSON Test
//
//  Created by Michael Dales on 26/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TestOperation.h"
#import "AppDelegate.h"

#import "JSON.h"
#import "JSONKit.h"

@implementation TestOperation

@synthesize testString;
@synthesize testStructure;


///////////////////////////////////////////////////////////////////////////////
//
- (id)init
{
    if ((self = [super init]) != nil)
    {
        // build a simple test structure
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 20; i++)
        {
            NSDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setValue: [NSNumber numberWithInt: 42]
                          forKey: @"number1"];
            [dictionary setValue: [NSNumber numberWithInt: 123]
                          forKey: @"number2"];
            [dictionary setValue: [NSNumber numberWithInt: 456]
                          forKey: @"number3"];
            [dictionary setValue: @"A string"
                          forKey: @"string1"];
            [dictionary setValue: @"A string"
                          forKey: @"string2"];
            [dictionary setValue: @"A string"
                          forKey: @"string3"];
            [array addObject: dictionary];
        }
        self.testStructure = array;
        self.testString = [array JSONRepresentation];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////
//
- (void)dealloc
{
    [testStructure release];
    [testString release];
    [super release];
}

#define LOOP_COUNT 10000

///////////////////////////////////////////////////////////////////////////////
//
- (void)main
{
    // for each library time LOOP_COUNT encodes and decodes
    NSDate *start, *finish;
    NSTimeInterval delta;
    
    AppDelegate *appDelegate = (AppDelegate*)[[NSApplication sharedApplication] delegate];
    
    // SBJSON encode
    start = [NSDate date];
    for (int i = 0; i < LOOP_COUNT; i++)
    {
        NSString *code = [self.testStructure JSONRepresentation];
    }
    finish = [NSDate date];
    delta = [finish timeIntervalSinceDate: start];
    
    [appDelegate performSelectorOnMainThread: @selector(setTimeForSBJSONEncode:) 
                                  withObject: [NSNumber numberWithDouble: delta / (float)LOOP_COUNT]
                               waitUntilDone: NO];
    
    // JSONKit encode
    start = [NSDate date];
    for (int i = 0; i < LOOP_COUNT; i++)
    {
        NSString *code = [self.testStructure JSONString];
    }
    finish = [NSDate date];
    delta = [finish timeIntervalSinceDate: start];
    NSLog(@"%@ -> %@ = %g or %@", start,finish, delta, [NSNumber numberWithDouble: delta / (float)LOOP_COUNT]);
    
    [appDelegate performSelectorOnMainThread: @selector(setTimeForJSONKitEncode:) 
                                  withObject: [NSNumber numberWithDouble: delta / (float)LOOP_COUNT]
                               waitUntilDone: NO];
    
    // SBJSON decode
    start = [NSDate date];
    for (int i = 0; i < LOOP_COUNT; i++)
    {
        id info = [self.testString JSONValue];
    }
    finish = [NSDate date];
    delta = [finish timeIntervalSinceDate: start];
    
    [appDelegate performSelectorOnMainThread: @selector(setTimeForSBJSONDecode:) 
                                  withObject: [NSNumber numberWithDouble: delta / (float)LOOP_COUNT]
                               waitUntilDone: NO];
    
    // JSONKit decode
    start = [NSDate date];
    for (int i = 0; i < LOOP_COUNT; i++)
    {
        id info = [self.testString objectFromJSONString];
    }
    finish = [NSDate date];
    delta = [finish timeIntervalSinceDate: start];
    
    [appDelegate performSelectorOnMainThread: @selector(setTimeForJSONKitDecode:) 
                                  withObject: [NSNumber numberWithDouble: delta / (float)LOOP_COUNT]
                               waitUntilDone: NO];
    
    [appDelegate performSelectorOnMainThread: @selector(testDone)
                                  withObject: nil
                               waitUntilDone: YES];
}

@end
