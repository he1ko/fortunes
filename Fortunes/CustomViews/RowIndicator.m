//
//  RowIndicator.m
//  Fortunes
//
//  Created by Heiko Bublitz on 28.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "RowIndicator.h"

static float const imageWidth = 80.0f;
static float const imageHeight = 48.0f;
static float const topMargin = 16.0f;
static float const rightNumberMargin = 10.0f;

static NSString *imageName = @"rowIndicator";
static NSString *numberFontName = @"DINAlternate-Bold";
static float const numberFontSize = 22.0f;

@implementation RowIndicator {

@private
    UILabel *lblNumber;
    CGFloat minXPos;
}


- (id)initInFrame:(CGRect)parentFrame {

    CGFloat left = parentFrame.size.width - imageWidth;
    CGFloat top = parentFrame.origin.y + topMargin;

    self = [super initWithFrame:CGRectMake(left, top, imageWidth, imageHeight)];

    if (self) {

        minXPos = self.frame.origin.x;

        /// place me outside parent ... to slide in, if needed:
        [self setX:minXPos + [self width]];
        [self setImage:[UIImage imageNamed:imageName]];
        [self addLabel];
        self.hidden = YES;
    }
    return self;
}


- (void)addLabel {

    CGRect numberFrame = CGRectMake(24.0f, 10.0f, 54.0f, 26.0f);

    lblNumber = [[UILabel alloc] initWithFrame:numberFrame];
    lblNumber.font = [UIFont fontWithName:numberFontName size:numberFontSize];
    lblNumber.textAlignment = NSTextAlignmentLeft;
    lblNumber.backgroundColor = [UIColor clearColor];
    lblNumber.textColor = [UIColor darkGrayColor];
    lblNumber.text = @"";
    lblNumber.hidden = YES;

    [self addSubview:lblNumber];
    [self adjustXToNumber];
}


- (void) setRowNumber:(int)rowNum {

    NSString *rowNumText = [NSString stringWithFormat:@"%d", rowNum];

    NSUInteger digitsBefore = lblNumber.text.length;
    NSUInteger digitsAfter = rowNumText.length;

    lblNumber.text = rowNumText;
    [lblNumber sizeToFit];

    if(digitsAfter != digitsBefore) {

        lblNumber.hidden = YES;
        [self adjustXToNumber];
    }
}


- (void)adjustXToNumber {

    CGFloat maxSpaceForLabel = self.frame.size.width - lblNumber.frame.origin.x;
    CGFloat currentLabelWidth = lblNumber.frame.size.width;

    CGRect frTarget = self.frame;
    frTarget.origin.x = minXPos + maxSpaceForLabel - currentLabelWidth - rightNumberMargin;

    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{

                         self.frame = frTarget;
                     }
                     completion:^(BOOL finished) {

                         lblNumber.hidden = NO;
                     }
    ];
}


- (void) show:(BOOL)visible {

    CGFloat finalAlpha;

    if(visible) {

        if(!self.hidden && self.alpha > 0.5) return;

        finalAlpha = 0.7;
        [self setAlpha:0.0];
        [self setHidden:NO];
    }
    else {
        finalAlpha = 0.0;
    }

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self setAlpha:finalAlpha];
                     }
                     completion:^(BOOL finished) {
                         if(!visible) {
                             self.hidden = YES;
                         }
                     }
    ];
}


- (void)setYPos:(CGFloat)yPos {

    [self setY:yPos];
}

@end
