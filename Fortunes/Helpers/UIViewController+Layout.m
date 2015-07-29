//
// Created by Heiko Bublitz on 25.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

#import "UIViewController+Layout.h"

static float const canvasMargin = 20.0;


@implementation UIViewController (Layout)

#pragma mark -
#pragma mark Basic views alignment

-(CGRect)visibleViewFrame {

    CGRect frVisible = self.view.frame;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat topBarsHeight = navBarHeight + statusBarHeight;

    frVisible.origin.y += topBarsHeight;
    frVisible.size.height -= topBarsHeight;

    return frVisible;
}


- (CGRect)contentCanvas {

    CGRect canvas = [self visibleViewFrame];

    canvas.origin.x += canvasMargin;
    canvas.size.width -= canvasMargin * 2;

    canvas.origin.y += canvasMargin;
    canvas.size.height -= canvasMargin * 2;

    return canvas;
}


-(void)alignView:(UIView *)view atTopOfRect:(CGRect)frame {

    view.center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    [view setY:frame.origin.y];
}

#pragma mark -
#pragma mark basic views

- (UIView *)fullCanvasView {

    return [[UIView alloc] initWithFrame:[self contentCanvas]];
}

#pragma mark -
#pragma mark Buttons

- (UIButton *)defaultButtonWithText:(NSString *)buttonText {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:buttonText forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];

    CGRect buttonFrame = [self contentCanvas];
    buttonFrame.size.height = 40.0;

    [button setFrame:buttonFrame];

    return button;
}


- (UIButton *)roundedButtonWithText:(NSString *)buttonText {

    UIButton *button = [self defaultButtonWithText:buttonText];

    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor whiteColor] CGColor];

    return button;
}


#pragma mark -
#pragma mark Labels

static float defaultLabelFontSize = 15.0f;

- (UILabel*)simpleLabelWithText:(NSString *)labelText {

    CGRect labelFrame = [self contentCanvas];
    labelFrame.size.height = (CGFloat) (defaultLabelFontSize * 1.5);

    UILabel * lbl = [[UILabel alloc] initWithFrame:labelFrame];
    lbl.font = [UIFont fontWithName:@"AvenirNext-Medium" size:defaultLabelFontSize];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.text = labelText;

    return lbl;
}



- (UILabel*)fullWidthLabelWithText:(NSString *)labelText {

    CGRect visibleFrame = [self visibleViewFrame];

    UILabel * lbl = [self simpleLabelWithText:labelText];
    [lbl setX:visibleFrame.origin.x];
    [lbl setWidth:visibleFrame.size.width];

    return lbl;
}


@end