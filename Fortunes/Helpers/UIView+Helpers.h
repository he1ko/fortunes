//
//  UIView+Helpers.h
//  fgPrototyp
//
//  Created by Heiko Bublitz on 28.08.14.
//  Copyright (c) 2014 Fast Gesund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helpers)

- (UIViewController*)viewController;
- (void)moveYBy:(CGFloat)deltaY;

- (void)expandWidthBy:(CGFloat)deltaWidth;

- (void)moveXBy:(CGFloat)deltaX;

@property float x;
@property float y;
@property float width;
@property float height;

- (void)expandHeightBy:(CGFloat)deltaHeight;

-(float) x;
-(void) setX:(float) newX;
-(float) y;
-(void) setY:(float) newY;
-(float) width;
-(void) setWidth:(float) newWidth;
-(float) height;
-(void) setHeight:(float) newHeight;
@end
