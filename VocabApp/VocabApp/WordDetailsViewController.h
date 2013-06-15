//
//  WordDetailsViewController.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDWord.h"
#import "SDWordDetailsView.h"

@interface WordDetailsViewController : UIViewController
{
    SDWord *_word;
    SDWordDetailsView *_detailsView;
}

@property (nonatomic, retain) SDWord *word;
@property (nonatomic, retain) UIPopoverController *popover;

@end
