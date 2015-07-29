//
// Created by Heiko Bublitz on 22.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

#import "UserSettings.h"

static NSString *keyScrollPosFortunesList = @"SCROLL_MAIN";
static NSString *userDefaultsKeyPrefix = @"fontSection";


@implementation UserSettings {

}


+ (NSString *)loadStringWithKey:(NSString *)key {

    NSLog(@"Lese Wert für %@", key);
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}


+ (void)saveString:(NSString *)string forKey:(NSString *)key {

    NSLog(@"Speichere %@ für %@", string, key);
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
}



+ (int)loadFortuneListScrollPosition {

    int row = (int)[[NSUserDefaults standardUserDefaults] integerForKey:keyScrollPosFortunesList];
    return row;
}

+ (void)saveFortuneListScrollPosition:(int)scrollPos {

    [[NSUserDefaults standardUserDefaults] setInteger:scrollPos forKey:keyScrollPosFortunesList];
}

#pragma mark -
#pragma mark FontSettings


+ (NSString *)userDefaultsKeyForSection:(FontAppSection)section {

    return [NSString stringWithFormat:@"%@_%d", userDefaultsKeyPrefix, (int)section];
}



@end