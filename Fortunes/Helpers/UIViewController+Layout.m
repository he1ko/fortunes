//
// Created by Heiko Bublitz on 25.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

#import "UIViewController+Layout.h"
#import "UIViewController+NavigationBar.h"

static float const canvasMargin = 20.0;
static float const controlsMargin = 20.0;
static float const defaultLabelFontSize = 15.0f;
static float const defaultControlHeight = 40.0f;

@implementation UIViewController (Layout)

#pragma mark -
#pragma mark Basic views alignment

-(CGRect)visibleViewFrame {

    /*!
        check if NavigationBar-Helper-Category exists in project
     */
    NSString *methodName = @"frameBelowTopBars";

    if ([self respondsToSelector:NSSelectorFromString(methodName)]) {

        SEL selector = NSSelectorFromString(methodName);
        CGRect returnValue;

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                [[self class] instanceMethodSignatureForSelector:selector]];

        [invocation setSelector:selector];
        [invocation setTarget:self];
        [invocation invoke];
        [invocation getReturnValue:&returnValue];

        return [self frameBelowTopBars];
    }

    return self.view.frame;
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


- (void)appendView:(UIView *)newView {

    NSArray *existingViews = [self.view subviews];
    CGFloat maxY = [self visibleViewFrame].origin.y;

    for(UIView *v in existingViews) {

        if(CGRectGetMaxY(v.frame) > maxY) {

            maxY = CGRectGetMaxY(v.frame);
        }
    }
    [newView setY:maxY + controlsMargin];
    [self.view addSubview:newView];
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
    buttonFrame.size.height = defaultControlHeight;

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