#import "UserSettings.h"


static NSString *fontsSettingKeyPrefix = @"fontSection";


@interface FontManager ()

- (id)initPrivate;
- (NSString *)userSettingsKeyForSection:(FontAppSection)section;
- (NSString *)fontNameForSection:(FontAppSection)section;

@end



@implementation FontManager {

@private
    NSArray *fontSizes;
    NSArray *fontNames;
    NSArray *sectionNames;
}


#pragma mark -
#pragma mark initialization

+ (FontManager *)getInstance {

    static FontManager *instance;

    @synchronized(self) {
        if (!instance) {
            instance = [[FontManager alloc] initPrivate];
        }
        return instance;
    }

}

/*!
    init may not be called explicitly
 */
- (id)init {

    [self doesNotRecognizeSelector:_cmd];
    return nil;
}


/*!
    private init method
 */
- (id)initPrivate {

    self = [super init];

    if (self) {

        NSMutableArray *mFontSizes = [[NSMutableArray alloc] initWithCapacity:3];
        NSMutableArray *mFontNames = [[NSMutableArray alloc] initWithCapacity:3];
        NSMutableArray *mSectionNames = [[NSMutableArray alloc] initWithCapacity:3];

        mFontSizes[FONT_APP_SECTION_MAIN_FORTUNE] = [NSNumber numberWithFloat:kDEFAULT_FONT_SIZE_FORTUNE_MAIN];
        mFontSizes[FONT_APP_SECTION_LIST_FORTUNE] = [NSNumber numberWithFloat:kDEFAULT_FONT_SIZE_LIST_FORTUNE];
        mFontSizes[FONT_APP_SECTION_LIST_SOURCE] = [NSNumber numberWithFloat:kDEFAULT_FONT_SIZE_LIST_SOURCE];
        fontSizes = mFontSizes;

        mFontNames[FONT_APP_SECTION_MAIN_FORTUNE] = [self fontNameForSection:FONT_APP_SECTION_MAIN_FORTUNE];
        mFontNames[FONT_APP_SECTION_LIST_FORTUNE] = [self fontNameForSection:FONT_APP_SECTION_LIST_FORTUNE];
        mFontNames[FONT_APP_SECTION_LIST_SOURCE] = [self fontNameForSection:FONT_APP_SECTION_LIST_SOURCE];
        fontNames = mFontNames;

        mSectionNames[FONT_APP_SECTION_MAIN_FORTUNE] = NSLocalizedString(@"ButtonMyFortune", @"");
        mSectionNames[FONT_APP_SECTION_LIST_FORTUNE] = NSLocalizedString(@"ButtonListFortune", @"");
        mSectionNames[FONT_APP_SECTION_LIST_SOURCE] = NSLocalizedString(@"ButtonListSource", @"");
        sectionNames = mSectionNames;
    }

    return self;
}



#pragma mark -
#pragma mark Public font handling

- (UIFont *)fontForSection:(FontAppSection)section {

    return [UIFont fontWithName:[self fontNameForSection:section] size:[fontSizes[section]floatValue]];
}


- (void)updateFontName:(NSString *)fontName forSection:(FontAppSection)section {

    NSString *key = [self userSettingsKeyForSection:section];
    [UserSettings saveString:fontName forKey:key];

    NSMutableArray *mFontNames = [fontNames mutableCopy];
    mFontNames[section] = fontName;
    fontNames = mFontNames;
}


#pragma mark -
#pragma mark convenience methods

- (NSString *)userSettingsKeyForSection:(FontAppSection)section {

    return [NSString stringWithFormat:@"%@_%d", fontsSettingKeyPrefix, (int)section];
}


- (NSString *)fontNameForSection:(FontAppSection)section {

    NSString *settingsKey = [self userSettingsKeyForSection:section];
    NSString *fontName = fontNames[section];

    if(fontName == nil || [fontName isEqualToString:@""]) {

        fontName = [UserSettings loadStringWithKey:settingsKey];
    }

    return fontName;
}


- (NSString *)sectionNameForSection:(FontAppSection)section {

    return sectionNames[section];
}

@end
