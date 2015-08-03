#import <MBProgressHUD/MBProgressHUD.h>
#import "UIViewController+Alert.h"
#import "BaseViewController.h"


@implementation UIViewController (Alert)


- (void)alertWithTitle:(NSString *)title subtitle:(NSString *)subtitle duration:(CGFloat)duration {

    [self hideAlert];

    MBProgressHUD *alert = [self getAlert];

    alert.mode = MBProgressHUDModeText;
    alert.labelText = title;
    alert.detailsLabelText = subtitle;

    [self performSelector:@selector(fadeAlert) withObject:nil afterDelay:duration];
}

- (void)alertLoadingIndicator {

    [self hideAlert];
    [self getAlert];
}

- (void)hideAlert {

    [self hideHudAnimated:NO];
}

- (void)fadeAlert {

    [self hideHudAnimated:YES];
}


#pragma mark -
#pragma mark Private


- (MBProgressHUD *)getAlert {

    BaseViewController *vcBase = (BaseViewController *)self;
    MBProgressHUD *alert = [MBProgressHUD showHUDAddedTo:vcBase.view animated:YES];
    [alert setYOffset:[vcBase getAlertOffsetY]];

    return alert;
}

- (void)hideHudAnimated:(BOOL)animated {

    [MBProgressHUD hideHUDForView:self.view animated:animated];
}


@end