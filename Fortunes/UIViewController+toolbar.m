
#import "UIViewController+toolbar.h"

static float const defaultHeight = 48.0;

@implementation UIViewController (toolbar)


- (UIToolbar *)toolbar {

    CGRect toolbarFrame = [self toolbarFrame];
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:toolbarFrame];

    tb.translucent = NO;
    tb.opaque = YES;
    tb.barTintColor = [UIColor presetHighlight];
    tb.clipsToBounds = YES;

    return tb;
}


- (UIBarButtonItem *)toolbarItemWithImageName:(NSString *)imgName action:(SEL)action {

    UIButton *imageItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageItem setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [imageItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [imageItem setFrame:CGRectMake(0.0, 0.0, defaultHeight, defaultHeight)];

    return [[UIBarButtonItem alloc] initWithCustomView:imageItem];
}


- (void) addTopLine:(UIColor*)color toToolbar:(UIToolbar *)tb {

    UIView *topLine = [[UIView alloc] initWithFrame:self.view.frame];
    topLine.backgroundColor = color;
    [topLine setHeight:1.0];
    [topLine setY:0.0];
    [tb addSubview:topLine];
}


- (CGRect)toolbarFrame {

    return CGRectMake(0, (CGFloat) ([self.view height] - defaultHeight), [self.view width], defaultHeight);
}


@end