//
//  BaseTriviaController.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/17/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetworkData.h"
#import "DefinitionsFilter.h"
#import "NSMutableArray+Shuffle.h"
#import "TriviaQuestionDataSource.h"
#import "SDWord.h"

@interface BaseTriviaController : NSObject <TriviaQuestionDataSource>
{
    SDWord *_word;
    NSArray *_choices;
}

@property (nonatomic, readonly) SDWord *word;

- (id) initWithWord:(SDWord *)word;
- (void) generateChoices;

@end
