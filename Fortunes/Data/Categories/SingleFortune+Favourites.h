
#import "SingleFortune.h"

@interface SingleFortune (Favourites)

- (void)switchFavouriteState;

- (BOOL)isFavourite;

- (void)setToFavourite;

- (void)removeFromFavourites;

- (UIImageView *)favImage;
@end