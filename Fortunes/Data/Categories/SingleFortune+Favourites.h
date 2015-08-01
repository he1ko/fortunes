
#import "SingleFortune.h"

@interface SingleFortune (Favourites)

- (void)switchFavouriteState;

- (BOOL)isFavourite;

- (void)setToFavourite;

- (void)removeFromFavourites;

- (NSString *)favImageButtonName;

- (UIButton *)favListImageButton;
@end

