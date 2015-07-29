//
// Created by Heiko Bublitz on 25.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface UIViewController (Layout)

- (CGRect)visibleViewFrame;

- (CGRect)contentCanvas;

- (void)alignView:(UIView *)view atTopOfRect:(CGRect)frame;

- (UIView *)fullCanvasView;

- (UIButton *)defaultButtonWithText:(NSString *)buttonText;

- (UIButton *)roundedButtonWithText:(NSString *)buttonText;

- (UILabel *)simpleLabelWithText:(NSString *)labelText;

- (UILabel *)fullWidthLabelWithText:(NSString *)labelText;
@end