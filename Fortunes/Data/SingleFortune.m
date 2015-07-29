//
//  SingleFortune.m
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "SingleFortune.h"

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

    /*!
            remove leading and trailing " quotes "

            CHECK if there are " at the beginning AND the end!!!
            Imagine this: Then I said "Hello"
            Would result in: Then I said "Hello

            Or: "Sorry" seems to be the hardest word.
            Would result in: Sorry" seems to be the hardest word.
      */

    NSRange firstCharacterRange = NSMakeRange(0, 1);
    NSRange lastCharacterRange = NSMakeRange(fortuneText.length -1, 1);
    BOOL firstCharIsBad = NO;
    BOOL lastCharIsBad = NO;

    unichar greekAlpha = [fortuneText characterAtIndex:fortuneText.length -1];
    NSString* s = [NSString stringWithCharacters:&greekAlpha length:1];
    if([s isEqualToString:@"\""]) {
        lastCharIsBad = YES;
    }

    greekAlpha = [fortuneText characterAtIndex:0];
    s = [NSString stringWithCharacters:&greekAlpha length:1];
    if([s isEqualToString:@"\""]) {
        firstCharIsBad = YES;
    }


    if (firstCharIsBad && lastCharIsBad) {

        fortuneText = [fortuneText stringByReplacingCharactersInRange:lastCharacterRange withString:@""];
        fortuneText = [fortuneText stringByReplacingCharactersInRange:firstCharacterRange withString:@""];
    }

    _text = fortuneText;
    cleaned = YES;

    return fortuneText;
}

@end
