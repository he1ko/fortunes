
#import "FavouritesManager.h"
#import "SingleFortune.h"
#import "UserSettings.h"


static NSString *favSettingKey = @"favourites";


@implementation FavouritesManager {

@private
    NSArray *favouriteIDs;
}


#pragma mark -
#pragma mark initialization


+ (FavouritesManager *)getInstance {

    static FavouritesManager *instance;

    @synchronized(self) {
        if (!instance) {
            instance = [[FavouritesManager alloc] initPrivate];
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

        favouriteIDs = [self loadFavouriteIds];
    }

    return self;
}




#pragma mark -
#pragma mark public Fav data access


- (BOOL)isFavourite:(SingleFortune *)fortune {

    for(NSNumber *num in favouriteIDs) {

        if([num intValue] == fortune.id){
            return YES;
        }
    }
    return NO;
}


- (FavouritesResult)addToFavourites:(SingleFortune *)fortune {

    FavouritesResult rslt = [self _saveFavouriteState:YES for:fortune];

    if(rslt == FAV_RESULT_ALREADY_FAV) {
        return FAV_RESULT_ALREADY_FAV;
    }

    return FAV_RESULT_SET_TO_FAV;
}


- (FavouritesResult)removeFromFavourites:(SingleFortune *)fortune {

    FavouritesResult rslt = [self _saveFavouriteState:NO for:fortune];

    if(rslt == FAV_RESULT_ALREADY_NO_FAV) {
        return FAV_RESULT_ALREADY_NO_FAV;
    }

    return FAV_RESULT_SET_NO_FAV;
}


- (NSArray *)favouriteIds {

    return [self loadFavouriteIds];
}

#pragma mark -
#pragma mark private helpers



- (FavouritesResult) _saveFavouriteState:(BOOL)isFav for:(SingleFortune*)fortune {

    if(isFav && [self isFavourite:fortune]) {
        return FAV_RESULT_ALREADY_FAV;
    }
    if(!isFav && ![self isFavourite:fortune]) {
        return FAV_RESULT_ALREADY_NO_FAV;
    }

    NSMutableArray *mFavouriteIDs = [favouriteIDs mutableCopy];

    if(!mFavouriteIDs) {
        mFavouriteIDs = [[NSMutableArray alloc] initWithCapacity:1];
    }

    /// isFav = YES: simply add fortune-id

    if(isFav) {
        [mFavouriteIDs addObject:@(fortune.id)];
        favouriteIDs = mFavouriteIDs;
        [UserSettings saveArray:favouriteIDs forKey:favSettingKey];
        return FAV_RESULT_SET_TO_FAV;
    }


    /// isFav = NO: remove fortune-id

    __block int fortuneId = fortune.id;

    [mFavouriteIDs enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger index, BOOL *stop) {

        if ([num intValue] == fortuneId) {
            [mFavouriteIDs removeObjectAtIndex:index];
            *stop = YES;
        }
    }];

    /// Save modified array to userDefaults
    favouriteIDs = mFavouriteIDs;
    [UserSettings saveArray:favouriteIDs forKey:favSettingKey];
    return FAV_RESULT_SET_NO_FAV;
}



- (NSArray *)loadFavouriteIds {

    NSArray *favs = [UserSettings loadArrayWithKey:favSettingKey];
    return favs;
}

@end