//
//  NetworkData.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/13/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

// Used for retrieving data over the network and caching them on device

#define kNetworkDataURL @"https://raw.github.com/ccceeefff/VocabApp/master/VocabData/VocabData.json"

#define NetworkDataFinishedNotification @"networkdatafetchednotificiation"

@interface NetworkData : NSObject
{
    NSArray *_data;
}

+ (NetworkData *) sharedData;

- (void) retrieveData;
- (NSArray *) cachedData;

@end
