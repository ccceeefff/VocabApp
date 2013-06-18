//
//  FlashCardBaseView.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseTriviaController.h"

@interface FlashCardBaseView : UIView
{
    BaseTriviaController *_controller;
    
    UIView *_questionView;
    NSMutableArray *_answerViews;
    NSMutableArray *_answerButtons;

}

@property (nonatomic, readonly) BaseTriviaController *controller;
@property (nonatomic, assign) id delegate;

- (id) initWithFrame:(CGRect)frame andController:(BaseTriviaController *)controller;

- (void) layoutFlashCard;
- (void) answerButtonPressed:(UIButton *)sender;

- (UIView *) getQuestionView;
- (UIView *) getViewForAnswerAtIndex:(NSUInteger)index;
- (UIButton *) getButtonForChoiceAtIndex:(NSUInteger)index;

@end

@protocol FlashCardDelegate <NSObject>

- (void) flashCard:(FlashCardBaseView *)card answeredCorrectly:(BOOL)yesOrNo;

@end