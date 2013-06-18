//
//  FindWordFromDefinitionController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/18/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "FindWordFromDefinitionController.h"

@implementation FindWordFromDefinitionController

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
    return word.word;
}

- (NSString *) textForItemQuestion
{
    return [(SDWordDefinition *)[_word.definitions objectAtIndex:0] definition];
}

- (BOOL) isAnswerCorrectAtIndex:(int)index
{
    if(index >= [_choices count]) return NO;
    return ([_choices objectAtIndex:index] == _word);
}

@end
