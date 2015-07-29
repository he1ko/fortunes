

#import <MBProgressHUD/MBProgressHUD.h>
#import "BaseViewController.h"

@interface FontsViewController : BaseViewController <MBProgressHUDDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic) BOOL clearsSelectionOnViewWillAppear NS_AVAILABLE_IOS(3_2); // defaults to YES. If YES, any selection is cleared in viewWillAppear:
@property (nonatomic,retain) UIRefreshControl *refreshControl NS_AVAILABLE_IOS(6_0);


@end
