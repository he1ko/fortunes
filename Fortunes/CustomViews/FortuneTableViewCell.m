//
//  FortuneTableViewCell.m
//  Fortunes
//
//  Created by Heiko Bublitz on 22.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "FortuneTableViewCell.h"
#import "SingleFortune.h"
#import "SingleFortune+Favourites.h"
#import "LabelAutoSize.h"

static CGFloat const LeftPanelWidth = 45.0f;
static CGFloat const TextViewMargin = 12.0f;
static CGFloat const favButtonOpacityActive = 1.0f;
static CGFloat const favButtonOpacityInactive = 0.2f;

@interface FortuneTableViewCell ()

- (void)addTextLabel;

- (void)addSourceLabel;

- (CGRect)applyMarginToTextFrame:(CGRect)textFrame;

- (void)addLeftPanel;

- (void)addBottomline;

- (UILabel *)languageLabel;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
@end



@implementation FortuneTableViewCell {

@private
    UIColor *colorCellBackground;
    UIColor *colorCellBackgroundSelected;
    UIColor *colorText;
    UIColor *colorSource;
    UIColor *colorNoSource;

    SingleFortune *myFortune;
    LabelAutoSize *lblText;
    UILabel *lblSource;
    CGFloat myHeight;
    UIView *leftPanel;
    UIButton *btFav;

    UIFont *fortuneFont;
    UIFont *sourceFont;
}



- (id)initWithFortune:(SingleFortune *)fortune fortuneFont:(UIFont *)_fortuneFont sourceFont:(UIFont *)_sourceFont reuseIdentifier:(NSString *)reuseIdentifier {

    fortuneFont = _fortuneFont;
    sourceFont = _sourceFont;

    self = [self initWithStyle:UITableViewCellStyleDefault fortune:fortune reuseIdentifier:reuseIdentifier];

    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style fortune:(SingleFortune *)fortune reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {

        myFortune = fortune;

        colorCellBackground = [UIColor presetHighlight];
        colorCellBackgroundSelected = [UIColor orangeColor];
        colorText = [UIColor whiteColor];
        colorSource = [UIColor blackColor];
        colorNoSource = [UIColor preset_backGroundBlackWithAlpha:0.5];

        self.contentView.backgroundColor = colorCellBackground;

        [self addTextLabel];
        [self addSourceLabel];

        myHeight = [self getHeight];

        [self addLeftPanel];
        [self addBottomline];
    }
    return self;
}


- (CGFloat)getHeight {

    CGFloat cellHeight = CGRectGetMaxY(lblText.frame) + TextViewMargin + lblSource.frame.size.height + TextViewMargin;
    myHeight = cellHeight;
    return cellHeight;
}


- (void)addTextLabel {

    CGRect textFrame = self.contentView.frame;
    textFrame.origin = CGPointMake(LeftPanelWidth, 0.0);
    textFrame.size.width -= LeftPanelWidth;

    textFrame = [self applyMarginToTextFrame:textFrame];

    lblText = [[LabelAutoSize alloc] initWithFrame:textFrame resizeMode:AUTOLABEL_RESIZE_HEIGHT];
    lblText.textColor = colorText;
    lblText.backgroundColor = [UIColor clearColor];
    lblText.text = [myFortune cleanText];
    lblText.font = fortuneFont;
    [lblText adjust];

    [self.contentView addSubview:lblText];
}

- (void)addSourceLabel {

    CGRect sourceFrame = self.contentView.frame;
    sourceFrame.origin = CGPointMake(LeftPanelWidth, CGRectGetMaxY(lblText.frame) + TextViewMargin);
    sourceFrame.size.height = 12.0;
    sourceFrame.size.width -= LeftPanelWidth;
    sourceFrame.size.width -= TextViewMargin *2;
    sourceFrame.origin.x += TextViewMargin;

    lblSource = [[UILabel alloc] initWithFrame:sourceFrame];
    lblSource.font = sourceFont;
    lblSource.textAlignment = NSTextAlignmentCenter;
    lblSource.backgroundColor = [UIColor clearColor];

    if([myFortune.source isEqualToString:@""]) {
        lblSource.text = @"unbekannte Quelle";
        lblSource.textColor = colorNoSource;
    }
    else {
        lblSource.text = myFortune.source;
        lblSource.textColor = colorSource;
    }

    [self.contentView addSubview:lblSource];
}

- (CGRect)applyMarginToTextFrame:(CGRect)textFrame {

    textFrame.origin.x += TextViewMargin;
    textFrame.size.width -= TextViewMargin * 2;
    textFrame.origin.y = TextViewMargin;
    textFrame.size.height -= TextViewMargin *2;

    return textFrame;
}

- (void)addLeftPanel {

    CGRect panelFrame = self.contentView.frame;
    panelFrame.size.width = LeftPanelWidth;
    panelFrame.size.height = myHeight;

    leftPanel = [[UIView alloc] initWithFrame:panelFrame];
    leftPanel.backgroundColor = [UIColor preset_backGroundBlackWithAlpha:0.2];

    UILabel *lblLangEN = [self languageLabel];
    lblLangEN.text = @"EN";
    [lblLangEN setX:0.0];
    [lblLangEN setY:14.0];
    [leftPanel addSubview:lblLangEN];

    btFav = [self favouritesButtonInFrame:panelFrame];
    [leftPanel addSubview:btFav];

    [self.contentView addSubview:leftPanel];
}

- (void)addBottomline {

    UIView *line = [[UIView alloc] initWithFrame:self.contentView.frame];
    [line setHeight:1.0];
    [line setY:(float) (myHeight - 1.0)];
    line.backgroundColor = [UIColor preset_backGroundBlackWithAlpha:0.2];
    [self.contentView addSubview:line];
}


- (UIButton *)favouritesButtonInFrame:(CGRect)frame {

    UIButton *bt = [myFortune favListImageButton];
    [bt setY:myHeight - bt.frame.size.height - 6];
    [bt setX:(frame.size.width - bt.frame.size.width) / 2];
    [bt addTarget:self action:@selector(favouritesButtonTouch) forControlEvents:UIControlEventTouchUpInside];

    return bt;
}


- (UILabel *)languageLabel {

    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, LeftPanelWidth, 12.0)];
    lbl.textColor = [UIColor darkGrayColor];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:9.0];
    lbl.textAlignment = NSTextAlignmentCenter;

    return lbl;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    if(selected) {
        self.contentView.backgroundColor = colorCellBackgroundSelected;
    }
    else {
        self.contentView.backgroundColor = colorCellBackground;
    }

    //[super setSelected:selected animated:animated];
}

- (void) setFortune:(SingleFortune *)fortune {

    lblText.text = [fortune cleanText];
    lblSource.text = fortune.source;

    [lblText adjust];
}


- (NSString *)getFortuneFontName {
    return lblText.font.fontName;
}


- (NSString *)getSourceFontName {
    return lblSource.font.fontName;
}


- (void)favouritesButtonTouch {

    if([myFortune isFavourite]) {
        [myFortune removeFromFavourites];
        [btFav setAlpha:favButtonOpacityInactive];
    }
    else {
        [myFortune setToFavourite];
        [btFav setAlpha:favButtonOpacityActive];
    }
}

@end
