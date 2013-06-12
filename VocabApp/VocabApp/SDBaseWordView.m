//
//  SDBaseWordView.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/12/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "SDBaseWordView.h"

@implementation SDBaseWordView

@synthesize word = _word;

- (void) setWord:(SDWord *)word
{
    if(word != _word){
        [_word release];
        _word = [word retain];
    }
    [self setNeedsLayout];
}

- (void) dealloc
{
    [_word release];
    [super dealloc];
}

@end
