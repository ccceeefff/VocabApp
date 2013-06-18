//
//  FindWordGroupController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/18/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "FindWordGroupController.h"
#import "GroupsFilter.h"

@implementation FindWordGroupController

- (void) generateChoices
{
    // get 4 other random choices
    NSMutableArray *choices = [NSMutableArray arrayWithArray:[[GroupsFilter sharedFilter] otherWordGroups:5 differentFromGroups:_word.groups]];
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
    return [_choices objectAtIndex:index];
}

- (NSString *) textForItemQuestion
{
    return _word.word;
}

- (BOOL) isAnswerCorrectAtIndex:(int)index
{
    if(index >= [_choices count]) return NO;
    
    NSString *choice = [_choices objectAtIndex:index];
    NSSet *possibleAnswers = [NSSet setWithArray:_word.groups];
    
    return ([possibleAnswers containsObject:choice]);
}


@end
