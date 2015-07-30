//
// Created by Heiko Bublitz on 22.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

#import "UserSettings.h"

static NSString *keyScrollPosFortunesList = @"SCROLL_MAIN";


@implementation UserSettings {

}



+ (NSString *)loadStringWithKey:(NSString *)key {

    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if(string == nil) {
        return @"";
    }
    return string;
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