

#import "FortunesBySourceViewController.h"
#import "UIViewController+NavigationBar.h"

@interface FortunesBySourceViewController ()

@end

@implementation FortunesBySourceViewController


- (void)viewDidLoad {

    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self setNavigationTitle:NSLocalizedString(@"fortunesBySource", @"fortunesBySource-Header")];
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

@end
