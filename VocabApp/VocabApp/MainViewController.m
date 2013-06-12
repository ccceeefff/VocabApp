//
//  MainViewController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/13/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkData.h"

#import "TrainingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFinished) name:NetworkDataFinishedNotification object:nil];
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Load Data" style:UIBarButtonItemStyleBordered target:self action:@selector(loadData)] autorelease];
    
    trainingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [trainingButton setTitle:@"Training" forState:UIControlStateNormal];
    [self.view addSubview:trainingButton];
    trainingButton.frame = CGRectMake(0, 0, 9999, 9999);
    [trainingButton sizeToFit];
    trainingButton.center = self.view.center;
    trainingButton.autoresizingMask = ~UIViewAutoresizingNone;
    [trainingButton addTarget:self action:@selector(trainingPressed) forControlEvents:UIControlEventTouchUpInside];
    
    if([[NetworkData sharedData] cachedData] == nil){
        trainingButton.enabled = NO;
    }
    
}

- (void) loadData
{
    [[NetworkData sharedData] retrieveData];
}

- (void) loadFinished
{
    if([[NetworkData sharedData] cachedData] == nil){
        trainingButton.enabled = NO;
    }
}

- (void) trainingPressed {
    TrainingViewController *tc = [[[TrainingViewController alloc] init] autorelease];
    UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:tc] autorelease];
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    trainingButton = nil;
}

@end
