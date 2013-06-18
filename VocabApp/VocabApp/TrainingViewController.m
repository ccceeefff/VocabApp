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
#import "NSMutableArray+Shuffle.h"
#import "DefinitionsFilter.h"

#import "DefineWordController.h"
#import "FindWordFromDefinitionController.h"

@interface TrainingViewController ()

@end

@implementation TrainingViewController

- (id) initWithTrainingType:(TrainingType)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
        trainingType = type;
        
        currentWordView = nil;
        words = [[NSMutableArray alloc] init];
        [self gatherWords];
        [words shuffle];
        currentIndex = 0;
    }
    return self;
}

- (void) gatherWords
{
    switch (trainingType) {
        case TrainingTypeDefineWord:
            [words addObjectsFromArray:[[DefinitionsFilter sharedFilter] cachedData]];
            break;
        case TrainingTypeWordFromDefinition:
            [words addObjectsFromArray:[[DefinitionsFilter sharedFilter] cachedData]];
            break;
        default:
            [words addObjectsFromArray:[[NetworkData sharedData] cachedData]];
            break;
    }
}

- (Class) getControllerClassForType:(TrainingType)type
{
    Class aClass;
    switch (trainingType) {
        case TrainingTypeDefineWord:
            aClass = [DefineWordController class];
            break;
        case TrainingTypeWordFromDefinition:
            aClass = [FindWordFromDefinitionController class];
            break;
        default:
            aClass = [BaseTriviaController class];
            break;
    }
    return aClass;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [words shuffle];
    
    [self showWord:[words objectAtIndex:currentIndex] fromRight:YES];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [segmentedControl addTarget:self action:@selector(segmentedControlPressed:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.momentary = YES;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:segmentedControl] autorelease];
    [segmentedControl release];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleDone target:self action:@selector(returnToHome)] autorelease];
    
    /*
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextWord)] autorelease];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(lastWord)] autorelease];
    */
}

- (void) returnToHome
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) segmentedControlPressed:(UISegmentedControl *)control
{
    switch (control.selectedSegmentIndex) {
        case 0:
            [self lastWord];
            break;
        case 1:
        default:
            [self nextWord];
            break;
    }
}

- (void) showWord:(SDWord *)word fromRight:(BOOL)RightOrLeft
{
    BaseTriviaController *controller = [[[self getControllerClassForType:trainingType] alloc] initWithWord:word];
    FlashCardBaseView *wordView = [[FlashCardBaseView alloc] initWithFrame:self.view.bounds andController:controller];
    wordView.autoresizingMask = ~UIViewAutoresizingNone;
    [controller release];
    //wordView.word = word;
    FlashCardBaseView *prevWord = currentWordView;
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
    [words release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
