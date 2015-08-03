
#import "UIViewController+NavigationBar.h"


@interface UIViewController ()

@end

@implementation UIViewController (NavigationBar)


-(CGRect)frameBelowTopBars {

    CGRect frVisible = self.view.frame;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat topBarsHeight = navBarHeight + statusBarHeight;

    frVisible.origin.y += topBarsHeight;
    frVisible.size.height -= topBarsHeight;

    return frVisible;
}


- (void)setupNavBarAppearance {

    self.navigationController.navigationBar.barStyle  = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor presetItemBGOthers];
}


#pragma mark -
#pragma mark Nav Bar Buttons Public

-(void)addNavBarButtonWithText:(NSString *)text side:(NavBarButtonSide)side {

    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:self action:@selector(navigationButtonTouched:)];
    [button setTag:side];

    [self addNavigationBarButton:button side:side];
}


-(void)addNavBarButtonWithImageName:(NSString *)imgName side:(NavBarButtonSide)side {

    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imgName] style:UIBarButtonItemStylePlain target:self action:@selector(navigationButtonTouched:)];
    [button setTag:side];

    [self addNavigationBarButton:button side:side];
}


- (void)removeNavigationButtonOnSide:(NavBarButtonSide)side {

    if(side == NAV_BAR_BUTTON_SIDE_LEFT) {
        [self.navigationItem setLeftBarButtonItem:nil animated:NO];
    }
    else {
        [self.navigationItem setRightBarButtonItem:nil animated:NO];
    }
}


- (void)navigationButtonTouched:(id)sender {

    if([sender tag] == NAV_BAR_BUTTON_SIDE_LEFT) {
        [self leftNavigationButtonTouched];
    }
    else {
        [self rightNavigationButtonTouched];
    }
}


- (void)setNavigationTitle:(NSString *)title {

    if(![self.navigationItem.titleView isKindOfClass:[UILabel class]]) {

        [self createNavTitleLabel];
    }

    UILabel *navTitleView = (UILabel *)self.navigationItem.titleView;
    [navTitleView setText:title];
    [navTitleView sizeToFit];
}

#pragma mark -
#pragma mark public methods to be overridden in implementation


- (void)leftNavigationButtonTouched {

    // NSLog(@"LINKS!");
}

- (void)rightNavigationButtonTouched {

    // NSLog(@"RECHTS!");
}


#pragma mark -
#pragma mark private methods

-(void)addNavigationBarButton:(UIBarButtonItem *)button side:(NavBarButtonSide)side {

    if(side == NAV_BAR_BUTTON_SIDE_LEFT) {
        [self.navigationItem setLeftBarButtonItem:button animated:YES];
    }
    else {
        [self.navigationItem setRightBarButtonItem:button animated:YES];
    }
}


- (void)createNavTitleLabel {

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.navigationItem setTitleView:titleLabel];
}

@end