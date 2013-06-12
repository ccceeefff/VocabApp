//
//  SDTrainingWordView.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/12/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "SDTrainingWordView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SDTrainingWordView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self != nil){
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _wordLabel = [[UILabel alloc] init];
        _wordLabel.font = [UIFont systemFontOfSize:96];
        _wordLabel.adjustsFontSizeToFitWidth = YES;
        _wordLabel.textAlignment = UITextAlignmentCenter;
        _wordLabel.textColor = [UIColor blackColor];
        _wordLabel.minimumFontSize = 10;
        [self addSubview:_wordLabel];
        
        _showDefinitionButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [_showDefinitionButton setTitle:@"Show Definition" forState:UIControlStateNormal];
        [_showDefinitionButton addTarget:self action:@selector(toggleShowDefinition) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_showDefinitionButton];
        
        _definitionScrollView = [[UITextView alloc] init];
        _definitionScrollView.editable = NO;
        _definitionScrollView.font = [UIFont systemFontOfSize:24];
        _definitionScrollView.layer.borderColor = [UIColor grayColor].CGColor;
        _definitionScrollView.layer.borderWidth = 1.0;
        _definitionScrollView.layer.cornerRadius = 8.0;
        [self addSubview:_definitionScrollView];
        
        CGRect myBounds = CGRectInset(self.bounds, 40, 40);
        CGPoint origin = myBounds.origin;
        
        _wordLabel.frame = CGRectMake(origin.x, origin.y, myBounds.size.width, myBounds.size.height * 0.7);
        
        _showDefinitionButton.frame = CGRectMake(origin.x, origin.y, myBounds.size.width, myBounds.size.height * 0.1);
        [_showDefinitionButton sizeToFit];
        _showDefinitionButton.center = CGPointMake(origin.x + myBounds.size.width/2.0, _wordLabel.frame.size.height + _showDefinitionButton.frame.size.height/2.0);
        
        _definitionScrollView.frame = CGRectMake(origin.x, origin.y + myBounds.size.height * 0.8, myBounds.size.width, myBounds.size.height * 0.2);
        
        _wordLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleBottomMargin;
        _showDefinitionButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        _definitionScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        
    }
    return self;
}

- (void) dealloc
{
    [_wordLabel release];
    [_showDefinitionButton release];
    [_definitionScrollView release];
    [super dealloc];
}

- (void) setWord:(SDWord *)word
{
    [super setWord:word];
    _wordLabel.text = word.word;
    [self hideDefinition:NO];
    [self prepareDefinitions];
}

- (void) prepareDefinitions
{
    NSMutableString *definitionsText = [[NSMutableString alloc] init];
    
    for(SDWordDefinition *definition in self.word.definitions){
        [definitionsText appendFormat:@"\u2022 %@ : %@ \n\n", definition.type, definition.definition];
    }
    
    _definitionScrollView.text = definitionsText;
    [definitionsText release];
}

- (void) toggleShowDefinition
{
    if(_definitionScrollView.hidden == YES){
        // show
        [self showDefinition:YES];
    } else {
        // hide
        [self hideDefinition:YES];
    }
}

- (void) showDefinition:(BOOL)animated
{
    if(_definitionScrollView.hidden == YES){
        if(animated){
            [UIView animateWithDuration:0.3 animations:^{
                _definitionScrollView.hidden = NO;
                _definitionScrollView.alpha = 1.0;
            } completion:^(BOOL finished) {
                _definitionScrollView.hidden = !finished;
                _definitionScrollView.alpha = finished ? 1.0 : 0.0;
            }];
        } else {
            _definitionScrollView.alpha = 1.0;
            _definitionScrollView.hidden = NO;
        }
    }
}

- (void) hideDefinition:(BOOL)animated
{
    if(_definitionScrollView.hidden == NO){
        if(animated){
            [UIView animateWithDuration:0.3 animations:^{
                _definitionScrollView.alpha = 0.0;
            } completion:^(BOOL finished) {
                _definitionScrollView.hidden = finished;
                _definitionScrollView.alpha = !finished ? 1.0 : 0.0;
            }];
        } else {
            _definitionScrollView.alpha = 0.0;
            _definitionScrollView.hidden = YES;
        }
    }
}

@end
