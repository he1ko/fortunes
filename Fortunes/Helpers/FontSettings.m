
#import "FontSettings.h"
#import "UserSettings.h"


@implementation FontSettings {


}


- (instancetype)init {

    self = [super init];

    if (self) {

        _fontNameMain = [UserSettings loadFontNameForSection:FONT_APP_SECTION_MAIN_FORTUNE];
        _fontNameListFortune = [UserSettings loadFontNameForSection:FONT_APP_SECTION_LIST_FORTUNE];
        _fontNameListSource = [UserSettings loadFontNameForSection:FONT_APP_SECTION_LIST_SOURCE];
    }

    return self;
}


- (UIFont *)fontForMainFortune {

    NSString *fontName = kDEFAULT_FONT_NAME_FORTUNE_MAIN;



    UIFont *fntTemp = [UIFont fontWithName:kDEFAULT_FONT_NAME_FORTUNE_MAIN size:kDEFAULT_FONT_SIZE_FORTUNE_MAIN];

    return fntTemp;
}


@end
