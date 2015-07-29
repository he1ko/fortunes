//
//  FortuneTableViewCell.h
//  Fortunes
//
//  Created by Heiko Bublitz on 22.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

@class SingleFortune;

@interface FortuneTableViewCell : UITableViewCell

- (id)initWithFortune:(SingleFortune *)fortune fontName:(NSString *)fontName sourceFontName:(NSString *)_sourceFontName reuseIdentifier:(NSString *)reuseIdentifier;
- (CGFloat)getHeight;
- (void)setFortuneFontName:(NSString *)fontName;

- (void)setSourceFontName:(NSString *)fontName;
@end
