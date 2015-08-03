

#import <MBProgressHUD/MBProgressHUD.h>
#import "BaseViewController.h"

@interface FontsViewController : UIViewController <MBProgressHUDDelegate, UITableViewDelegate, UITableViewDataSource, FontManagerNotification>

@property(nonatomic, assign) FontAppSection fontSection;

@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic) BOOL clearsSelectionOnViewWillAppear; // defaults to YES. If YES, any selection is cleared in viewWillAppear:
@property (nonatomic,retain) UIRefreshControl *refreshControl;


@end
