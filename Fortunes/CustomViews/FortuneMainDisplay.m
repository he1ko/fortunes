#import "FortuneMainDisplay.h"
#import "SingleFortune.h"
#import "LabelAutoSize.h"


static float const labelMargin = 40.0f;


@interface FortuneMainDisplay ()

@end


@implementation FortuneMainDisplay {

@private
    SingleFortune *fortune;
    LabelAutoSize *fortuneLabel;
    UILabel *sourceLabel;
}


- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune__ {

    self = [super initWithFrame:frame];

    if (self) {

        self.backgroundColor = [UIColor clearColor];

        fortuneLabel = [self setupFortuneLabel];
        [self addSubview:fortuneLabel];

        sourceLabel = [self setupSourceLabel];
        [self addSubview:sourceLabel];

        [self updateFortune:fortune__];
    }

    return self;
}


- (LabelAutoSize *)setupFortuneLabel {

    LabelAutoSize *lblFortune = [[LabelAutoSize alloc] initWithFrame:[self frameInsideMargins] resizeMode:AUTOLABEL_RESIZE_FONT];

    [lblFortune setFont:[[FontManager getInstance] fontForSection:FONT_APP_SECTION_MAIN_FORTUNE]];
    lblFortune.textColor = [UIColor whiteColor];
    lblFortune.backgroundColor = [UIColor clearColor];
    lblFortune.textAlignment = NSTextAlignmentCenter;
    lblFortune.userInteractionEnabled = YES;

    return lblFortune;
}


- (UILabel *)setupSourceLabel {

    UILabel *lblSource = [[UILabel alloc] initWithFrame:[self frameInsideMargins]];
    lblSource.backgroundColor = [UIColor clearColor];
    lblSource.font = [UIFont fontWithName:@"Georgia-Italic" size:11.0];
    lblSource.textAlignment = NSTextAlignmentCenter;
    lblSource.numberOfLines = 0;
    lblSource.userInteractionEnabled = NO;

    return lblSource;
}


- (CGFloat)getTextMargin {

    return labelMargin;
}

- (CGRect)frameInsideMargins {

    CGRect canvasFrame = [UIView expandFrame:self.frame by:labelMargin * -1];
    canvasFrame.origin.y = 0.0; /// self.frame might have an Y-Offset...
    return canvasFrame;
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

    /// Update fortune text

    fortuneLabel.text = [fortune cleanText];

    /// Update fortune source

    if([@"" isEqualToString:fortune.source]) {

        sourceLabel.text = NSLocalizedString(@"unknown-source", @"Unbekannte Quelle");
        sourceLabel.alpha = 0.5;
    }
    else {
        sourceLabel.text = [fortune cleanSource];
        sourceLabel.alpha = 1.0;
    }

    [self adjustLabelPositions];
}


- (void)adjustLabelPositions {

    [fortuneLabel adjust];

    [sourceLabel sizeToFit];
    [sourceLabel setWidth:[fortuneLabel width]];

    /// distribute label vertically

    CGFloat totalYSpace = [self height] - [fortuneLabel height] - [sourceLabel height];

    /// align source to bottom with ySpace / 3
    CGFloat sourceY = [self height] - totalYSpace /3 - [sourceLabel height];
    [sourceLabel setY:sourceY];

    /// Y-center fortune inside left space
    CGFloat fortuneCenterY = [sourceLabel y] /2;
    CGFloat fortuneDeltaY = fortuneCenterY - fortuneLabel.center.y;
    [fortuneLabel moveYBy:fortuneDeltaY];
}

@end