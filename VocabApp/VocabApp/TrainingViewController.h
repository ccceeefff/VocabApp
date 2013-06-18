//
//  TrainingViewController.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/12/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDTrainingWordView.h"
#import "SDWordDetailsView.h"
#import "FlashCardBaseView.h"
#import "BaseTriviaController.h"

typedef enum {
    TrainingTypeDefineWord,
    TrainingTypeWordFromDefinition,
    TrainingTypeDefault
} TrainingType;

@interface TrainingViewController : UIViewController
{
    FlashCardBaseView *currentWordView;
    NSMutableArray *words;
    NSUInteger currentIndex;
    BOOL animating;

    TrainingType trainingType;
}

- (id) initWithTrainingType:(TrainingType)type;
- (void) gatherWords;
- (Class) getControllerClassForType:(TrainingType)type;

@end
