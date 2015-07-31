

typedef NS_ENUM(NSInteger, FavouritesResult) {

    FAV_RESULT_SET_TO_FAV,
    FAV_RESULT_SET_NO_FAV,
    FAV_RESULT_ALREADY_FAV,
    FAV_RESULT_ALREADY_NO_FAV
};

@protocol FavouritesManagerNotification;
@class SingleFortune;


/*!

  @discussion handles favourite state and related properties of fortune items

  An Array of favourite fortune IDs is written to and read from UserSettings.


    + isFavourite:(SingleFortune*)fortune;
    + setFavouriteState:(BOOL)state for:(SingleFortune*)fortune;
    + favouritePicSmall:(BOOL)small for:(SingleFortune*)fortune;

    priv.:
    + _favouriteSmallPic:(SingleFortune*)fortune;
    + _favouriteLargePic:(SingleFortune*)fortune;
    + _favouritePic:(SingleFortune*)fortune;
    + _loadFavouriteState:(BOOL)state for:(SingleFortune*)fortune
    + _saveFavouriteState:(BOOL)state for:(SingleFortune*)fortune

 */

@interface FavouritesManager : NSObject

@property(nonatomic, strong) id <FavouritesManagerNotification> delegate;

+ (FavouritesManager *)getInstance;

- (BOOL)isFavourite:(SingleFortune *)fortune;

- (void)addToFavourites:(SingleFortune *)fortune;

- (void)removeFromFavourites:(SingleFortune *)fortune;

@end



@protocol FavouritesManagerNotification
@optional
- (void)favouriteSaved:(FavouritesResult)rslt;
- (void)favouriteNotSaved:(FavouritesResult)rslt;
@end