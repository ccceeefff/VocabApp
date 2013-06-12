//
//  TestData.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/13/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SDWord.h"

@interface TestData : NSObject

+ (SDWord *) randomWord;
+ (NSArray *) randomWords;

@end
