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


#define SDWordKey @"word"
#define SDWordDefinitionsKey @"definitions"

@interface SDWord ()

@property (nonatomic, copy) NSString *word;

@end

@implementation SDWord

@synthesize word = _word;
@synthesize definitions = _definitions;

- (id) init
{
    self = [super init];
    if(self != nil){
        
        _word = nil;
        _definitions = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void) dealloc
{
    [_word release];
    [_definitions release];
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
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_word forKey:SDWordKey];
    [aCoder encodeObject:_definitions forKey:SDWordDefinitionsKey];
}

- (void) addDefinition:(SDWordDefinition *)definition
{
    [_definitions addObject:definition];
}

- (void) addDefinitionWithType:(NSString *)type andDefinition:(NSString *)definition
{
    [self addDefinition:[SDWordDefinition definitionWithType:type andDefinition:definition]];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@: < %@ : { %@ } >", [super description], self.word, self.definitions];
}

@end
