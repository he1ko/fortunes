
#import "BaseViewController.h"

@interface UIViewController (toolbar)


- (UIToolbar *)toolbar;

- (UIBarButtonItem *)toolbarItemWithImageName:(NSString *)imgName action:(SEL)action;

- (void)addTopLine:(UIColor *)color toToolbar:(UIToolbar *)tb;

@end