//
//  SingleFortune.m
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "SingleFortune.h"
#import "LabelAutoSize.h"

@implementation SingleFortune {

    Boolean cleaned;
}


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"translationDe"]) return YES;
    if ([propertyName isEqualToString: @"rating"]) return YES;

    return NO;
}


- (NSString *)cleanText {

    if(cleaned) {
        // NSLog(@"already clean!! ;-) ");
        return _text;
    }

    NSString *fortuneText = _text;

    /// remove multiple consecuting spaces
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:&error];
    fortuneText = [regex stringByReplacingMatchesInString:fortuneText options:0 range:NSMakeRange(0, [fortuneText length]) withTemplate:@" "];

    /// remove tab characters
    fortuneText = [fortuneText stringByReplacingOccurrencesOfString:@"\t" withString:@" "];

    /// remove newline characters
    fortuneText = [fortuneText stringByReplacingOccurrencesOfString:@"\n" withString:@" "];

    /// trim text
    fortuneText = [fortuneText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    _text = fortuneText;
    cleaned = YES;

    return fortuneText;
}

@end
