//
// Created by Heiko Bublitz on 09.01.15.
// Copyright (c) 2015 Fast Gesund. All rights reserved.
//

/*!
 @discussion UIColor+Presets -
 the public class methods are used by the UI for standardized colouring


__Created__: 2014-12-15

 __Doc Created__: 22. Jan 2015

 __Developer__: Heiko Bublitz, KrisKo Apps

 */
@interface UIColor (Presets)

+ (NSArray *)getPrefixes;


#pragma mark Public Methods
/// ---------------------------------
/// @name Public Methods
/// ---------------------------------

/** color preset black with transparency */
+ (UIColor *)preset_backGroundBlackWithAlpha:(CGFloat)alpha;
/** color preset main ui color, navi bar, toolbar, etc. */
+ (UIColor *)presetBase;
/** color preset emphasised elemnts */
+ (UIColor *)presetHighlight;
/** color preset light text */
+ (UIColor *)presetLightText;
/** color preset dark text */
+ (UIColor *)presetDarkText;

+ (UIColor *)presetItemSelected;

+ (UIColor *)presetItemBackground;

/** color preset text color for editing mode */
+ (UIColor *)presetEditModeTextColor;

/** color preset red button background */
+ (UIColor *)presetButtonRed;
/** color preset green button background */
+ (UIColor *)presetButtonGreen;
/** color preset my own items background */
+ (UIColor *)presetItemBGMine;
/** color preset foreign users item background */
+ (UIColor *)presetItemBGOthers;
/** color preset incomplete item background */
+ (UIColor *)presetItemBGIncomplete;


@end