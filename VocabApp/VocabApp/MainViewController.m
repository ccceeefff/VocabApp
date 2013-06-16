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
#import "WordListViewController.h"
#import "WordDetailsViewController.h"

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
    
    listButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [listButton setTitle:@"List" forState:UIControlStateNormal];
    [self.view addSubview:listButton];
    listButton.frame = CGRectMake(0, 0, 9999, 9999);
    [listButton sizeToFit];
    listButton.center = CGPointMake(trainingButton.center.x, trainingButton.center.y + 60);
    listButton.autoresizingMask = ~UIViewAutoresizingNone;
    [listButton addTarget:self action:@selector(listPressed) forControlEvents:UIControlEventTouchUpInside];
    
    if([[NetworkData sharedData] cachedData] == nil){
        trainingButton.enabled = NO;
        listButton.enabled = NO;
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
        listButton.enabled = NO;
    } else {
        trainingButton.enabled = YES;
        listButton.enabled = YES;
    }
}

- (void) trainingPressed {
    TrainingViewController *tc = [[[TrainingViewController alloc] init] autorelease];
    UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:tc] autorelease];
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (void) listPressed {
    WordListViewController *tc = [[[WordListViewController alloc] init] autorelease];
    tc.hidesBottomBarWhenPushed = YES;
    UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:tc] autorelease];
    WordDetailsViewController *vc = [[[WordDetailsViewController alloc] init] autorelease];
    vc.hidesBottomBarWhenPushed = YES;
    UINavigationController *nc2 = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    //self.window.rootViewController = nc;
    
    tc.detailsViewController = vc;
    
    UISplitViewController *sp = [[[UISplitViewController alloc] init] autorelease];
    sp.viewControllers = [NSArray arrayWithObjects:nc, nc2, nil];
    sp.delegate = vc;
    sp.hidesBottomBarWhenPushed = YES;
    //[self presentViewController:sp animated:YES completion:nil];
    //[self.navigationController pushViewController:sp animated:YES];
    UITabBarController *tb = [[[UITabBarController alloc] init] autorelease];
    tb.viewControllers = [NSArray arrayWithObject:sp];
    [self presentViewController:tb animated:YES completion:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    trainingButton = nil;
    listButton = nil;
}

@end
