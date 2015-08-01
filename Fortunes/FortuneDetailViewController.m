//
//  FortuneDetailViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 27.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "FortuneDetailViewController.h"
#import "LabelAutoSize.h"
#import "UIViewController+Layout.h"
#import "UIViewController+NavigationBar.h"

@implementation FortuneDetailViewController {

@private
    LabelAutoSize *lblOriginal;
    UITextView *tvTranslationDe;
    Boolean translationChanged;
    UITextView *currentFocussedTextView;

    CGFloat textMargins;
    CGFloat initialViewYPos;
    CGFloat initialNavBarViewYPos;
    CGFloat initialFortuneViewHeight;
    CGFloat initialTextViewYPos;
}

#pragma mark -
#pragma mark ViewController Lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];

    [self addNavBarButtonWithText:@"Fertig" side:NAV_BAR_BUTTON_SIDE_RIGHT];

    textMargins = 12.0f;

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapFrom:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.delegate = self;

    [self displayFortune];
    [self displayTranslationDe];

    initialViewYPos = self.view.frame.origin.y;
    initialNavBarViewYPos = self.navigationController.navigationBar.frame.origin.y;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*!
    override default navigationBarButton touch
 */
- (void)rightNavigationButtonTouched {

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Content initialization

- (void)displayFortune {

    CGRect originalFrame = self.visibleViewFrame;
    originalFrame.size.height *= 0.35;

    originalFrame.size.height -= textMargins *2;
    originalFrame.size.width -= textMargins *2;
    originalFrame.origin.x += textMargins;
    originalFrame.origin.y += textMargins;

    lblOriginal = [[LabelAutoSize alloc] initWithFrame:originalFrame resizeMode:AUTOLABEL_RESIZE_FONT];
    [self.view addSubview:lblOriginal];

    lblOriginal.text = [_fortune cleanText];
    lblOriginal.textColor = [UIColor whiteColor];
    [lblOriginal adjust];

    initialFortuneViewHeight = lblOriginal.frame.size.height;
}


- (void)displayTranslationDe {

    CGRect translationFrame = self.visibleViewFrame;
    translationFrame.size.height *= 0.4;

    translationFrame.size.width -= 20.0;
    translationFrame.origin.x += 10.0;
    translationFrame.origin.y = (CGFloat) (CGRectGetMaxY(lblOriginal.frame) + 10.0);

    tvTranslationDe = [[UITextView alloc] initWithFrame:translationFrame];
    tvTranslationDe.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    tvTranslationDe.returnKeyType = UIReturnKeyDone;
    tvTranslationDe.delegate = self;
    [self.view addSubview:tvTranslationDe];

    initialTextViewYPos = tvTranslationDe.frame.origin.y;

    tvTranslationDe.text = [_fortune translationDe];

}


#pragma mark -
#pragma mark Text Editing


- (void)textViewDidBeginEditing:(UITextView *)textView {

    currentFocussedTextView = textView;

    CGFloat fortuneScaleFactor = 0.7;
    [lblOriginal setHeight:(float) ([lblOriginal height] * fortuneScaleFactor)];
    lblOriginal.font = [UIFont fontWithName:lblOriginal.font.fontName size:(CGFloat) (lblOriginal.font.pointSize * fortuneScaleFactor)];
    [lblOriginal sizeToFit];

    [tvTranslationDe setY:(float) (CGRectGetMaxY(lblOriginal.frame) + 20.0)];

    [self showNavigationBar:NO];
}


- (void)textViewDidEndEditing:(UITextView *)textView {

    currentFocussedTextView = nil;

    CGRect frTemp = lblOriginal.frame;
    frTemp.size.height = initialFortuneViewHeight;

    lblOriginal.frame = frTemp;
    [lblOriginal adjust];

    [tvTranslationDe setY:initialTextViewYPos];

    [self showNavigationBar:YES];
}


- (void)textViewDidChange:(UITextView *)textView {

    translationChanged = YES;
}


- (void) viewTapFrom:(UIGestureRecognizer*)recognizer {

    if(currentFocussedTextView != nil){
        [currentFocussedTextView resignFirstResponder];
        currentFocussedTextView = nil;
    }
}


- (void)showNavigationBar:(BOOL)show {

    CGRect frView = self.view.frame;
    CGRect frNavBar = self.navigationController.navigationBar.frame;

    if(show) {
        frView.origin.y = initialViewYPos;
        frNavBar.origin.y = initialNavBarViewYPos;
    }
    else {
        frView.origin.y -= 64.0;
        frNavBar.origin.y -= 64.0;
    }


    [UIView animateWithDuration:0.25 delay: 0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = frView;
                         self.navigationController.navigationBar.frame = frNavBar;
                     }
                     completion:^(BOOL finished) {

                         // NSLog(@"Animation beendet bei %f", self.view.frame.origin.y);
                     }];
}


@end
