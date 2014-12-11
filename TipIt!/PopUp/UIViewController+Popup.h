//
//  UIViewController+Popup.h
//  TipIt!
//
//  Created by Hongyu Zhu on 11/19/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Popup)

@property (nonatomic, readwrite) UIViewController *popupViewController;
@property (nonatomic, readwrite) BOOL useBlurForPopup;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
- (void)setUseBlurForPopup:(BOOL)useBlurForPopup;
- (BOOL)useBlurForPopup;

@end
