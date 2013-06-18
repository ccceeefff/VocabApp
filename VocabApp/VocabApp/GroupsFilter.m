//
//  GroupsFilter.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/18/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "GroupsFilter.h"
#import "NetworkData.h"
#import "NSMutableArray+Shuffle.h"

@implementation GroupsFilter

+ (GroupsFilter *) sharedFilter
{
    static GroupsFilter *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GroupsFilter alloc] init];
    });
    return _instance;
}

- (id) init
{
    self = [super init];
    if(self != nil){
        _words = nil;
        _wordGroups = nil;
        [self refreshData];
    }
    return self;
}

- (void) dealloc
{
    [_words release];
    [_wordGroups release];
    [super dealloc];
}

- (void) refreshData
{
    [_words release]; _words = nil;
    [_wordGroups release]; _wordGroups = nil;
    NSArray *cachedWords = [[NetworkData sharedData] cachedData];
    _words = [[NSMutableArray alloc] initWithArray:[cachedWords filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        SDWord *word = (SDWord *)evaluatedObject;
        return ([word.groups count] > 0);
    }]]];
    [_words shuffle];
    
    _wordGroups = [[NSMutableSet alloc] init];
    for(SDWord *word in _words){
        [_wordGroups addObjectsFromArray:word.groups];
    }
}

- (NSString *) cachedData
{
    return [NSArray arrayWithArray:_words];
}

- (NSArray *) otherWordGroups:(int)count differentFromGroups:(NSArray *)groups
{
    NSMutableSet *newSet = [NSMutableSet setWithArray:groups];
    NSMutableArray *randomGroups = [NSMutableArray arrayWithArray:[_wordGroups allObjects]];
    [randomGroups shuffle];

    for(NSString *group in randomGroups){
        if(![newSet containsObject:group]){
            [newSet addObject:group];
        }
        
        if([newSet count] >= count) break;
    }

    return [newSet allObjects];
}

- (SDWord *) randomWord
{
    NSArray *words = _words;
    if(words == nil || [words count] == 0) return nil;
    
    NSUInteger randIndex = arc4random() % [words count];
    return [words objectAtIndex:randIndex];
}

- (SDWord *)randomOtherWord:(SDWord *)word
{
    NSArray *words = _words;
    if(words == nil || [words count] == 0) return nil;
    
    // if |word| is the only entry in the array
    if([words count] == 1 && [words containsObject:word]) return nil;
    
    SDWord *randomWord = nil;
    do {
        randomWord = [self randomWord];
    } while (randomWord == word);
    
    return randomWord;
}

- (NSArray *) randomWords:(int)count differentFromWord:(SDWord *)word
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(int i=0; i<count; i++){
        [array addObject:[self randomOtherWord:word]];
    }
    
    NSArray *words = [NSArray arrayWithArray:array];
    [array release];
    return words;
}

@end
