//
//  FortunesListViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "FortunesListViewController.h"
#import "UserSettings.h"
#import "FortuneTableViewCell.h"
#import "FortuneDetailViewController.h"
#import "UIViewController+Layout.h"
#import "RowIndicator.h"

static NSString *cellReuseIdentifier = @"fortuneCell";

@implementation FortunesListViewController {

@private
    FortuneList *fortuneList;
    FortuneTableViewCell *heightTestCell;

    NSArray *fortuneCells;
    MBProgressHUD *HUD;
    NSIndexPath *lastSelectionPath;
    RowIndicator *rowIndicator;

    UIFont *fortuneFont;
    UIFont *sourceFont;

    int topRowIdx;
}



#pragma mark -
#pragma mark ViewController Lifecycle


- (void)viewDidLoad {

    [super viewDidLoad];

    if(IS_OS_7_OR_LATER){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    CGRect tableViewFrame = self.view.frame;

    fortuneFont = [self fortuneFontFromUserSettings];
    sourceFont = [self sourceFontFromUserSettings];

    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIEdgeInsets contentPadding = _tableView.contentInset;
    contentPadding.top = 64.0;
    _tableView.contentInset = contentPadding;

    self.view = _tableView;

    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.navigationItem setTitle:NSLocalizedString(@"listOfFortunes", @"AllFortunes header text")];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    if(lastSelectionPath != nil) {
        [_tableView deselectRowAtIndexPath:lastSelectionPath animated:YES];
    }

    BOOL fortuneFontModified = NO;
    BOOL sourceFontModified = NO;

    fortuneFont = [self fortuneFontFromUserSettings];
    sourceFont = [self sourceFontFromUserSettings];

    /*!
        async. Request calls setRestAnswer: on completion
     */

    if(fortuneList.fortunes == nil) {

        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
        HUD.progress = 0.0;
        HUD.labelText = NSLocalizedString(@"justASecond", @"wait... notification");
        HUD.detailsLabelText = NSLocalizedString(@"remoteGetFortunes", @"Lade Fortunes vom Server");
        HUD.delegate = self;
        [HUD show:YES];

        [RESTClient loadFortunesList:self];
    }
}


- (UIFont *)fortuneFontFromUserSettings {

    return [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_FORTUNE];
}


- (UIFont *)sourceFontFromUserSettings {

    return [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_SOURCE];
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Scroll Row indicator

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {


    CGFloat scrollOffsetAtTableTop = scrollView.contentOffset.y;
    scrollOffsetAtTableTop += [self visibleViewFrame].origin.y + 10.0;
    [rowIndicator setYPos:scrollOffsetAtTableTop];

    topRowIdx = (int) [_tableView indexPathForRowAtPoint: CGPointMake(0, scrollOffsetAtTableTop)].row;
    [self updateRowNumIndicator:topRowIdx + 1];
}


- (void)updateRowNumIndicator:(int)num {

    if(rowIndicator == nil) {

        CGRect frTemp = CGRectMake((CGFloat) (_tableView.frame.size.width - 70.0), 80.0, 60.0, 30.0);
        rowIndicator = [[RowIndicator alloc] initWithFrame:frTemp];
        rowIndicator.layer.cornerRadius = rowIndicator.frame.size.height / 2;
        rowIndicator.layer.borderWidth = 2.0;
        rowIndicator.layer.borderColor = [[UIColor whiteColor] CGColor];
        rowIndicator.clipsToBounds = YES;
        rowIndicator.alpha = 0.8;
        [self.view addSubview:rowIndicator];
    }

    rowIndicator.hidden = NO;
    [rowIndicator setRowNumber:num];
}


- (void)hideRowNum {

    rowIndicator.hidden = YES;
}

#pragma mark -
#pragma mark reading, writing and restoring scroll position

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    [self saveScrollPosition];
    [self performSelector:@selector(hideRowNum) withObject:nil afterDelay:2.0];
}

- (void)saveScrollPosition {

    [UserSettings saveFortuneListScrollPosition:topRowIdx];
}

- (void)restoreScrollPosition {

    // Status- and NavigationBar hide 1,x rows...
    topRowIdx = [UserSettings loadFortuneListScrollPosition] + 1;
    [self updateRowNumIndicator:topRowIdx +1];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:topRowIdx inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark -
#pragma mark fortune data


- (void)setRestAnswer:(JSONModel *)jsonModel {

    if([jsonModel isKindOfClass:[FortuneList class]]) {

        self.jsonModel = jsonModel;

        [HUD showWhileExecuting:@selector(setupFortuneList) onTarget:self withObject:nil animated:YES];
    }
}


- (void)setupFortuneList {

    HUD.progress = 0.0;

    fortuneList = (FortuneList *)self.jsonModel;

    fortuneCells = nil;
    fortuneCells = [[NSArray alloc] init];
    NSMutableArray * mFortuneCells = [[NSMutableArray alloc] initWithCapacity:[fortuneList.fortunes count]];


    // HUD.progress = (CGFloat)[mFortuneCells count] / [fortuneList.fortunes count];
    // HUD.detailsLabelText = [NSString stringWithFormat:NSLocalizedString(@"loading #X of #Y", @"Fortune %d von %d"), (int) [mFortuneCells count], (int) [fortuneList.fortunes count]];


    [self.navigationItem setTitle:[NSString stringWithFormat:NSLocalizedString(@"#n Fortunes", @"%d Fortunes"), (int) [fortuneList.fortunes count]]];

    [_tableView reloadData];
    [self restoreScrollPosition];
}



-(FortuneTableViewCell *)cellForFortune:(SingleFortune *)f {

    UIFont *fFortune = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_FORTUNE];
    UIFont *fSource = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_SOURCE];
    FortuneTableViewCell *cell = [[FortuneTableViewCell alloc] initWithFortune:f fortuneFont:fFortune sourceFont:fSource reuseIdentifier:cellReuseIdentifier];
    return cell;
}


#pragma mark -
#pragma mark TableView IMPL


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of tableView sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [fortuneList.fortunes count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    if(!heightTestCell) {

        heightTestCell = [[FortuneTableViewCell alloc] initWithFortune:fortuneList.fortunes[(NSUInteger)indexPath.row] fortuneFont:fortuneFont sourceFont:sourceFont reuseIdentifier:cellReuseIdentifier];
    }
    else {
        [heightTestCell setFortune:fortuneList.fortunes[(NSUInteger)indexPath.row]];
    }

    NSLog(@"H = %d", (int) [heightTestCell getHeight]);
    return [heightTestCell getHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [[FortuneTableViewCell alloc] initWithFortune:fortuneList.fortunes[(NSUInteger)indexPath.row] fortuneFont:fortuneFont sourceFont:sourceFont reuseIdentifier:cellReuseIdentifier];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    lastSelectionPath = indexPath;

    SingleFortune *f = fortuneList.fortunes[(NSUInteger)indexPath.row];
    [self showDetailsForFortune:f];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark -
#pragma mark Call Detail VC

- (void)showDetailsForFortune:(SingleFortune *)f {

    NSLog(@"Details für ID = %d ...", f.id);

    FortuneDetailViewController *detailVC = [[FortuneDetailViewController alloc] init];
    detailVC.fortune = f;

    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
