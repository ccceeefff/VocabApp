//
//  NetworkData.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/13/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "NetworkData.h"

#import "SDWord.h"

#define kCacheFileName @"wordCache.dat"

@implementation NetworkData

+ (NetworkData *) sharedData
{
    static NetworkData *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NetworkData alloc] init];
    });
    return _instance;
}

- (NSString *) cacheFileName
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:kCacheFileName];
}

- (void) retrieveData
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kNetworkDataURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:120];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        NSLog(@"request response: %i", ((NSHTTPURLResponse *)response).statusCode);
        if(error == nil){
            NSError *jsonError = nil;
            id jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
            if(jsonError == nil){
                NSLog(@"json response: %@", jsonResponse);
                
                [self parseJSONData:jsonResponse];
                
            } else {
                NSLog(@"json error: %@", jsonError);
            }
        } else {
            NSLog(@"request error: %@", error);
        }
    }];
}

- (void) parseJSONData:(id)jsonData
{
    // assume it's an array cos that's how we defined it
    NSMutableArray *sdWords = [NSMutableArray array];
    NSArray *jsonWords = jsonData;
    for(NSDictionary *jsonWord in jsonWords){
        NSString *wWord = [jsonWord objectForKey:@"word"];
        NSString *wType = [jsonWord objectForKey:@"type"];
        NSString *wDef = [jsonWord objectForKey:@"definition"];
        
        SDWord *word = [SDWord createWord:wWord];
        [word addDefinitionWithType:wType andDefinition:wDef];
        [sdWords addObject:word];
    }
    
    //write this to the cache file
    BOOL result = [NSKeyedArchiver archiveRootObject:sdWords toFile:[self cacheFileName]];
    NSLog(@"path: %@", [self cacheFileName]);
    NSLog(@"write result: %@", result ? @"success" : @"failure");
    
    NSLog(@"sd words: %@", sdWords);
    
    //release the old cache file
    [_data release];
    _data = nil;
    
    [[[[UIAlertView alloc] initWithTitle:@"Load Finished!" message:@"You can now start training." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkDataFinishedNotification object:nil userInfo:nil];
}

- (NSArray *) cachedData
{
    if(_data == nil){
        _data = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self cacheFileName]] retain];
    }
    return _data;
}

@end
