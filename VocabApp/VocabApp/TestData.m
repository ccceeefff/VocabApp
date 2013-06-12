//
//  TestData.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/13/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "TestData.h"

@implementation TestData

+ (SDWord *) randomWord
{
    SDWord *word = nil;
    
    int ran = rand() % 3 + 1;
    switch (ran) {
        case 1:
            word = [SDWord createWord:@"SingleDefinition"];
            break;
        case 2:
            word = [SDWord createWord:@"DoubleDefinition"];
            break;
        case 3:
            word = [SDWord createWord:@"TripleDefinition"];
            break;
        default:
            word = [SDWord createWord:@"NoDefinition"];
            break;
    }
    for(int i=0; i<ran; i++){
        [word addDefinitionWithType:@"verb" andDefinition:@"a test word; that i'd like to test"];
    }
    
    return word;
}

+ (NSArray *) randomWords
{
    NSMutableArray *words = [NSMutableArray array];
    for(int i=0; i < 10; i++){
        [words addObject:[TestData randomWord]];
    }
    return words;
}

@end
