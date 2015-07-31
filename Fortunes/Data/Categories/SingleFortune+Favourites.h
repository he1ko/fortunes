
#import "SingleFortune.h"

@interface SingleFortune (Favourites)

- (void)switchFavouriteState;

- (BOOL)isFavourite;

- (void)setToFavourite;

- (void)removeFromFavourites;

- (UIButton *)favImageButton;

- (UIButton *)favListImageButton;
@end

