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

    NSMutableDictionary *words = [[NSMutableDictionary alloc] init];
    NSDictionary *results = (NSDictionary *)jsonData;
    for(NSString *key in [results allKeys]){
        NSDictionary *wordObject = [results objectForKey:key];
        SDWord *word = [SDWord createWord:key];
        
        // we know the word, lets get the definitions and groups
        NSArray *definitions = [wordObject objectForKey:@"definitions"];
        for(NSDictionary *def in definitions){
            NSString *type = [def objectForKey:@"type"];
            NSString *definition = [def objectForKey:@"definition"];
            [word addDefinitionWithType:type andDefinition:definition];
        }
        
        NSArray *groups = [wordObject objectForKey:@"groups"];
        for(NSString *group in groups){
            [word addGroup:group];
        }
        
        NSArray *samples = [wordObject objectForKey:@"samples"];
        for(NSDictionary *sample in samples){
            NSString *context = [sample objectForKey:@"context"];
            NSString *example = [sample objectForKey:@"example"];
            [word addSampleWithContext:context andExample:example];
        }
        
        // store the object
        [words setObject:word forKey:key];
    }
    
    //write this to the cache file
    BOOL result = [NSKeyedArchiver archiveRootObject:words toFile:[self cacheFileName]];
    NSLog(@"path: %@", [self cacheFileName]);
    NSLog(@"write result: %@", result ? @"success" : @"failure");
    
    NSLog(@"sd words: %@", words);
    [words release];
    
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
    return [_data allValues];
}

@end
