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

@interface TrainingViewController : UIViewController
{
    SDWordDetailsView *currentWordView;
    NSMutableArray *words;
    NSUInteger currentIndex;
    BOOL animating;
}

@end
