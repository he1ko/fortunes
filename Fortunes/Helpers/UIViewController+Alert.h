
@interface UIViewController (Alert)


- (void)alertWithTitle:(NSString *)title subtitle:(NSString *)subtitle duration:(CGFloat)duration;

- (void)alertLoadingIndicator;

- (void)fadeAlert;

- (void)hideAlert;

- (void)hideHudAnimated:(BOOL)animated;
@end