
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

    UIButton *btFav = [UIButton buttonWithType:UIButtonTypeCustom];
    [btFav setFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];

    UIImage *favImg = [UIImage imageNamed:@"fav-add"];

    if([self isFavourite]) {
        favImg = [UIImage imageNamed:@"fav-remove"];
    }

    [btFav setBackgroundImage:favImg forState:UIControlStateNormal];

    return btFav;
}



- (UIButton *)favListImageButton {

    UIButton *btFav = [UIButton buttonWithType:UIButtonTypeCustom];
    [btFav setFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];

    UIImage *favImg = [UIImage imageNamed:@"favourite-list"];

    [btFav setBackgroundImage:favImg forState:UIControlStateNormal];

    if(![self isFavourite]) {
        [btFav setAlpha:0.2];
    }

    return btFav;
}


@end