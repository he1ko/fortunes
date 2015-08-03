


typedef NS_ENUM(NSInteger, NavBarButtonSide) {

    NAV_BAR_BUTTON_SIDE_LEFT,
    NAV_BAR_BUTTON_SIDE_RIGHT
};



@interface UIViewController (NavigationBar)

- (CGRect)frameBelowTopBars;


- (void)addNavBarButtonWithText:(NSString *)text side:(NavBarButtonSide)side;

- (void)addNavBarButtonWithImageName:(NSString *)imgName side:(NavBarButtonSide)side;

- (void)removeNavigationButtonOnSide:(NavBarButtonSide)side;

- (void)navigationButtonTouched:(id)sender;

- (void)setNavigationTitle:(NSString *)title;

- (void)leftNavigationButtonTouched;

- (void)rightNavigationButtonTouched;
@end