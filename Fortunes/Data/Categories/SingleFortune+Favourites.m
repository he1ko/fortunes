
#import "SingleFortune+Favourites.h"
#import "FavouritesManager.h"


@implementation SingleFortune (Favourites)


- (void)switchFavouriteState {

    if([self isFavourite]) {
        [self removeFromFavourites];
    }
    else {
        [self setToFavourite];
    }
}


- (BOOL)isFavourite {

    return [[FavouritesManager getInstance] isFavourite:self];
}


- (void)setToFavourite {

    [[FavouritesManager getInstance] addToFavourites:self];
}


- (void)removeFromFavourites {

    [[FavouritesManager getInstance] removeFromFavourites:self];
}


- (UIImageView *)favImage {

    UIImageView *favImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fav-add"]];

    if([self isFavourite]) {

        [favImg setImage:[UIImage imageNamed:@"fav-remove"]];
    }
    return favImg;
}


@end