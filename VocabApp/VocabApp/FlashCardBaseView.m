//
//  FlashCardBaseView.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "FlashCardBaseView.h"

#define kMargin 20
#define kSpacing 10

#define kAnswerButtonSize 60

#define kQuestionViewTag 300
#define kAnswerButtonTagBase 1000
#define kAnswerViewTagBase 2000

@implementation FlashCardBaseView

@synthesize controller = _controller;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame andController:(BaseTriviaController *)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        _controller = [controller retain];
        
        _questionView = nil;
        _answerViews = [[NSMutableArray alloc] initWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
        _answerButtons = [[NSMutableArray alloc] initWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
    }
    return self;
}

- (void) dealloc
{
    [_controller release];
    [_questionView release];
    [_answerViews release];
    [_answerButtons release];
    [super dealloc];
}

- (void) layoutSubviews{
    [self layoutFlashCard];
    [super layoutSubviews];
}

- (void) layoutFlashCard
{
    CGRect bounds = self.bounds;
    
    // assumption is that views have already been added to the superview
    CGFloat dy = 0;
    
    // layout the question
    UIView *questionView = [self getQuestionView];
    questionView.frame = CGRectMake(kMargin, kMargin, bounds.size.width - 2*kMargin, bounds.size.height/3.0 - kMargin*2.0);
    
    dy += bounds.size.height/3.0;
    
    // layout the answers
    int count = [_controller numberOfChoices];
    CGFloat heightPerAnswer = bounds.size.height * (2.0/3.0) / count ;
    for(int i=0; i < count; i++){
        
        UIView *answerButton = [self getButtonForChoiceAtIndex:i];
        UIView *answerView = [self getViewForAnswerAtIndex:i];
        
        answerButton.frame = CGRectMake(kMargin, dy + heightPerAnswer/2.0 - kAnswerButtonSize/2.0, kAnswerButtonSize, kAnswerButtonSize);
        answerView.frame = CGRectMake(kMargin + answerButton.frame.size.width + kSpacing, dy + kSpacing, bounds.size.width - 2*kMargin - answerButton.frame.size.width - 2*kSpacing, heightPerAnswer - 2*kSpacing);
        
        dy += heightPerAnswer;
    }
    
}

- (void) answerButtonPressed:(UIButton *)sender
{
    BOOL correct = [_controller isAnswerCorrectAtIndex:sender.tag - kAnswerButtonTagBase];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:(correct ? @"Correct!" : @"Wrong!") message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alertView.tag = correct ? 1 : 0;
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([self.delegate respondsToSelector:@selector(flashCard:answeredCorrectly:)]){
        [self.delegate flashCard:self answeredCorrectly:alertView.tag];
    }
}

- (UIView *) getQuestionView
{
    if(_questionView == nil){
        UILabel *questionView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 9999, 9999)];
        questionView.textColor = [UIColor blackColor];
        questionView.textAlignment = UITextAlignmentCenter;
        questionView.numberOfLines = 999;
        questionView.font = [UIFont boldSystemFontOfSize:56];
        questionView.minimumFontSize = 30;
        _questionView = questionView;
        [self addSubview:questionView];
    }
    
    UILabel *questionView = (UILabel *)_questionView;
    questionView.text = [_controller textForItemQuestion];
    questionView.tag = kQuestionViewTag;
    
    return _questionView;
}

- (UIView *)getViewForAnswerAtIndex:(NSUInteger)index
{
    UILabel *answerView = [_answerViews objectAtIndex:index];
    if([answerView isKindOfClass:[NSNull class]]){
        answerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 9999, 9999)];
        answerView.textColor = [UIColor blackColor];
        answerView.textAlignment = UITextAlignmentLeft;
        answerView.numberOfLines = 999;
        answerView.font = [UIFont systemFontOfSize:24];
        answerView.minimumFontSize = 10;
        [_answerViews replaceObjectAtIndex:index withObject:answerView];
        [self addSubview:answerView];
        [answerView release];
    }
    
    answerView.text = [_controller textForChoicesAtIndex:index];
    answerView.tag = kAnswerViewTagBase + index;
    
    return answerView;
}

- (UIButton *) getButtonForChoiceAtIndex:(NSUInteger)index
{
    UIButton *button = [_answerButtons objectAtIndex:index];
    if([button isKindOfClass:[NSNull class]]){
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(answerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_answerButtons replaceObjectAtIndex:index withObject:button];
        [self addSubview:button];
    }
    
    [button setTitle:[NSString stringWithFormat:@"%c", ('A' + index)] forState:UIControlStateNormal];
    button.tag = kAnswerButtonTagBase + index;
    
    return button;
}

@end
