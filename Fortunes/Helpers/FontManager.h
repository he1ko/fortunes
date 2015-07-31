

/*!
    Default fonts for fortune display
 */

static NSString * kDEFAULT_FONT_NAME_FORTUNE_MAIN = @"AvenirNext-BoldItalic";
static NSString * kDEFAULT_FONT_NAME_LIST_FORTUNE = @"HelveticaNeue";
static NSString * kDEFAULT_FONT_NAME_LIST_SOURCE = @"Baskerville-SemiBoldItalic";

static float kDEFAULT_FONT_SIZE_FORTUNE_MAIN = 22.0;
static float kDEFAULT_FONT_SIZE_LIST_FORTUNE = 15.0;
static float kDEFAULT_FONT_SIZE_LIST_SOURCE = 9.0;


/*! @discussion public definition of section types for dynamic font changes
 */
typedef NS_ENUM(NSInteger, FontAppSection) {

    FONT_APP_SECTION_MAIN_FORTUNE,
    FONT_APP_SECTION_LIST_FORTUNE,
    FONT_APP_SECTION_LIST_SOURCE
};


@protocol FontManagerNotification;


/*!
    Singleton managing font properties for a couple of fortune displays
 */
@interface FontManager : NSObject

/// @name public properties
@property(nonatomic, strong) id<FontManagerNotification> delegate;

/// @name public methods

/*! @discussion public method providing an instance of FontManager
 */
+ (FontManager *)getInstance;

/*! @discussion provides font for given section
 */
- (UIFont *)fontForSection:(FontAppSection)section;

/*! @discussion updates font name for given section
 */
- (void)updateFontName:(NSString *)fontName forSection:(FontAppSection)section;

- (void)resetFontNames;

- (NSString *)sectionNameForSection:(FontAppSection)section;
@end


@protocol FontManagerNotification
@optional
    - (void)fontSaved;
@end