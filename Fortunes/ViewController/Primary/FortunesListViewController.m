
#import "FortunesListViewController.h"
#import "UserSettings.h"
#import "FortuneDetailViewController.h"
#import "RowIndicator.h"
#import "FavouritesManager.h"
#import "UIViewController+NavigationBar.h"


typedef NS_ENUM(NSInteger, TableDataSet) {

    TABLE_DATA_SET_ALL,
    TABLE_DATA_SET_FAVOURITES
};


static NSString *cellReuseIdentifier = @"fortuneCell";

@implementation FortunesListViewController {

@private
    FortuneList *fortunesFromServer;
    NSArray *tableData;
    FortuneTableViewCell *heightTestCell;
    NSString *fortuneFontName;
    NSString *sourceFontName;

    MBProgressHUD *HUD;
    NSIndexPath *lastSelectionPath;
    RowIndicator *rowIndicator;

    ToolbarFortuneList *fortuneListToolbar;
    NSArray *lastScrollPositions;

    TableDataSet dataSet;
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

    CGRect frameWithoutBars = [self visibleViewFrame];
    UIEdgeInsets contentPadding = _tableView.contentInset;
    contentPadding.top = frameWithoutBars.origin.y;
    _tableView.contentInset = contentPadding;

    self.view = _tableView;

    _tableView.delegate = self;
    _tableView.dataSource = self;

    contentPadding = _tableView.contentInset;
    contentPadding.bottom += 48.0;
    _tableView.contentInset = contentPadding;

    [self addToolbar];

    [self setNavigationTitle:NSLocalizedString(@"listOfFortunes", @"AllFortunes header text")];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.view.backgroundColor = [UIColor presetHighlight];

    if (lastSelectionPath != nil) {
        [_tableView deselectRowAtIndexPath:lastSelectionPath animated:YES];
    }
}


- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    [self setPositionOfToolbar:fortuneListToolbar];
    [self addToolbarOffset:fortuneListToolbar];

    if (![self isFontChanged] && tableData != nil) {
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

    if(tableData == nil) {

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
#pragma mark TOOLBAR

- (void)addToolbar {

    NSMutableArray *mImageNames = [[NSMutableArray alloc] initWithCapacity:4];
    mImageNames[TOOLBAR_ITEM_INDEX_ALL_FORTUNES] = @"AllFortunes";
    mImageNames[TOOLBAR_ITEM_INDEX_FAVOURITES] = @"favourites-remove";
    mImageNames[TOOLBAR_ITEM_INDEX_TOP] = @"ArrowTop";
    mImageNames[TOOLBAR_ITEM_INDEX_BOTTOM] = @"ArrowEnd";

    fortuneListToolbar = [[ToolbarFortuneList alloc] initWithImageNamesArray:mImageNames];

    fortuneListToolbar.delegate = self;
    fortuneListToolbar.toolbarDelegate = self;
    [self.view addSubview:fortuneListToolbar];
}


- (void)setPositionOfToolbar:(UIToolbar *)bar  {

    CGRect toolbarFrame = bar.frame;
    toolbarFrame.origin.x = 0.0;
    toolbarFrame.origin.y = [self.view height] - toolbarFrame.size.height;

    [bar setFrame:toolbarFrame];
}


- (void)addToolbarOffset:(UIToolbar *)bar {

    CGRect toolbarFrame = bar.frame;
    toolbarFrame.origin.y += _tableView.contentOffset.y;
    [bar setFrame:toolbarFrame];
}


- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {

    [self setPositionOfToolbar:(UIToolbar *)bar];

    return UIBarPositionBottom;
}



- (void)toolbarItemTouchedWithIndex:(NSUInteger)itemIndex {

    switch (itemIndex) {

        case TOOLBAR_ITEM_INDEX_ALL_FORTUNES:
            [self tbTouchAllFortunes];
            break;

        case TOOLBAR_ITEM_INDEX_FAVOURITES:
            [self tbTouchFavourites];
            break;

        case TOOLBAR_ITEM_INDEX_TOP:
            [self tbTouchGotoTop];
            break;

        case TOOLBAR_ITEM_INDEX_BOTTOM:
            [self tbTouchGotoEnd];
            break;

        default:
            break;
    }
}


- (void)tbTouchFavourites {

    NSArray *favIds = [[FavouritesManager getInstance] favouriteIds];
    NSMutableArray *dataFiltered = [[NSMutableArray alloc] initWithCapacity:[favIds count]];

    for (SingleFortune *f in fortunesFromServer.fortunes) {

        for (NSNumber *fId in favIds) {

            if ([fId intValue] == f.id) {

                [dataFiltered addObject:f];
            }
        }
    }
    tableData = dataFiltered;
    [_tableView reloadData];

    NSString *localizedTitle = NSLocalizedString(@"Favoriten", @"Favoriten");

    [self setNavigationTitle:[NSString stringWithFormat:@"%d %@", [tableData count], localizedTitle]];
    [self tbTouchGotoTop];

    dataSet = TABLE_DATA_SET_FAVOURITES;
}


- (void)tbTouchAllFortunes {

    tableData = fortunesFromServer.fortunes;
    [_tableView reloadData];

    [self setNavigationTitle:[NSString stringWithFormat:@"%d Fortunes", (int)[tableData count]]];
    [self tbTouchGotoTop];

    dataSet = TABLE_DATA_SET_ALL;
}


- (void)tbTouchGotoEnd {

    CGPoint offset = CGPointMake(0, _tableView.contentSize.height - _tableView.frame.size.height + fortuneListToolbar.frame.size.height);
    [_tableView setContentOffset:offset animated:YES];
}


- (void)tbTouchGotoTop {

    [_tableView setContentOffset:CGPointMake(0.0, [self visibleViewFrame].origin.y * -1) animated:YES];
}


#pragma mark -
#pragma mark Scroll Row indicator

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    /// re-position row indicator:
    CGFloat scrollOffsetAtTableTop = scrollView.contentOffset.y;
    scrollOffsetAtTableTop += [self visibleViewFrame].origin.y + 10.0;
    [rowIndicator setYPos:scrollOffsetAtTableTop];

    topRowIdx = (int) [_tableView indexPathForRowAtPoint: CGPointMake(0, scrollOffsetAtTableTop)].row;
    [self updateRowNumIndicator:topRowIdx + 1];

    /// re-position toolbar
    [fortuneListToolbar setY:[_tableView height] - [fortuneListToolbar height] + scrollView.contentOffset.y];

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

/**
* TODO: save, load and apply positions for ALL / FAVOURITES seperately!
*/
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

    fortunesFromServer = (FortuneList *)self.jsonModel;
    tableData = fortunesFromServer.fortunes;

    [self tbTouchAllFortunes];
    [self restoreScrollPosition];
}


-(FortuneTableViewCell *)cellForFortune:(SingleFortune *)f {

    UIFont *fFortune = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_FORTUNE];
    UIFont *fSource = [[FontManager getInstance] fontForSection:FONT_APP_SECTION_LIST_SOURCE];
    FortuneTableViewCell *cell = [[FortuneTableViewCell alloc] initWithFortune:f fortuneFont:fFortune sourceFont:fSource reuseIdentifier:cellReuseIdentifier];

    f.favDelegate = self;
    cell.delegate = self;

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
    return [tableData count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(!heightTestCell ||[self isFontChanged]) {

        heightTestCell = [self cellForFortune:tableData[(NSUInteger)indexPath.row]];
    }
    else {
        [heightTestCell setFortune:tableData[(NSUInteger)indexPath.row]];
    }

    CGFloat progress = (CGFloat)indexPath.row / [tableData count];

    HUD.progress = progress;
    HUD.detailsLabelText = [NSString stringWithFormat:NSLocalizedString(@"loading #X of #Y", @"Fortune %d von %d"), (int)indexPath.row, (int) [tableData count]];

    return [heightTestCell getHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self cellForFortune:tableData[(NSUInteger) indexPath.row]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    lastSelectionPath = indexPath;

    SingleFortune *f = tableData[(NSUInteger)indexPath.row];
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

    FortuneDetailViewController *detailVC = [[FortuneDetailViewController alloc] init];
    detailVC.fortune = f;

    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark -
#pragma mark FavouriteFortune IMPL


- (void)favouriteStateChangedTo:(BOOL)isFav {

    NSString *alertTitle = NSLocalizedString(@"HUD.title.yourFavourites", @"Deine Favoriten");
    NSString *alertSubtitle;

    if(isFav) {
        alertSubtitle = NSLocalizedString(@"home.fav.added.message", @"Fortune als Favorit gespeichert.");
    }
    else {
        alertSubtitle = NSLocalizedString(@"home.fav.removed.message", @"Fortune aus Deinen Favoriten entfernt.");
    }

    [self setAlertOffsetY:_tableView.contentOffset.y];
    [self alertWithTitle:alertTitle subtitle:alertSubtitle duration:1.8];
 //   [hud setYOffset:_tableView.contentOffset.y];
}


- (void)hideHud {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark -
#pragma mark TableViewCell IMPL

- (void)favouriteDeleted:(SingleFortune *)fortune {

    NSMutableArray * mTabledata = [tableData mutableCopy];

    if(dataSet == TABLE_DATA_SET_FAVOURITES) {

        for (int i = 0; i < [_tableView numberOfRowsInSection:0]; i++) {

            NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
            FortuneTableViewCell *tvc = (FortuneTableViewCell *) [_tableView cellForRowAtIndexPath:ip];

            if (tvc.fortune.id == fortune.id) {

                [_tableView beginUpdates];
                [mTabledata removeObject:fortune];
                tableData = mTabledata;
                [_tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationTop];
                [_tableView endUpdates];
                break;
            }
        }
    }
}


@end
