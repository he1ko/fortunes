#import "FortuneMainDisplay.h"
#import "SingleFortune.h"
#import "LabelAutoSize.h"
#import "NSString+Utilities.h"


static float const labelMargin = 40.0f;


@interface FortuneMainDisplay ()

@end


@implementation FortuneMainDisplay {

@private
    SingleFortune *fortune;
    LabelAutoSize *fortuneLabel;
    UILabel *sourceLabel;
    UIView *separatorLine;
}


- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune__ {

    self = [super initWithFrame:frame];

    if (self) {

        self.backgroundColor = [UIColor clearColor];

        fortuneLabel = [self fortuneLabel];
        [self addSubview:fortuneLabel];

        sourceLabel = [self sourceLabel];
        [self addSubview:sourceLabel];

        separatorLine = [self separatorLine];
        [self addSubview:separatorLine];

        [self updateFortune:fortune__];
    }

    return self;
}


- (LabelAutoSize *)fortuneLabel {

    LabelAutoSize *lblFortune = [[LabelAutoSize alloc] initWithFrame:[self frameInsideMargins] resizeMode:AUTOLABEL_RESIZE_FONT];

    [lblFortune setFont:[[FontManager getInstance] fontForSection:FONT_APP_SECTION_MAIN_FORTUNE]];
    lblFortune.textColor = [UIColor whiteColor];
    lblFortune.backgroundColor = [UIColor clearColor];
    lblFortune.textAlignment = NSTextAlignmentCenter;
    lblFortune.userInteractionEnabled = YES;

    return lblFortune;
}


- (UILabel *)sourceLabel {

    UILabel *lblSource = [[UILabel alloc] initWithFrame:[self frameInsideMargins]];
    lblSource.backgroundColor = [UIColor clearColor];
    lblSource.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    lblSource.font = [UIFont fontWithName:@"Georgia-Italic" size:11.0];
    lblSource.textAlignment = NSTextAlignmentCenter;
    lblSource.numberOfLines = 0;
    lblSource.userInteractionEnabled = NO;

    return lblSource;
}


- (UIView *)separatorLine {

    UIView *sepLine = [[UIView alloc] initWithFrame:[self frameInsideMargins]];
    sepLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    [sepLine setHeight:1.0];

    return sepLine;
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

    if([NSString isEmpty:fortune.source]) {

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

    [separatorLine setY:(CGRectGetMaxY(fortuneLabel.frame) + [sourceLabel y])/2];
}

@end