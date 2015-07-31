//
// Created by Heiko Bublitz on 22.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//




@interface UserSettings : NSObject


+ (NSString *)loadStringWithKey:(NSString *)key;

+ (void)saveString:(NSString *)string forKey:(NSString *)key;

+ (NSArray *)loadArrayWithKey:(NSString *)key;

+ (void)saveArray:(NSArray *)array forKey:(NSString *)key;

+ (int)loadFortuneListScrollPosition;
+ (void)saveFortuneListScrollPosition:(int)scrollPos;



@end