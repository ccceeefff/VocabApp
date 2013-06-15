//
//  SDWordDetailsView.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDWord.h"

@interface SDWordDetailsView : UIView
{
    UIScrollView *_containerView;
    
    SDWord *_word;
}

@property (nonatomic, retain) SDWord *word;

@end
