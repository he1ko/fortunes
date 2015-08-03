//
//  FortunesListViewController.h
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "BaseViewController.h"
#import "FortuneTableViewCell.h"
#import "Toolbar.h"
#import "ToolbarFortuneList.h"

@class FortuneList;

@interface FortunesListViewController : BaseViewController <UIToolbarDelegate, FortuneListToolbar, TableViewCell, MBProgressHUDDelegate, UITableViewDelegate, UITableViewDataSource, FavouriteFortune>

/*
- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
*/

@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic) BOOL clearsSelectionOnViewWillAppear; // defaults to YES. If YES, any selection is cleared in viewWillAppear:
@property (nonatomic,retain) UIRefreshControl *refreshControl;

@end
