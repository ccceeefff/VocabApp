//
//  SDWordDetailsView.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/15/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "SDWordDetailsView.h"

#define kMargin 20
#define kTab    15
#define kGroupSpacing 10
#define kItemSpacing 5

@implementation SDWordDetailsView

@synthesize word = _word;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        _containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_containerView];
        
    }
    return self;
}

- (void) dealloc
{
    [_containerView release];
    [super dealloc];
}

- (void) setWord:(SDWord *)word
{
    if(word != _word){
        [_word release];
        _word = [word retain];
    }
    [self refreshData];
}

- (void) formatLabel:(UILabel *)label configuration:(NSUInteger)type
{
    /*
     *  Configurations
     *  0 : Main
     *  1 : Header
     *  2 : Bold Entry
     *  3 : Entry
     */
    
    switch (type) {
        case 0:
            [label setFont:[UIFont boldSystemFontOfSize:56]];
            break;
        case 1:
            [label setFont:[UIFont boldSystemFontOfSize:36]];
            break;
        case 2:
            [label setFont:[UIFont boldSystemFontOfSize:28]];
            break;
        case 3:
            [label setFont:[UIFont systemFontOfSize:28]];
            break;
        default:
            break;
    }
    
    label.numberOfLines = 999;
    label.textColor = [UIColor blackColor];
    CGPoint origin = label.frame.origin;
    CGFloat width = label.frame.size.width;
    CGSize size = [label sizeThatFits:label.frame.size];
    label.frame = CGRectMake(origin.x, origin.y, width, size.height);
    label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void) refreshData
{
    [[_containerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGRect bounds = _containerView.bounds;
    CGFloat width = bounds.size.width;
    //CGFloat height = bounds.size.height;
    CGFloat dy = 0;
    CGFloat dx = 0;
    
    // create the different labels to place in the scroll view
    
    // initial spacing
    dy += kMargin;
    dx += kMargin;
    
    // WORD LABEL
    UILabel *wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
    wordLabel.text = self.word.word;
    [self formatLabel:wordLabel configuration:0];
    [_containerView addSubview:wordLabel];
    dy += wordLabel.frame.size.height + kMargin;
    [wordLabel release];
    
    // DEFINITIONS HEADER LABEL
    UILabel *definitionsHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
    definitionsHeaderLabel.text = @"Definitions";
    [self formatLabel:definitionsHeaderLabel configuration:1];
    [_containerView addSubview:definitionsHeaderLabel];
    dy += definitionsHeaderLabel.frame.size.height;
    [definitionsHeaderLabel release];

    dx += kTab;
    
    // Definitions [Array]
    for(SDWordDefinition *definition in self.word.definitions){
        dy +=  + kGroupSpacing;
        
        // Type Label
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
        typeLabel.text = [NSString stringWithFormat:@"\u2022 %@", definition.type];
        [self formatLabel:typeLabel configuration:2];
        [_containerView addSubview:typeLabel];
        dy += typeLabel.frame.size.height + kItemSpacing;
        [typeLabel release];
        
        dx += kTab;
        
        // Meaning Label
        UILabel *meaningLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
        meaningLabel.text = definition.definition;
        [self formatLabel:meaningLabel configuration:3];
        [_containerView addSubview:meaningLabel];
        dy += meaningLabel.frame.size.height;
        [meaningLabel release];

        dx -= kTab;
    }
    
    dx -= kTab;
    dy += kMargin;

    // GROUPs HEADER LABEL
    UILabel *groupsHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
    groupsHeaderLabel.text = @"Groups";
    [self formatLabel:groupsHeaderLabel configuration:1];
    [_containerView addSubview:groupsHeaderLabel];
    dy += groupsHeaderLabel.frame.size.height + kGroupSpacing;
    [groupsHeaderLabel release];
    
    dx += kTab;
    
    // Groups [Array]
    for(NSString *group in self.word.groups){
        UILabel *groupLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
        groupLabel.text = [NSString stringWithFormat:@"\u2022 %@", group];
        [self formatLabel:groupLabel configuration:3];
        [_containerView addSubview:groupLabel];
        dy += groupLabel.frame.size.height + kItemSpacing;
        [groupLabel release];
    }
    
    dx -= kTab;
    dy += kMargin;
    
    // SAMPLES HEADER LABEL
    UILabel *samplesHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
    samplesHeaderLabel.text = @"Samples";
    [self formatLabel:samplesHeaderLabel configuration:1];
    [_containerView addSubview:samplesHeaderLabel];
    dy += samplesHeaderLabel.frame.size.height;
    [samplesHeaderLabel release];
    
    // Samples [Array]
    dx += kTab;
    
    for(SDWordSampleContext *sample in self.word.samples){
        
        dy += kGroupSpacing;
        
        // Context Label
        UILabel *contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
        contextLabel.text = [NSString stringWithFormat:@"\u2022 %@", sample.context];
        [self formatLabel:contextLabel configuration:2];
        [_containerView addSubview:contextLabel];
        dy += contextLabel.frame.size.height + kItemSpacing;
        [contextLabel release];
        
        // Example
        UILabel *exampleLabel = [[UILabel alloc] initWithFrame:CGRectMake(dx, dy, width - 2*dx, 999)];
        exampleLabel.text = sample.example;
        [self formatLabel:exampleLabel configuration:3];
        [_containerView addSubview:exampleLabel];
        dy += exampleLabel.frame.size.height;
        [exampleLabel release];
    }

    dx -= kTab;
    dy += kMargin;
    
    [_containerView setContentSize:CGSizeMake(width, dy)];
    
}

@end
