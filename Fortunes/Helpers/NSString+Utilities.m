
#import "NSString+Utilities.h"


@implementation NSString (Utilities)


+ (BOOL)isEmpty:(NSString *)s {

    return (!s || [s isEqualToString:@""]);
}


/*! @discussion replace multiple consecuting spaces
  by single space characters
*/
- (NSString *)repairMultipleSpaces {

    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:&error];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@" "];
}

- (NSString *)removeTabs {

    return [self stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
}

- (NSString *)removeNewlineCharacters {

    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
}

- (NSString *)trim {

    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/*!
    @discussion remove leading and trailing "quotes"

    CHECK if there are " at the beginning AND the end!!!
    Imagine this: Then I said "Hello"
    Would result in: Then I said "Hello

    Or: "Sorry" seems to be the hardest word.
    Would result in: Sorry" seems to be the hardest word.
*/
- (NSString *)removeLeadingAndTrailingQuotes {

    NSRange firstCharacterRange = NSMakeRange(0, 1);
    NSRange lastCharacterRange = NSMakeRange(self.length -1, 1);
    BOOL firstCharIsBad = NO;
    BOOL lastCharIsBad = NO;

    unichar greekAlpha = [self characterAtIndex:self.length -1];
    NSString* s = [NSString stringWithCharacters:&greekAlpha length:1];
    if([s isEqualToString:@"\""]) {
        lastCharIsBad = YES;
    }

    greekAlpha = [self characterAtIndex:0];
    s = [NSString stringWithCharacters:&greekAlpha length:1];
    if([s isEqualToString:@"\""]) {
        firstCharIsBad = YES;
    }

    if (firstCharIsBad && lastCharIsBad) {

        NSString *cleanedString;
        cleanedString = [self stringByReplacingCharactersInRange:lastCharacterRange withString:@""];
        cleanedString = [cleanedString stringByReplacingCharactersInRange:firstCharacterRange withString:@""];
        return cleanedString;
    }
    return self;
}

@end