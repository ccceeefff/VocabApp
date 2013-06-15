//
//  WordListViewController.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "WordListViewController.h"

#import "NetworkData.h"
#import "SDWord.h"

@interface WordListViewController ()

@end

@implementation WordListViewController

@synthesize words = _words;
@synthesize detailsViewController = _detailsViewController;

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
    
    self.words = [NSArray arrayWithArray:[[NetworkData sharedData] cachedData]];
    
    CGRect bounds = self.view.bounds;
    
    _tableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"wordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    SDWord *word = [self.words objectAtIndex:indexPath.row];
    cell.textLabel.text = word.word;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.detailsViewController != nil){
        SDWord *word = [self.words objectAtIndex:indexPath.row];
        self.detailsViewController.word = word;
    }
}

@end
