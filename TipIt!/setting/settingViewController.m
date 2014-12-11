//
//  settingViewController.m
//  TipIt!
//
//  Created by Sara on 11/25/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import "settingViewController.h"
#import "ChameleonFramework/Chameleon.h"


@interface settingViewController ()

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberFormatter.maximumFractionDigits = 2;
    self.numberFormatter.numberStyle = NSNumberFormatterPercentStyle;

    _whetherRemoveTaxSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"removeTax"] boolValue];
    
    _lunchTipPortionTextfield.text = [self.numberFormatter stringFromNumber:[[NSUserDefaults standardUserDefaults] objectForKey:@"lunchTipPortion"]];
    _dinnerTipPortionTextfield.text = [self.numberFormatter stringFromNumber:[[NSUserDefaults standardUserDefaults] objectForKey:@"dinnerTipPortion"]];
    
    _lunchTipPortionSlider.value = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lunchTipPortion"] floatValue];
    _dinnerTipPortionSlider.value = [[[NSUserDefaults standardUserDefaults] objectForKey:@"dinnerTipPortion"] floatValue];
    

//    _lunchSlider = [[TDRatingView alloc]init];
//    _lunchSlider.delegate = self;
//    [self.view addSubview:_lunchSlider];

    //background color
    UIColor *backgroundColor1 = [UIColor flatRedColor];
    UIColor *backgroundColor2 = [UIColor flatWatermelonColor];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                      withFrame:self.view.bounds
                                                      andColors:@[backgroundColor1, backgroundColor2]];
//    UISlider *sliderA=[[UISlider alloc]initWithFrame:CGRectMake(30, 500, 260, 50)];
//    UIImage *slider_left = [UIImage imageNamed:@"emptystars.png"];
//    UIImageView *gold = [[UIImageView alloc]initWithFrame:CGRectMake(30, 500, 260, 50)];
//    UIImage *goldstar = [UIImage imageNamed:@"goldstars.png"];
//    gold.image = goldstar;
//    UIImage *left = [UIImage imageNamed:@"emptystar.png"];
//    UIImage *right = [UIImage imageNamed:@"goldstar.png"];
//    UIImage *thumb = [UIImage imageNamed:@"trans.png"];
//    [sliderA setMinimumTrackImage:thumb forState:UIControlStateNormal];
//    [sliderA setMaximumTrackImage:slider_left forState:UIControlStateNormal];
//    [sliderA setThumbImage:thumb forState:UIControlStateNormal];
//    [sliderA setMinimumValueImage:left];
//    [sliderA setMaximumValueImage:right];
//        [self.view addSubview:gold];
//    [self.view addSubview:sliderA];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - IBActions

- (IBAction)removeTaxDidSwitch:(UISwitch *)sender {
    
//    BOOL whetherRemoveTax = [[NSUserDefaults standardUserDefaults] objectForKey:@"removeTax"];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:(!whetherRemoveTax)] forKey:@"removeTax"];
//    
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"removeTax"]);
}

- (IBAction)lunchTipPortionDidSlide:(UISlider *)sender {
    
    _lunchTipPortionTextfield.text = [NSString stringWithFormat:@"%.0f %%", sender.value * 100];

    
}

- (IBAction)dinnerTipPortionDidSlide:(UISlider *)sender {
    
    _dinnerTipPortionTextfield.text = [NSString stringWithFormat:@"%.0f %%", sender.value * 100];

}

- (IBAction)settingFinished:(id)sender {
    
    NSNumber *lunch = [NSNumber numberWithFloat:[_lunchTipPortionTextfield.text floatValue] / 100];
    NSNumber *dinner = [NSNumber numberWithFloat:[_dinnerTipPortionTextfield.text floatValue] / 100];
    NSNumber *removeTax = [NSNumber numberWithBool: _whetherRemoveTaxSwitch.on];
    [[NSUserDefaults standardUserDefaults] setObject: removeTax forKey:@"removeTax"];
    [[NSUserDefaults standardUserDefaults] setObject: lunch forKey:@"lunchTipPortion"];
    [[NSUserDefaults standardUserDefaults] setObject: dinner forKey:@"dinnerTipPortion"];
    

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@,%@, %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"lunchTipPortion"], [[NSUserDefaults standardUserDefaults] objectForKey:@"dinnerTipPortion"], [[NSUserDefaults standardUserDefaults] objectForKey:@"removeTax"]);
    
    [[self navigationController] popViewControllerAnimated:YES];

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
