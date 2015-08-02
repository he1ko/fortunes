
#import "LabelAutoSize.h"

static CGFloat const maximumFontSize = 100.0f;

typedef NS_ENUM(NSInteger, AutoLabelErrorType) {

    AUTOLABEL_NO_FONT_SET,
    AUTOLABEL_NO_TEXT_SET
};


@implementation LabelAutoSize {

@private
    AutoLabelResizeMode resizeMode;
    CGFloat maximumHeight;
    CGFloat initialWidth;
    BOOL fontSet;
    BOOL textSet;
}


- (id)initWithFrame:(CGRect)frame resizeMode:(AutoLabelResizeMode)mode {

    self = [super initWithFrame:frame];

    if (self) {

        [self setDefaults];

        resizeMode = mode;
        maximumHeight = frame.size.height;
        initialWidth = frame.size.width;
    }
    return self;
}


- (void)setDefaults {

    resizeMode = AUTOLABEL_RESIZE_HEIGHT;
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
}


- (void)adjust {

    NSArray *errors = [self checkPreConditions];

    if([errors count] > 0) {
        [self respondToErrors:errors];
    }

    if(resizeMode == AUTOLABEL_RESIZE_HEIGHT) {
        [self resizeHeight];
    }

    else if(resizeMode == AUTOLABEL_RESIZE_FONT) {
        [self resizeFont];
    }
}


- (void) setFont:(UIFont *)fnt {

    fontSet = YES;
    [super setFont:fnt];
}



- (void)setText:(NSString *)txt {

    textSet = YES;
    [super setText:txt];
}


- (void)resizeHeight {

    [self sizeToFit];
    [self setWidth:initialWidth];
}


- (void)resizeFont {

    [self setFontSize:maximumFontSize];
    [self resizeHeight];

    while ((self.frame.size.height > maximumHeight)) {

        [self decreaseFontSizeByOne];
        [self resizeHeight];
    }

    if(![self isFontTooLargeForWordlength]) {

        return;
    }

    /*!
        Font size is too large and does break single words.
        Go on decreasing font size
    */

    while ([self isFontTooLargeForWordlength]) {

        [self decreaseFontSizeByOne];
        [self resizeHeight];
    }
}


- (void) decreaseFontSizeByOne {

    [self setFontSize:(CGFloat)(self.font.pointSize - 1.0)];
}


- (void)setFontSize:(CGFloat)size {

    NSString *fontName = self.font.fontName;
    self.font = [UIFont fontWithName:fontName size:size];
}


- (NSArray *)checkPreConditions {

    NSMutableArray *errors = [[NSMutableArray alloc] init];

    /// Text must be set in any way!
    if(!textSet) {
        [errors addObject:@(AUTOLABEL_NO_TEXT_SET)];
    }

    if(resizeMode == AUTOLABEL_RESIZE_HEIGHT && !fontSet) {
        [errors addObject:@(AUTOLABEL_NO_FONT_SET)];
    }

    return errors;
}


- (void)respondToErrors:(NSArray *)errors {

    for(NSNumber *errNum in errors) {

        NSInteger err = (NSInteger) errNum;

        if(err == AUTOLABEL_NO_TEXT_SET) {
            [NSException raise:@"AutoLabel without text" format:@"AutoLabel cannot adjust without content."];
        }

        if(err == AUTOLABEL_NO_FONT_SET) {
            [NSException raise:@"AutoLabel without font size" format:@"AutoLabel cannot adjust its height before its font size is not set."];
        }
    }
}


/*!
    If font is too large, single words will be broken in two lines, which is not wanted.
    Check one by one word if it fits in this UILabel
 */
- (BOOL)isFontTooLargeForWordlength {

    NSArray *words = [self.text componentsSeparatedByString:@" "];

    for(NSString *word in words) {

        if([self isWordTooLong:word]) {
            return YES;
        }
    }
    return NO;
}


/*!
    check if the views width is sufficient for a single word with the labels font
 */
- (BOOL)isWordTooLong:(NSString *)word {

    CGFloat wordWidth = [self widthOfString:word];
    CGFloat myWidth = self.frame.size.width;

    return wordWidth > myWidth;
}


- (CGFloat)widthOfString:(NSString *)string {

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil];
    CGFloat h = [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
    return h;
}

@end
