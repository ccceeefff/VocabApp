//
//  WordDetailsViewController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "WordDetailsViewController.h"

@interface WordDetailsViewController ()

@end

@implementation WordDetailsViewController

@synthesize word = _word;
@synthesize popover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if(_detailsView == nil){
        _detailsView = [[SDWordDetailsView alloc] initWithFrame:self.view.bounds];
    }
    _detailsView.frame = self.view.bounds;
    _detailsView.word = self.word;
    [self.view addSubview:_detailsView];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.popover = nil;
    [_detailsView release]; _detailsView = nil;
}

- (void) dealloc
{
    [_word release]; _word = nil;
    [_detailsView release]; _detailsView = nil;
    [super dealloc];
}

- (void) setWord:(SDWord *)word
{
    if(word != _word){
        [_word release];
        _word = [word retain];
        _detailsView.word = _word;
    }
    
    if(self.popover != nil){
        [self.popover dismissPopoverAnimated:YES];
    }
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    //Grab a reference to the popover
    self.popover = pc;
    
    //Set the title of the bar button item
    barButtonItem.title = @"List";
    
    //Set the bar button item as the Nav Bar's leftBarButtonItem
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //Remove the barButtonItem.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
    //Nil out the pointer to the popover.
    self.popover = nil;
}

@end
