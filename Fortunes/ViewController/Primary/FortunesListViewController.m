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
    NSString *fortuneFontName;
    NSString *sourceFontName;

    MBProgressHUD *HUD;
    NSIndexPath *lastSelectionPath;
    RowIndicator *rowIndicator;

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

    if (lastSelectionPath != nil) {
        [_tableView deselectRowAtIndexPath:lastSelectionPath animated:YES];
    }
}


- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    if (![self isFontChanged] && fortuneList.fortunes != nil) {

        return;
    }


    if(!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
    }

    HUD.progress = 0.0;
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.labelText = NSLocalizedString(@"justASecond", @"wait... notification");
    HUD.detailsLabelText = NSLocalizedString(@"remoteGetFortunes", @"Lade Fortunes vom Server");
    HUD.delegate = self;

    if(fortuneList.fortunes == nil) {

        /*!
            async. Request calls setRestAnswer: on completion
         */
        [RESTClient loadFortunesList:self];
    }
    else if ([self isFontChanged] && [_tableView numberOfRowsInSection:(NSInteger)0] > 0) {
        [HUD showWhileExecuting:@selector(reloadData) onTarget:_tableView withObject:nil animated:YES];
    }
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

        rowIndicator = [[RowIndicator alloc] initInFrame:[self visibleViewFrame]];
        [self.view addSubview:rowIndicator];
        [rowIndicator show:YES];
    }

    [rowIndicator show:YES];
    [rowIndicator setRowNumber:num];
}


- (void)hideRowNum {

    [rowIndicator show:NO];
}


#pragma mark -
#pragma mark Font change

-(Boolean)isFontChanged {

    if(fortuneFontName == nil && sourceFontName == nil) {
        return NO;
    }

    UIFont *fFortune = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_FORTUNE];
    UIFont *fSource = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_SOURCE];

    if(![fFortune.fontName isEqualToString:fortuneFontName]) {
        return YES;
    }

    if(![fSource.fontName isEqualToString:sourceFontName]) {
        return YES;
    }

    return NO;
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

    [self.navigationItem setTitle:[NSString stringWithFormat:NSLocalizedString(@"#n Fortunes", @"%d Fortunes"), (int) [fortuneList.fortunes count]]];

    [_tableView reloadData];
    [self restoreScrollPosition];
}



-(FortuneTableViewCell *)cellForFortune:(SingleFortune *)f {

    f.favDelegate = self;
    UIFont *fFortune = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_FORTUNE];
    UIFont *fSource = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_SOURCE];
    FortuneTableViewCell *cell = [[FortuneTableViewCell alloc] initWithFortune:f fortuneFont:fFortune sourceFont:fSource reuseIdentifier:cellReuseIdentifier];

    fortuneFontName = [cell getFortuneFontName];
    sourceFontName = [cell getSourceFontName];

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

        heightTestCell = [self cellForFortune:fortuneList.fortunes[(NSUInteger) indexPath.row]];
    }
    else if ([self isFontChanged]) {

        heightTestCell = [self cellForFortune:fortuneList.fortunes[(NSUInteger) indexPath.row]];
    }
    else {
        [heightTestCell setFortune:fortuneList.fortunes[(NSUInteger)indexPath.row]];
    }

    CGFloat progress = (CGFloat)indexPath.row / [fortuneList.fortunes count];

    HUD.progress = progress;
    HUD.detailsLabelText = [NSString stringWithFormat:NSLocalizedString(@"loading #X of #Y", @"Fortune %d von %d"), (int)indexPath.row, (int) [fortuneList.fortunes count]];

    return [heightTestCell getHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self cellForFortune:fortuneList.fortunes[(NSUInteger) indexPath.row]];
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


#pragma mark -
#pragma mark FavouriteFortune IMPL


- (void)favouriteStateChangedTo:(BOOL)isFav {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    [hud setYOffset:_tableView.contentOffset.y];

    hud.labelText = @"Deine Favoriten";

    if(isFav) {
        hud.detailsLabelText = NSLocalizedString(@"home.fav.added.message", @"Fortune als Favorit gespeichert.");
    }
    else {
        hud.detailsLabelText = NSLocalizedString(@"home.fav.removed.message", @"Fortune aus Deinen Favoriten entfernt.");
    }

    [self performSelector:@selector(hideHud) withObject:nil afterDelay:1.8];
}


- (void)hideHud {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
