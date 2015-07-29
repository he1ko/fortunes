//
//  UIView+Helpers.m
//  fgPrototyp
//
//  Created by Heiko Bublitz on 28.08.14.
//  Copyright (c) 2014 Fast Gesund. All rights reserved.
//

@implementation UIView (Helpers)

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)moveXBy:(CGFloat)deltaX
{
    [self setX:self.frame.origin.y + deltaX];
}

- (void)moveYBy:(CGFloat)deltaY
{
    [self setY:self.frame.origin.y + deltaY];
}

- (void)expandWidthBy:(CGFloat)deltaWidth
{
    [self setWidth:self.frame.size.width + deltaWidth];
}

- (void)expandHeightBy:(CGFloat)deltaHeight
{
    [self setHeight:self.frame.size.height + deltaHeight];
}


+ (CGRect)expandFrame:(CGRect)frame by:(CGFloat)padding {

    frame.origin.x -= padding;
    frame.origin.y -= padding;
    frame.size.width += padding *2;
    frame.size.height += padding *2;

    return frame;
}


-(float) x {
    return self.frame.origin.x;
}

-(void) setX:(float) newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

-(float) y {
    return self.frame.origin.y;
}

-(void) setY:(float) newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

-(float) width {
    return self.frame.size.width;
}

-(void) setWidth:(float) newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

-(float) height {
    return self.frame.size.height;
}

-(void) setHeight:(float) newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}



@end
