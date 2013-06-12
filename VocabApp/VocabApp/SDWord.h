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

@interface SDWord : NSObject <NSCoding>
{
    NSString *_word;
    NSMutableArray *_definitions;
}

@property (nonatomic, readonly) NSString *word;
@property (nonatomic, readonly) NSArray *definitions;

+ (id) createWord:(NSString *)word;
- (id) initWord:(NSString *)word;

- (void) addDefinition:(SDWordDefinition *)definition;
- (void) addDefinitionWithType:(NSString *)type andDefinition:(NSString *)definition;

@end
