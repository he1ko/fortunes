

typedef NS_ENUM(NSInteger, FavouritesResult) {

    FAV_RESULT_SET_TO_FAV,
    FAV_RESULT_SET_NO_FAV,
    FAV_RESULT_ALREADY_FAV,
    FAV_RESULT_ALREADY_NO_FAV
};


@class SingleFortune;


/*!

  @discussion handles favourite state and related properties of fortune items

  An Array of favourite fortune IDs is written to and read from UserSettings.

 */

@interface FavouritesManager : NSObject

+ (FavouritesManager *)getInstance;

- (BOOL)isFavourite:(SingleFortune *)fortune;

- (FavouritesResult)addToFavourites:(SingleFortune *)fortune;

- (FavouritesResult)removeFromFavourites:(SingleFortune *)fortune;

- (NSArray *)favouriteIds;
@end
