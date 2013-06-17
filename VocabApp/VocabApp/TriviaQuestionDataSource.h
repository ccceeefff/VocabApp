//
//  TriviaQuestionDataSource.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/17/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TriviaQuestionDataSource <NSObject>

@required
- (int) numberOfChoices;
- (NSString *) textForChoicesAtIndex:(int)index;
- (NSString *) textForItemQuestion;
- (BOOL) isAnswerCorrectAtIndex:(int)index;

@end
