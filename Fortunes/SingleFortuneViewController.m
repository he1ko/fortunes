
#import "SingleFortuneViewController.h"
#import "UIViewController+NavigationBar.h"


@implementation SingleFortuneViewController {

}


- (void)viewDidLoad {

    [super viewDidLoad];

    [self.navigationItem setLeftBarButtonItem:nil];
    [self addNavBarButtonWithImageName:@"close" side:NAV_BAR_BUTTON_SIDE_LEFT];

    [self setNavigationTitle:@""];
}


- (void)leftNavigationButtonTouched {

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadFortune {

    [self setRestAnswer:self.fortune];
}



@end