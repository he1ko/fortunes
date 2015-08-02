//
//  SingleFortune.m
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "SingleFortune.h"
#import "NSString+Utilities.h"

@implementation SingleFortune {

    Boolean textCleaned;
    Boolean sourceCleaned;
}


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"translationDe"]) return YES;
    if ([propertyName isEqualToString: @"rating"]) return YES;
    if ([propertyName isEqualToString: @"favDelegate"]) return YES;

    return NO;
}


- (NSString *)cleanText {

    if(!textCleaned) {
        _text = [SingleFortune cleanOutput:_text];
        textCleaned = YES;
    }

    return _text;
}


- (NSString *)cleanSource {

    if(!sourceCleaned) {

        _source = [SingleFortune cleanOutput:_source];
        sourceCleaned = YES;
    }

    return _source;
}


#pragma mark -
#pragma mark private class methods

+ (NSString *)cleanOutput:(NSString *)output {

    output = [output repairMultipleSpaces];
    output = [output removeTabs];
    output = [output removeNewlineCharacters];
    output = [output trim];

    return output;
}

@end
