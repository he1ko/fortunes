//
// Created by Heiko Bublitz on 09.01.15.
// Copyright (c) 2015 Fast Gesund. All rights reserved.
//

@implementation UIColor (Presets)

+ (NSArray *)getPrefixes
{
    return @[@"preset_",
            @"web_"];
}

+ (UIColor *)preset_backGroundBlackWithAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:alpha];
}

+ (UIColor *)presetBase
{
    return UIColorFromRGB(0x1386BF);
}

+ (UIColor *)presetHighlight
{
    return UIColorFromRGB(0x16AED9);
}

+ (UIColor *)presetLightText
{
    return UIColorFromRGB(0xFDF5E6);
}


+ (UIColor *)presetDarkText
{
    return UIColorFromRGB(0x333333);
}


+ (UIColor *)presetItemSelected
{
    return UIColorFromRGB(0x666666);
}


+ (UIColor *)presetItemBackground
{
    return UIColorFromRGB(0x494949);
}

+ (UIColor *)presetEditModeTextColor
{
    return [self web_Darkslateblue];
}

+ (UIColor *)presetButtonRed
{
    return [self web_Crimson];
}

+ (UIColor *)presetButtonGreen
{
    return [self web_Yellowgreen];
}

+ (UIColor *)presetItemBGMine
{
    return UIColorFromRGB(0xB9CF3B);
}

+ (UIColor *)presetItemBGOthers
{
    return [self custom_dunkelGrauBraun];
}

+ (UIColor *)presetItemBGIncomplete
{
    return UIColorFromRGB(0xeeeeee);
}

+ (UIColor *)web_coral {
    return UIColorFromRGB(0xff7f50);
}

+ (UIColor *)web_goldenrod {
    return UIColorFromRGB(0xdaa520);
}

+ (UIColor *)web_steelblue {
    return UIColorFromRGB(0x406070);
}


#pragma mark private WebColor Aliases
/// ---------------------------------
/// @name private WebColor Aliases
/// ---------------------------------

/**
* gold
*/
+ (UIColor *) web_Gold
{
    return UIColorFromRGB(0xFFD700);
}

/**
* greenyellow
*/
+ (UIColor *) web_Greenyellow
{
    return UIColorFromRGB(0xADFF2F);
}


/**
* yellowgreen
*/
+ (UIColor *) web_Yellowgreen
{
    return UIColorFromRGB(0x9ACD32);
}

/**
* olive
*/
+ (UIColor *) web_Olive
{
    return UIColorFromRGB(0x808000);
}

/**
* olivedrab
*/
+ (UIColor *) web_Olivedrab
{
    return UIColorFromRGB(0x6B8E23);
}

/**
* crimson
*/
+ (UIColor *) web_Crimson
{
    return UIColorFromRGB(0xDC143C);
}

/**
* hotpink
*/
+ (UIColor *) web_Hotpink
{
    return UIColorFromRGB(0xFF1493);
}

/**
* purple
*/
+ (UIColor *) web_Purple
{
    return UIColorFromRGB(0x800080);
}

/**
* goldenrod
*/
+ (UIColor *) web_Goldenrod
{
    return UIColorFromRGB(0xB8860B);
}

/**
* sienna
*/
+ (UIColor *) web_Sienna
{
    return UIColorFromRGB(0xA0522D);
}

/**
* darkslateblue
*/
+ (UIColor *) web_Darkslateblue
{
    return UIColorFromRGB(0x483D8B);
}


/**
 *  private custom definitions
 */


+ (UIColor *) custom_dunkelGrauBraun
{
    return UIColorFromRGB(0x57493D);
}


@end