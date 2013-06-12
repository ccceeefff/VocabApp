//
//  SDTrainingWordView.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/12/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseWordView.h"

@interface SDTrainingWordView : SDBaseWordView
{
    UILabel *_wordLabel;
    UIButton *_showDefinitionButton;
    UITextView *_definitionScrollView;
}

- (void) toggleShowDefinition;

- (void) showDefinition:(BOOL)animated;
- (void) hideDefinition:(BOOL)animated;

@end
