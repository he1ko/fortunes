
#import "SingleFortune.h"



@protocol FortuneFavourite;


@interface SingleFortune (Favourites)

- (void)switchFavouriteState;

- (BOOL)isFavourite;

- (void)setToFavourite;

- (void)removeFromFavourites;

- (UIButton *)favImageButton;

@end


@protocol FortuneFavourite

@optional
- (void)fortuneFavouriteStateChanged;
@end
