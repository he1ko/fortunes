//
// Created by Heiko Bublitz on 22.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

typedef NS_ENUM(NSInteger, FontAppSection) {

    FONT_APP_SECTION_MAIN_FORTUNE,
    FONT_APP_SECTION_LIST_FORTUNE,
    FONT_APP_SECTION_LIST_SOURCE
};


@interface UserSettings : NSObject


+ (NSString *)loadStringWithKey:(NSString *)key;

+ (void)saveString:(NSString *)string forKey:(NSString *)key;

+ (int)loadFortuneListScrollPosition;

+ (void)saveFortuneListScrollPosition:(int)scrollPos;

+ (NSString *)userDefaultsKeyForSection:(FontAppSection)section;
@end