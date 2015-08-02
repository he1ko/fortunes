//
//  FortuneTableViewCell.h
//  Fortunes
//
//  Created by Heiko Bublitz on 22.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

@class SingleFortune;

@protocol TableViewCell;

@interface FortuneTableViewCell : UITableViewCell

@property(nonatomic, strong) SingleFortune *fortune;
@property(nonatomic, strong) id <TableViewCell> delegate;

- (id)initWithFortune:(SingleFortune *)fortune fortuneFont:(UIFont *)_fortuneFont sourceFont:(UIFont *)_sourceFont reuseIdentifier:(NSString *)reuseIdentifier;
- (CGFloat)getHeight;
- (void)setFortune:(SingleFortune *)fortune;
- (NSString *)getFortuneFontName;
- (NSString *)getSourceFontName;
@end


@protocol TableViewCell
- (void)favouriteDeleted:(SingleFortune *)fortune;
@end