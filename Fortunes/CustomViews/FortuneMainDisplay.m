#import "FortuneMainDisplay.h"
#import "SingleFortune.h"
#import "LabelAutoSize.h"


static float const labelMargin = 40.0f;


@interface FortuneMainDisplay ()

- (void)centerFortune;
- (LabelAutoSize *)setupFortuneLabel;

@end


@implementation FortuneMainDisplay {

@private
    SingleFortune *fortune;
    LabelAutoSize *fortuneLabel;
    LabelAutoSize *sourceDisplay;
}


- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune__ {

    self = [super initWithFrame:frame];

    if (self) {

        self.backgroundColor = [UIColor clearColor];

        fortuneLabel = [self setupFortuneLabel];
        [self addSubview:fortuneLabel];

        sourceDisplay = [self setupSourceLabel];
        [self addSubview:sourceDisplay];

        [self updateFortune:fortune__];
    }

    return self;
}


- (LabelAutoSize *)setupFortuneLabel {

    CGRect myFrame = self.frame;
    myFrame.origin.y = 0.0;
    CGRect labelFrame = [UIView expandFrame:myFrame by: labelMargin * -1];

    LabelAutoSize *lblFortune = [[LabelAutoSize alloc] initWithFrame:labelFrame resizeMode:AUTOLABEL_RESIZE_FONT];
    [lblFortune setFont:[[FontManager getInstance] fontForSection:FONT_APP_SECTION_MAIN_FORTUNE]];

    lblFortune.textColor = [UIColor whiteColor];
    lblFortune.backgroundColor = [UIColor clearColor];
    lblFortune.textAlignment = NSTextAlignmentCenter;
    lblFortune.userInteractionEnabled = YES;

    return lblFortune;
}


- (LabelAutoSize *)setupSourceLabel {

    CGRect lblFrame = fortuneLabel.frame;
    lblFrame.size.height = self.frame.size.height - CGRectGetMaxY(fortuneLabel.frame);
    lblFrame.origin.y = CGRectGetMaxY(fortuneLabel.frame);

    LabelAutoSize *lblSource = [[LabelAutoSize alloc] initWithFrame:lblFrame resizeMode:AUTOLABEL_RESIZE_FONT];
    lblSource.backgroundColor = [UIColor clearColor];
    lblSource.font = [UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:9.0];
    [lblSource adjust];
    [lblSource setWidth:fortuneLabel.frame.size.width];

    return lblSource;
}


- (CGFloat)getTextMargin {

    return labelMargin;
}


- (NSString *)getFontName {

    return fortuneLabel.font.fontName;
}


- (void)setFont:(UIFont *)font {

    fortuneLabel.font = font;
    [fortuneLabel adjust];
}


- (void)centerFortune {

    CGPoint center = self.center;
    center.y -= self.frame.origin.y;
    [fortuneLabel setCenter:center];
}


- (void)updateFortune:(SingleFortune *)fortune__ {

    fortune = fortune__;

    fortuneLabel.text = [fortune cleanText];
    [fortuneLabel adjust];
    [self centerFortune];

    if(fortune.source) {
        sourceDisplay.text = fortune.source;
    }
    else {
        sourceDisplay.text = NSLocalizedString(@"unknown-source", @"Unbekannte Quelle");
    }
    [sourceDisplay adjust];

    CGFloat sourceY = CGRectGetMaxY(fortuneLabel.frame);
    CGFloat sourceHeight = self.frame.size.height - sourceY;

    [sourceDisplay setY:sourceY];
    [sourceDisplay setHeight:sourceHeight];
}

@end