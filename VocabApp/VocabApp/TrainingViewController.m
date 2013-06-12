//
//  TrainingViewController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/12/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "TrainingViewController.h"

#import "TestData.h"
#import "NetworkData.h"

@interface TrainingViewController ()

@end

@implementation TrainingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentWordView = nil;
        words = [[[NetworkData sharedData] cachedData] retain];
        currentIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self showWord:[words objectAtIndex:currentIndex] fromRight:YES];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextWord)] autorelease];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(lastWord)] autorelease];
    
}

- (void) showWord:(SDWord *)word fromRight:(BOOL)RightOrLeft
{
    SDTrainingWordView *wordView = [[SDTrainingWordView alloc] initWithFrame:self.view.bounds];
    wordView.word = word;
    SDTrainingWordView *prevWord = currentWordView;
    currentWordView = [wordView retain];
    
    UIViewAnimationOptions options = UIViewAnimationCurveEaseInOut | ( RightOrLeft ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft);
    
    [self.view addSubview:currentWordView];
    animating = YES;
    [UIView transitionFromView:prevWord toView:currentWordView duration:0.5 options:options completion:^(BOOL finished) {
        [prevWord removeFromSuperview];
        [prevWord release];
        animating = NO;
        self.navigationItem.title = [NSString stringWithFormat:@"%i/%i", currentIndex+1, [words count]];
    }];
    
    [wordView release];
}

- (void) nextWord
{
    if(animating) return;
    if(currentIndex < [words count]-1){
        currentIndex++;
        [self showWord:[words objectAtIndex:currentIndex] fromRight:YES];
    }
}

- (void) lastWord
{
    if(animating) return;
    if(currentIndex > 0){
        currentIndex--;
        [self showWord:[words objectAtIndex:currentIndex] fromRight:NO];
    }
}

- (void) dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
