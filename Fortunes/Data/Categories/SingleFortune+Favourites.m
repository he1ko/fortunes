
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
    [self.favDelegate favouriteStateChangedTo:YES];
}


- (void)removeFromFavourites {

    [[FavouritesManager getInstance] removeFromFavourites:self];
    [self.favDelegate favouriteStateChangedTo:NO];
}


- (NSString *)favImageButtonName {

    NSString *imgName = favImageNameAdd;

    if([self isFavourite]) {
        imgName = favImageNameRemove;
    }

    return imgName;
}


- (UIButton *)favListImageButton {

    UIButton *btFav = [UIButton buttonWithType:UIButtonTypeCustom];
    [btFav setFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];

    UIImage *favImg = [UIImage imageNamed:@"favourites-remove"];

    [btFav setBackgroundImage:favImg forState:UIControlStateNormal];

    if(![self isFavourite]) {
        [btFav setAlpha:0.2];
    }

    return btFav;
}


@end