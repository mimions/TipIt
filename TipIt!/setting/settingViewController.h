//
//  settingViewController.h
//  TipIt!
//
//  Created by Sara on 11/25/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDRatingView.h"

@interface settingViewController : UIViewController<TDRatingViewDelegate>

@property (strong, nonatomic) TDRatingView *lunchSlider;
@property (strong, nonatomic) TDRatingView *dinnerSlider;

@property (strong, nonatomic) NSNumberFormatter *numberFormatter;


@property (weak, nonatomic) IBOutlet UISwitch *whetherRemoveTaxSwitch;

@property (weak, nonatomic) IBOutlet UITextField *lunchTipPortionTextfield;

@property (weak, nonatomic) IBOutlet UITextField *dinnerTipPortionTextfield;

@property (weak, nonatomic) IBOutlet UISlider *lunchTipPortionSlider;

@property (weak, nonatomic) IBOutlet UISlider *dinnerTipPortionSlider;


- (IBAction)removeTaxDidSwitch:(UISwitch *)sender;

- (IBAction)lunchTipPortionDidSlide:(UISlider *)sender;

- (IBAction)dinnerTipPortionDidSlide:(UISlider *)sender;

- (IBAction)settingFinished:(id)sender;


@end
