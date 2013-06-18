//
//  DefinitionsFilter.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/18/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWord.h"

@interface DefinitionsFilter : NSObject
{
    NSMutableArray *_words;
}

+ (DefinitionsFilter *) sharedFilter;

- (NSArray *) cachedData;

- (SDWord *) randomWord;
- (SDWord *) randomOtherWord:(SDWord *)word;
- (NSArray *) randomWords:(int)count differentFromWord:(SDWord *)word;

@end
