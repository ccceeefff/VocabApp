//
//  SDWord.m
//  VocabApp
//
//  Created by Cef Ramirez on 6/12/13.
//  Copyright (c) 2013 SpiderDog Studios. All rights reserved.
//

#import "SDWord.h"

#define SDWordTypeKey @"type"
#define SDWordDefinitionKey @"definition"

@implementation SDWordDefinition

@synthesize type = _type;
@synthesize definition = _definition;

+ (id) definitionWithType:(NSString *)type andDefinition:(NSString *)definition
{
    return [[[SDWordDefinition alloc] initWithType:type andDefinition:definition] autorelease];
}

- (id) initWithType:(NSString *)type andDefinition:(NSString *)definition
{
    self = [self init];
    if(self != nil){
        
        _type = [type copy];
        _definition = [definition copy];
        
    }
    return self;
}

- (void) dealloc
{
    self.type = nil;
    self.definition = nil;
    [super dealloc];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if(self != nil){
        
        _type = [[aDecoder decodeObjectForKey:SDWordTypeKey] copy];
        _definition  = [[aDecoder decodeObjectForKey:SDWordDefinitionKey] copy];
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_type forKey:SDWordTypeKey];
    [aCoder encodeObject:_definition forKey:SDWordDefinitionKey];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"{ %@ ; %@ }", self.type, self.definition];
}

@end


#define SDWordContextKey @"context"
#define SDWordExampleKey @"example"

@implementation SDWordSampleContext

@synthesize context = _context;
@synthesize example = _example;

- (id) init
{
    self = [super init];
    if(self != nil){
        _context = nil;
        _example = nil;
    }
    return self;
}

- (void) dealloc
{
    [_context release];
    [_example release];
    [super dealloc];
}

- (id) initWithContext:(NSString *)context andExample:(NSString *)example
{
    self = [self init];
    if(self != nil){
        _context = [context copy];
        _example = [example copy];
    }
    return self;
}

+ (id) sampleWithContext:(NSString *)context andExample:(NSString *)example
{
    return [[[SDWordSampleContext alloc] initWithContext:context andExample:example] autorelease];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if(self != nil){
        
        _context = [[aDecoder decodeObjectForKey:SDWordContextKey] copy];
        _example  = [[aDecoder decodeObjectForKey:SDWordExampleKey] copy];
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_context forKey:SDWordContextKey];
    [aCoder encodeObject:_example forKey:SDWordExampleKey];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"{ %@ ; %@ }", self.context, self.example];
}

@end

#define SDWordKey @"word"
#define SDWordDefinitionsKey @"definitions"
#define SDWordGroupsKey @"groups"
#define SDWordSamplesKey @"samples"

@interface SDWord ()

@property (nonatomic, copy) NSString *word;

@end

@implementation SDWord

@synthesize word = _word;
@synthesize definitions = _definitions;
@synthesize groups = _groups;
@synthesize samples = _samples;

- (id) init
{
    self = [super init];
    if(self != nil){
        
        _word = nil;
        _definitions = [[NSMutableArray alloc] init];
        _groups = [[NSMutableArray alloc] init];
        _samples = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void) dealloc
{
    [_word release];
    [_definitions release];
    [_groups release];
    [_samples release];
    [super dealloc];
}

+ (id) createWord:(NSString *)word
{
    return [[[SDWord alloc] initWord:word] autorelease];
}

- (id) initWord:(NSString *)word
{
    self = [self init];
    if(self != nil){
        
        _word = [word copy];
        
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if(self != nil){
        
        _word = [[aDecoder decodeObjectForKey:SDWordKey] copy];
        [_definitions addObjectsFromArray:[aDecoder decodeObjectForKey:SDWordDefinitionsKey]];
        [_groups addObjectsFromArray:[aDecoder decodeObjectForKey:SDWordGroupsKey]];
        [_samples addObjectsFromArray:[aDecoder decodeObjectForKey:SDWordSamplesKey]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_word forKey:SDWordKey];
    [aCoder encodeObject:_definitions forKey:SDWordDefinitionsKey];
    [aCoder encodeObject:_groups forKey:SDWordGroupsKey];
    [aCoder encodeObject:_samples forKey:SDWordSamplesKey];
}

- (void) addDefinition:(SDWordDefinition *)definition
{
    [_definitions addObject:definition];
}

- (void) addDefinitionWithType:(NSString *)type andDefinition:(NSString *)definition
{
    [self addDefinition:[SDWordDefinition definitionWithType:type andDefinition:definition]];
}

- (void) addGroup:(NSString *)group
{
    if(![_groups containsObject:group])
        [_groups addObject:group];
}

- (void) addSample:(SDWordSampleContext *)sample
{
    [_samples addObject:sample];
}

- (void) addSampleWithContext:(NSString *)context andExample:(NSString *)example
{
    [self addSample:[SDWordSampleContext sampleWithContext:context andExample:example]];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@: < %@ : definitions: { %@ }, groups: { %@ }, samples: { %@ } >", [super description], self.word, self.definitions, self.groups, self.samples];
}

@end
