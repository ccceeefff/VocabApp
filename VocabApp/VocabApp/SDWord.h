//
//  SDWord.h
//  VocabApp
//
//  Created by Cef Ramirez on 6/12/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDWordDefinition : NSObject <NSCoding>
{
    NSString *_type;
    NSString *_definition;
}

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *definition;

+ (id) definitionWithType:(NSString *)type andDefinition:(NSString *)definition;
- (id) initWithType:(NSString *)type andDefinition:(NSString *)definition;

@end

@interface SDWordSampleContext : NSObject <NSCoding>
{
    NSString *_context;
    NSString *_example;
}

@property (nonatomic, copy) NSString *context;
@property (nonatomic, copy) NSString *example;

+ (id) sampleWithContext:(NSString *)context andExample:(NSString *)example;
- (id) initWithContext:(NSString *)context andExample:(NSString *)example;

@end

@interface SDWord : NSObject <NSCoding>
{
    NSString *_word;
    NSMutableArray *_definitions;
    NSMutableArray *_groups;
    NSMutableArray *_samples;
}

@property (nonatomic, readonly) NSString *word;
@property (nonatomic, readonly) NSArray *definitions;
@property (nonatomic, readonly) NSArray *groups;
@property (nonatomic, readonly) NSArray *samples;

+ (id) createWord:(NSString *)word;
- (id) initWord:(NSString *)word;

- (void) addDefinition:(SDWordDefinition *)definition;
- (void) addDefinitionWithType:(NSString *)type andDefinition:(NSString *)definition;

- (void) addGroup:(NSString *)group;

- (void) addSample:(SDWordSampleContext *)sample;
- (void) addSampleWithContext:(NSString *)context andExample:(NSString *)example;

@end
