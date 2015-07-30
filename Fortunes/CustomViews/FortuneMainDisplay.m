
#import "FortuneMainDisplay.h"
#import "SingleFortune.h"
#import "LabelAutoSize.h"


static float const labelMargin = 24.0f;


@interface FortuneMainDisplay ()

- (void)centerFortune;
- (LabelAutoSize *)setupFortuneLabel;
- (void)updateFortuneText;

@end


@implementation FortuneMainDisplay {

@private
    SingleFortune *fortune;
    LabelAutoSize *fortuneLabel;
}


- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune__ {

    self = [super initWithFrame:frame];

    if (self) {

        self.backgroundColor = [UIColor clearColor];
        fortune = fortune__;

        fortuneLabel = [self setupFortuneLabel];

        [self addSubview:fortuneLabel];
        [self updateFortuneText];
        [self centerFortune];
    }

    return self;
}


- (void)centerFortune {

    CGPoint center = self.center;
    center.y -= self.frame.origin.y;
    [fortuneLabel setCenter:center];
}


- (LabelAutoSize *)setupFortuneLabel {

    CGRect myFrame = self.frame;
    myFrame.origin.y = 0.0;
    CGRect labelFrame = [UIView expandFrame:myFrame by: labelMargin * -1];

    LabelAutoSize *lbl = [[LabelAutoSize alloc] initWithFrame:labelFrame resizeMode:AUTOLABEL_RESIZE_FONT];
    [lbl setFont:[[FontManager getInstance] fontForSection:FONT_APP_SECTION_MAIN_FORTUNE]];

    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.userInteractionEnabled = YES;

    return lbl;
}


- (NSString *)getFontName {

    return fortuneLabel.font.fontName;
}


- (void)setFont:(UIFont *)font {

    fortuneLabel.font = font;
    [fortuneLabel adjust];
}


- (void)updateFortune:(SingleFortune *)fortune__ {

    fortune = fortune__;
    [self updateFortuneText];
}


- (void)updateFortuneText {

    fortuneLabel.text = [fortune cleanText];
    [fortuneLabel adjust];
    [self centerFortune];
}

@end