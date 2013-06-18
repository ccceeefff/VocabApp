//
//  DefineWordController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/18/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "DefineWordController.h"

@implementation DefineWordController

- (void) generateChoices
{
    // get 4 other random choices
    NSMutableArray *choices = [NSMutableArray arrayWithArray:[[DefinitionsFilter sharedFilter] randomWords:4 differentFromWord:_word]];
    [choices addObject:_word];
    [choices shuffle];
    
    _choices = [[NSArray arrayWithArray:choices] retain];
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
