//
//  WordListViewController.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WordDetailsViewController.h"

@interface WordListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *_filterField;
    UITableView *_tableView;
    
    WordDetailsViewController *_detailsViewController;
    
    NSArray *_words;
}

@property (nonatomic, retain) NSArray *words;
@property (nonatomic, assign) WordDetailsViewController *detailsViewController;

@end
