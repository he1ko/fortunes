//
//  FontsViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 28.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "FontsViewController.h"
#import "UIViewController+Layout.h"

@interface FontsViewController ()

- (void)setupFontNames;

@end

@implementation FontsViewController {

@private
    NSDictionary *fontFamilysAndNames;
    MBProgressHUD *hud;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    [self setupFontNames];

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

    [self.navigationItem setTitle:@"Schriftarten"];
    [self addRightNavigationButtonWithText:@"Zurück"];
}


- (void)setupFontNames {

    NSArray *familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableDictionary *mFontFamilys = [[NSMutableDictionary alloc] init];

    for (NSString *familyName in familyNames){

        mFontFamilys[familyName] = [[NSMutableArray alloc] init];

        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {

            [mFontFamilys[familyName] addObject:fontName];
        }
    }

    fontFamilysAndNames = mFontFamilys;
}



#pragma mark -
#pragma mark TableView IMPL


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [fontFamilysAndNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *families = [[fontFamilysAndNames allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *familyName = families[(NSUInteger)section];
    NSArray *fntArray = (NSArray*)fontFamilysAndNames[familyName];

    return [fntArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSArray *families = [[fontFamilysAndNames allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *familyName = families[(NSUInteger)section];
    familyName = [NSString stringWithFormat:@"    %@", familyName];

    UILabel *lblSectionHeader = [self simpleLabelWithText:familyName];
    lblSectionHeader.backgroundColor = [UIColor lightGrayColor];

    return lblSectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 20.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *families = [[fontFamilysAndNames allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *familyName = families[(NSUInteger)indexPath.section];
    NSArray *fntArray = (NSArray*)fontFamilysAndNames[familyName];
    NSString *fontName = fntArray[(NSUInteger)indexPath.row];

    static NSString *cellIdentifier = @"fontCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:cell.textLabel.font.pointSize];
 //    cell.detailTextLabel.text = [item objectForKey:@"secondaryTitleKey"];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self saveFontName:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
}


#pragma mark -
#pragma mark Font saving

- (void)saveFontName:(NSString *)fontName {

    NSString *sectionName = [[FontManager getInstance] sectionNameForSection:_fontSection];

    hud = [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.labelText = NSLocalizedString(@"FontSaved", @"Schriftart gespeichert");
    hud.delegate = self;
    hud.detailsLabelText = [NSString stringWithFormat:@"%@: %@", sectionName, fontName];

    [hud setYOffset:_tableView.contentOffset.y];

    [[FontManager getInstance] setDelegate:self];
    [[FontManager getInstance] updateFontName:fontName forSection:_fontSection];
}

- (void)fontSaved {

    [self performSelector:@selector(hideHud) withObject:nil afterDelay:1.5];
}


- (void)hideHud {

    [MBProgressHUD hideHUDForView:_tableView animated:YES];
}


- (void)hudWasHidden:(MBProgressHUD *)hud {

    NSLog(@"Hud weg...");
    hud = nil;
    [self rightNavigationButtonTouched];
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
