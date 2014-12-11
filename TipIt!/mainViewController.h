//
//  ViewController.h
//  TipIt!
//
//  Created by Sara on 11/6/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDRatingView.h"

@import CoreLocation;

@interface mainViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate, UIPickerViewDelegate, CLLocationManagerDelegate, TDRatingViewDelegate>

@property (strong, nonatomic) TDRatingView *splitSlider;
@property (strong, nonatomic) TDRatingView *tipSlider;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *stateCode;

@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

@property (strong, nonatomic) NSNumber *currentTaxRate;
@property (strong, nonatomic) NSNumber *checkAmount;
@property (strong, nonatomic) NSNumber *tipPortion;
@property (strong, nonatomic) NSNumber *tipPerPerson;
@property (strong, nonatomic) NSNumber *totalPerPerson;
@property (strong, nonatomic) NSNumber *totalTip;
@property (strong, nonatomic) NSNumber *allTogether;

@property (weak, nonatomic) IBOutlet UITextField *checkAmountTextfield;

@property (weak, nonatomic) IBOutlet UIButton *checkAmountButton;

@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;

@property (weak, nonatomic) IBOutlet UIButton *numberOfPeopleSplit;

@property (weak, nonatomic) IBOutlet UILabel *tipPortionLabel;

@property (weak, nonatomic) IBOutlet UIButton *tipPortionButton;

@property (weak, nonatomic) IBOutlet UILabel *recommendTipPortion;

@property (weak, nonatomic) IBOutlet UIButton *restaurantNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *calculatedTipPerPerson;

@property (weak, nonatomic) IBOutlet UILabel *calculatedTotalPerPerson;

@property (weak, nonatomic) IBOutlet UILabel *calculatedTotalTip;

@property (weak, nonatomic) IBOutlet UILabel *calculatedAllTogether;

//@property (weak, nonatomic) IBOutlet UIButton *calculateButton;


- (IBAction)backgroundButtonTapped:(UIButton *)sender;

- (IBAction)didTapPeopleSplitButton:(id)sender;

- (IBAction)didTapTipPortionButton:(id)sender;

- (IBAction)didRequestRecommendation:(id)sender;

//- (IBAction)didTapCalculateButton:(id)sender;

- (IBAction)clearAllNumbers:(id)sender;


@end

