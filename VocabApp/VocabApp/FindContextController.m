//
//  FindContextController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/18/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "FindContextController.h"
#import "ContextsFilter.h"

@implementation FindContextController

- (void) generateChoices
{
    // get 4 other random choices
    NSMutableArray *choices = [NSMutableArray arrayWithArray:[[ContextsFilter sharedFilter] randomWords:4 differentFromWord:_word]];
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
    if([word.samples count] == 0) return nil;
    return [(SDWordSampleContext *)[word.samples objectAtIndex:0] context];
}

- (NSString *) textForItemQuestion
{
    return [(SDWordSampleContext *)[_word.samples objectAtIndex:0] example];
}

/*
 - (NSString *) textForItemQuestion
 {
 NSString *sample = [(SDWordSampleContext *)[_word.samples objectAtIndex:0] example];
 NSMutableArray *words = [NSMutableArray arrayWithArray:[sample componentsSeparatedByString:@" "]];
 for(int i=0; i < [words count]; i++){
 NSString *word = [words objectAtIndex:i];
 if([word isEqualToString:[word uppercaseString]]){
 [words replaceObjectAtIndex:i withObject:@"______"];
 }
 }
 return [words componentsJoinedByString:@" "];
 }
 */

- (BOOL) isAnswerCorrectAtIndex:(int)index
{
    if(index >= [_choices count]) return NO;
    return ([_choices objectAtIndex:index] == _word);
}

@end
