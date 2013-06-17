//
//  BaseTriviaController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/17/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "BaseTriviaController.h"

#import "NetworkData.h"
#import "NSMutableArray+Shuffle.h"

@implementation BaseTriviaController

@synthesize word = _word;

- (id) initWithWord:(SDWord *)word
{
    self = [super init];
    if(self != nil){
        
        _word = [word retain];
        [self generateChoices];
        
    }
    return self;
}

- (void) generateChoices
{
    // get 4 other random choices
    NSMutableArray *choices = [NSMutableArray arrayWithArray:[[NetworkData sharedData] randomWords:4 differentFromWord:_word]];
    [choices addObject:_word];
    [choices shuffle];
    
    _choices = [[NSArray arrayWithArray:choices] retain];
}

- (void) dealloc
{
    [_word release];
    [_choices release];
    [super dealloc];
}

#pragma mark - Trivia Data Source

- (int) numberOfChoices
{
    return [_choices count];
}

- (NSString *) textForChoicesAtIndex:(int)index
{
    if(index >= [_choices count]) return nil;
    SDWord *word = [_choices objectAtIndex:index];
    if([word.definitions count] == 0) return nil;
    return [(SDWordDefinition *)[word.definitions objectAtIndex:(index % [word.definitions count])] definition];
}

- (NSString *) textForItemQuestion
{
    return _word.word;
}

- (BOOL) isAnswerCorrectAtIndex:(int)index
{
    if(index >= [_choices count]) return NO;
    return ([_choices objectAtIndex:index] == _word);
}

@end
