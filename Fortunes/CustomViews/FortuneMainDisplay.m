
#import "FortuneMainDisplay.h"
#import "SingleFortune.h"
#import "LabelAutoSize.h"


static float const labelMargin = 24.0f;


@interface FortuneMainDisplay ()

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
    }

    return self;
}


- (LabelAutoSize *)setupFortuneLabel {

    CGRect myFrame = self.frame;
    myFrame.origin.y = 0.0;
    CGRect labelFrame = [UIView expandFrame:myFrame by: labelMargin * -1];

    LabelAutoSize *lbl = [[LabelAutoSize alloc] initWithFrame:labelFrame resizeMode:AUTOLABEL_RESIZE_FONT];
    [lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]];

    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.userInteractionEnabled = YES;

    return lbl;
}


- (void)updateFortune:(SingleFortune *)fortune__ {

    fortune = fortune__;
    [self updateFortuneText];
}


- (void)updateFortuneText {

    fortuneLabel.text = [fortune cleanText];
    [fortuneLabel adjust];
}

@end