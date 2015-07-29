//
// Created by Heiko Bublitz on 22.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

#import "UserSettings.h"

static NSString *keyScrollPosFortunesList = @"SCROLL_MAIN";
static NSString *fontsSettingKeyPrefix = @"fontSection";


@implementation UserSettings {

}


+ (NSString *)loadFontNameForSection:(FontAppSection)fontSection {

    NSString *key = [NSString stringWithFormat:@"%@_%d", fontsSettingKeyPrefix, (int)fontSection];
    return [self loadStringWithKey:key];
};

+ (void) saveFontName:(NSString *)fontName forSection:(FontAppSection)fontSection {

    NSString *key = [NSString stringWithFormat:@"%@_%d", fontsSettingKeyPrefix, (int)fontSection];
    [self saveString:fontName forKey:key];
}



+ (NSString *)loadStringWithKey:(NSString *)key {

    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}


+ (void)saveString:(NSString *)string forKey:(NSString *)key {

    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
}



+ (int)loadFortuneListScrollPosition {

    int row = (int)[[NSUserDefaults standardUserDefaults] integerForKey:keyScrollPosFortunesList];
    return row;
}

+ (void)saveFortuneListScrollPosition:(int)scrollPos {

    [[NSUserDefaults standardUserDefaults] setInteger:scrollPos forKey:keyScrollPosFortunesList];
}


@end