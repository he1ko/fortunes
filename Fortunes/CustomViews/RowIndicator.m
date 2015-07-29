//
//  RowIndicator.m
//  Fortunes
//
//  Created by Heiko Bublitz on 28.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "RowIndicator.h"

@implementation RowIndicator {

@private
    UILabel *lblNumber;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {
        [self addLabel];
    }

    return self;
}


- (void)addLabel {

    CGRect numberFrame = self.frame;
    numberFrame.origin = CGPointMake(0.0, 0.0);

    lblNumber = [[UILabel alloc] initWithFrame:numberFrame];
    lblNumber.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:22.0];
    lblNumber.textAlignment = NSTextAlignmentCenter;
    lblNumber.backgroundColor = [UIColor darkGrayColor];
    lblNumber.textColor = [UIColor whiteColor];

    [self addSubview:lblNumber];
}

- (void) setRowNumber:(int)rowNum {

    lblNumber.text = [NSString stringWithFormat:@"%d", rowNum];
}

- (void)setYPos:(CGFloat)yPos {

    CGRect frTemp = self.frame;
    frTemp.origin.y = yPos;
    self.frame = frTemp;
}

@end
