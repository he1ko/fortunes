

#import "FortunesBySourceViewController.h"

@interface FortunesBySourceViewController ()

@end

@implementation FortunesBySourceViewController


- (void)viewDidLoad {

    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.navigationItem setTitle:NSLocalizedString(@"fortunesBySource", @"fortunesBySource-Header")];
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

@end
