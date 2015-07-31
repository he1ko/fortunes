
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


- (UIButton *)favImageButton {

    UIButton *btFav = [[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *favImg = [UIImage imageNamed:@"fav-add"];

    if([self isFavourite]) {
        favImg = [UIImage imageNamed:@"fav-remove"];
    }

    [btFav setImage:favImg forState:UIControlStateNormal];
    [btFav addTarget:self action:@selector(switchFavouriteState) forControlEvents:UIControlEventTouchUpInside];

    return btFav;
}


@end