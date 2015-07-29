//
//  LeftNavItem.h
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//


typedef NS_ENUM(NSInteger, LeftNavItemTag){
    LeftNavItemTagHome,
    LeftNavItemTagFortunesList,
    LeftNavItemTagFortunesBySource,
    LeftNavItemTagSettings,
    LeftNavItemTagImpressum
};

static float const marginX = 20.0f;
static float const marginY = 20.0f;


@interface LeftNavItem : UIControl

@property(nonatomic, strong) NSString *text;

- (id)initWithFrame:(CGRect)frame andTag:(NSInteger)tag andText:(NSString *)text;


- (void)setSelected:(BOOL)selected;
@end
