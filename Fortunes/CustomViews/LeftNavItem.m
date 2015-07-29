//
//  LeftNavItem.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "LeftNavItem.h"

@implementation LeftNavItem

- (id)initWithFrame:(CGRect)frame andTag:(NSInteger)tag andText:(NSString *)text {

    self = [super initWithFrame:frame];

    if (self) {

        self.userInteractionEnabled = YES;

        _text = text;
        [self setTag:tag];
        [self setupSubviews];
    }

    return self;
}


- (void)setupSubviews {

    /// Textlabel with text from initialization

    UILabel *lblText = [[UILabel alloc] initWithFrame:self.frame];
    [lblText setY:marginY];
    [lblText setHeight:self.frame.size.height - 2 * marginY];
    [lblText setX:marginX];
    [lblText setWidth:self.frame.size.width - 2 * marginX];

    lblText.text = _text;
    lblText.textColor = [UIColor whiteColor];

    [self addSubview:lblText];

    /// thin line at the bottom

    UIView *thinLine = [[UIView alloc] initWithFrame:self.frame];
    thinLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    [thinLine setHeight:0.6f];
    [thinLine setY:self.frame.size.height - 0.6f];

    [self addSubview:thinLine];
}


- (void)setSelected:(BOOL)selected {

    if(selected) {
        self.backgroundColor = [UIColor presetItemSelected];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
