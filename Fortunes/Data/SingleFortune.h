//
//  SingleFortune.h
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "JSONModel.h"

@protocol SingleFortune @end
@protocol FavouriteFortune;

@interface SingleFortune : JSONModel

@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *source;
@property(nonatomic, strong) NSString *translationDe;
@property(nonatomic, assign) int rating;

@property(nonatomic, strong) id <FavouriteFortune> favDelegate;

- (NSString *)cleanText;

@end


@protocol FavouriteFortune
-(void)favouriteStateChangedTo:(BOOL)isFav;
@end