//
//  ViewController.m
//  TipIt!
//
//  Created by Sara on 11/6/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import "mainViewController.h"
#import "AppDelegate.h"
#import "UIViewController+Popup.h"
#import "splitPickerViewController.h"
#import "portionViewController.h"
#import "RestaurantListTableViewController.h"
#import "RestaurantListViewController.h"
#import "settingViewController.h"
#import "UIImageView+AFNetworking.h"
#import "YelpClient.h"
#import "ChameleonFramework/Chameleon.h"

//api code
static NSString * const kConsumerKey       = @"HI5UfOMWsR03YN-fVR510A";
static NSString * const kConsumerSecret    = @"JnfWcFUQfTFEBMVTsRupoc35PIw";
static NSString * const kToken             = @"dn6wSKs-2LEpVBsjxTZAX30ZXIfPvgPP";
static NSString * const kTokenSecret       = @"RHkA4gdOWAhvvi_ctNbkF6Vj8o8";


@interface mainViewController ()

@property (assign, nonatomic) NSInteger whichPopupCalled;
@property (assign, nonatomic) BOOL whetherRemoveTax;

#define splitPopup 1;
#define portionPopup 2;
#define listPopup 3;

/*
 *api properties
 */
@property (strong, nonatomic) YelpClient *client;
@property (strong, nonatomic) NSArray *restaurants;
@property (strong, nonatomic) NSArray *filterConfig;
@property (strong, nonatomic) NSString *term;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *cll;
@property (strong, nonatomic) NSString *ll;
@property (strong, nonatomic) UINavigationBar *navBar;

@end


@implementation mainViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    UIColor *backgroundColor1 = [UIColor flatRedColor];
    UIColor *backgroundColor2 = [UIColor flatWatermelonColor];
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                                     withFrame:self.view.bounds
                                                                andColors:@[backgroundColor1, backgroundColor2]];

    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        //judge whether it's first launch
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Welcome"
                                                      message:@"It's your first time with TipIt!"
                                                     delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles:@"Tip Percentage Setup",nil];
        [alert show];
    }

    
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberFormatter.maximumFractionDigits = 2;
    
    //determine tip portion by occation
    if ([self isBetweenFromHour:10 toHour:15])
    {
        self.tipPortion = [[NSUserDefaults standardUserDefaults] objectForKey:@"lunchTipPortion"];
    } else if ([self isBetweenFromHour:15 toHour:24])
    {
        self.tipPortion = [[NSUserDefaults standardUserDefaults] objectForKey:@"dinnerTipPortion"];
    } else
    {
        self.tipPortion = @(0.15);
    }
    self.numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
    _tipPortionLabel.text = [self.numberFormatter stringFromNumber:self.tipPortion];
    
    //gesture for popup view to dismiss
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
    self.useBlurForPopup = NO;
    
    //initiate location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100.;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.geocoder = [CLGeocoder new];
    
    //    _checkAmountTextfield.returnKeyType = UIReturnKeyDone;
    
    //api code
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //set up the slider for split
    _splitSlider = [[TDRatingView alloc]init];
    _splitSlider.delegate = self;
//    [_splitSlider  drawRatingControlWithX:_numberOfPeopleLabel.frame.origin.x- self.view.frame.size.width*0.55 Y:_numberOfPeopleLabel.frame.origin.y+28 B:NO];
    [_splitSlider  drawRatingControlWithX:_numberOfPeopleLabel.frame.origin.x- self.view.frame.size.width*0.53 Y:_numberOfPeopleLabel.frame.origin.y+25 B:NO];
    [self.view addSubview:_splitSlider];
    _splitSlider.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *splitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(splitHandleTap:)];
    [splitTap setNumberOfTapsRequired:1];
    [splitTap setNumberOfTouchesRequired:1];
    [_splitSlider addGestureRecognizer:splitTap];
    
    UIPanGestureRecognizer* splitPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(splitHandlePan:)];
    splitPan.minimumNumberOfTouches = 1;
    splitPan.delegate = self;
    [_splitSlider addGestureRecognizer:splitPan];
    
    
    //set up the slider for tip portion
    _tipSlider = [[TDRatingView alloc]init];
    _tipSlider.delegate = self;
    [_tipSlider  drawRatingControlWithX:_numberOfPeopleLabel.frame.origin.x- self.view.frame.size.width*0.53 Y:_tipPortionLabel.frame.origin.y+25 B:YES];
    [self.view addSubview:_tipSlider];
    _tipSlider.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tipTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipHandleTap:)];
    [tipTap setNumberOfTapsRequired:1];
    [tipTap setNumberOfTouchesRequired:1];
    [_tipSlider addGestureRecognizer:tipTap];
    
    UIPanGestureRecognizer* tipPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tipHandlePan:)];
    tipPan.minimumNumberOfTouches = 1;
    tipPan.delegate = self;
    [_tipSlider addGestureRecognizer:tipPan];
    
    //update tip image according to user's setting
//    NSLog(@"%@",self.tipPortion);
    float p = [self.tipPortion floatValue]*100;
    if (p<11.0) {
        [_tipSlider updateValueWithX:30.0];
    } else if (p<13.5){
        [_tipSlider updateValueWithX:75.0];
    }else if (p<16.5){
        [_tipSlider updateValueWithX:120.0];
    }else if (p<19){
        [_tipSlider updateValueWithX:165.0];
    }else{
        [_tipSlider updateValueWithX:210.0];
    }
    [_tipSlider updateImage];
}


- (void)viewWillAppear:(BOOL)animated {
    
    //determine tip portion by time
    if ([self isBetweenFromHour:10 toHour:15])
    {
        self.tipPortion = [[NSUserDefaults standardUserDefaults] objectForKey:@"lunchTipPortion"];
    } else if ([self isBetweenFromHour:15 toHour:24])
    {
        self.tipPortion = [[NSUserDefaults standardUserDefaults] objectForKey:@"dinnerTipPortion"];
    }
    self.numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
    _tipPortionLabel.text = [self.numberFormatter stringFromNumber:self.tipPortion];
    [self calculateTip];
    float p = [self.tipPortion floatValue]*100;
    if (p<11.0) {
        [_tipSlider updateValueWithX:30.0];
    } else if (p<13.5){
        [_tipSlider updateValueWithX:75.0];
    }else if (p<16.5){
        [_tipSlider updateValueWithX:120.0];
    }else if (p<19){
        [_tipSlider updateValueWithX:165.0];
    }else{
        [_tipSlider updateValueWithX:210.0];
    }
    [_tipSlider updateImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) selectedRating:(NSString *)scale;
{
    //NSLog(@"SelectedRating:::%@",scale);
    //add additional function
}

#pragma mark -
#pragma mark - time determine methods
/*
 * 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @parameter hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //get current time
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}

/**
 * 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:dateFrom] == NSOrderedDescending && [currentDate compare:dateTo] == NSOrderedAscending)
    {
        //NSLog(@"It is between %zd:00-%zd:00 ！", fromHour, toHour);
        return YES;
    }
    return NO;
}

#pragma mark - calculation

- (void)calculateTip
{
    self.checkAmount = [NSNumber numberWithFloat:[_checkAmountTextfield.text floatValue]];
    
    self.whetherRemoveTax = [[[NSUserDefaults standardUserDefaults] objectForKey:@"removeTax"] boolValue];
    //remove tax amount from check amount
    if (self.whetherRemoveTax == YES) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//        if (!appDelegate.stateTaxRate) {
            NSArray *states = [[NSArray alloc]initWithObjects:@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DE",@"FL",@"GA",@"HI",@"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN",@"MS",@"MO",@"MT",@"NE",@"NV",@"NH",@"NJ",@"NM",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",@"TN",@"TX",@"UT",@"VT",@"VA",@"WA",@"WV",@"WI",@"WY", nil];
            NSArray *rates = [[NSArray alloc]initWithObjects:@"4.00%",@"0.00%",@"5.60%",@"6.50%",@"7.50%",@"2.90%",@"6.35%",@"0.00%",@"6.00%",@"4.00%",@"4.00%",@"6.00%",@"6.25%",@"7.00%",@"6.00%",@"6.15%",@"6.00%",@"4.00%",@"5.50%",@"6.00%",@"5.50%",@"6.00%",@"6.88%",@"7.00%",@"4.23%",@"0.00%",@"5.50%",@"6.85%",@"0.00%",@"7.00%",@"5.13%",@"4.00%",@"4.75%",@"5.00%",@"5.75%",@"4.50%",@"0.00%",@"6.00%",@"7.00%",@"6.00%",@"4.00%",@"7.00%",@"6.25%",@"4.70%",@"6.00%",@"4.30%",@"6.50%",@"6.00%",@"5.00%",@"4.00%", nil];
            NSDictionary *stateTaxRate = [[NSDictionary alloc] initWithObjects:rates forKeys:states];
            appDelegate.stateTaxRate = stateTaxRate;
//        }
        NSLog(@"%@",self.stateCode);
        self.currentTaxRate = [appDelegate.stateTaxRate objectForKey:self.stateCode];
        //NSLog(@"%@",self.currentTaxRate);
        
        float tax = [self.currentTaxRate floatValue];
        
        if ([self.city isEqualToString:@"King"]) {
            tax = 9.5;
        }
        NSLog(@"%f",tax);
        self.checkAmount = [NSNumber numberWithFloat:[self.checkAmount floatValue] / (1 + tax/100)];
    }
    
    self.tipPortion = [NSNumber numberWithFloat:[_tipPortionLabel.text floatValue]/100];
    //NSLog(@"%@",self.tipPortion);
    
    self.totalTip = [NSNumber numberWithFloat:[self.checkAmount floatValue] * [self.tipPortion floatValue]];
    self.allTogether = [NSNumber numberWithFloat:([self.checkAmount floatValue] + [self.totalTip floatValue])];
    self.tipPerPerson = [NSNumber numberWithFloat:([self.totalTip floatValue] / [_numberOfPeopleLabel.text integerValue])];
    self.totalPerPerson = [NSNumber numberWithFloat:([self.allTogether floatValue] / [_numberOfPeopleLabel.text integerValue])];
    
    self.numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    _calculatedTipPerPerson.text = [self.numberFormatter stringFromNumber:self.tipPerPerson];
    _calculatedTotalPerPerson.text = [self.numberFormatter stringFromNumber:self.totalPerPerson];
    _calculatedTotalTip.text = [self.numberFormatter stringFromNumber:self.totalTip];
    _calculatedAllTogether.text = [self.numberFormatter stringFromNumber:self.allTogether];
}

#pragma mark - popup methods

- (void)dismissPopup {
    
    if (self.popupViewController != nil) {
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        switch (self.whichPopupCalled) {
            case 1:
                if (appDelegate.numberOfSplit)
                {
                    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
                    _numberOfPeopleLabel.text = [self.numberFormatter stringFromNumber:appDelegate.numberOfSplit];
                }
                break;
            case 2:
                if (appDelegate.tipPortion)
                {
                    self.numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
                    _tipPortionLabel.text = [self.numberFormatter stringFromNumber:appDelegate.tipPortion];
                }
                break;
            case 3:
                if (appDelegate.rating)
                {
                    [_restaurantNameLabel setTitle:appDelegate.restaurantName forState:UIControlStateNormal];
                    _restaurantNameLabel.titleLabel.font = [UIFont systemFontOfSize:18];
                    
                    self.numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
                    float rating = [appDelegate.rating floatValue];
                    //NSLog(@"%f",rating);
                    
                    if (rating <= 2) {
                        _recommendTipPortion.text = [NSString stringWithFormat:@"10%%"];
                    } else if (rating >2 && rating <= 3) {
                        _recommendTipPortion.text = [NSString stringWithFormat:@"15%%"];
                    } else if (rating >3 && rating <= 4){
                        _recommendTipPortion.text = [NSString stringWithFormat:@"18%%"];
                    } else {
                        _recommendTipPortion.text = [NSString stringWithFormat:@"20%%"];
                    }
                }
                break;
            default:
                //NSLog(@"%zd",self.whichPopupCalled);
                break;
        }
        [self dismissPopupViewControllerAnimated:YES completion:^{
            //NSLog(@"popup view dismissed");
        }];
    }
    [self calculateTip];
}


#pragma mark - Yelp API methods

- (void)doSearch:(NSDictionary *)config {
    
    [self.client searchWithConfigs:config success:^(AFHTTPRequestOperation *operation, id response) {
        
        NSDictionary *resp = response;
        self.restaurants = resp[@"businesses"];
        //NSLog(@"%zd",self.restaurants.count);
        //NSLog(@"data, %@", self.restaurants);
        
        RestaurantListViewController *popupTableViewController = [[RestaurantListViewController alloc] initWithNibName:@"RestaurantListViewController" bundle:nil];
        //RestaurantListViewController *popupTableViewController = [[RestaurantListViewController alloc] init];
        
        //        NSInteger rows = self.restaurants.count;
        //        if (rows <= 10) {
        //            popupTableViewController.view.frame = CGRectMake(0, 0, 320, 44*rows);
        //        } else {
        //            popupTableViewController.view.frame = CGRectMake(0, 0, 320, 44*10);
        //        }
        popupTableViewController.data = self.restaurants;
        
        [self presentPopupViewController:popupTableViewController animated:YES completion:^(void) {
            //NSLog(@"popup view presented");
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
}

#pragma mark - Slider actions

- (void)splitHandleTap:(UIPanGestureRecognizer *)recognizer {
    float tappedViewX = [recognizer locationInView:_splitSlider].x;
    [_splitSlider updateValueWithX:tappedViewX];
    [_splitSlider updateImage];
    _numberOfPeopleLabel.text = [NSString stringWithFormat:@"%ld",(long)[_splitSlider getValue]];
     [self calculateTip];
}

- (void)splitHandlePan:(UIPanGestureRecognizer *)recognizer {
    float panViewX = [recognizer locationInView:_splitSlider].x;
    [_splitSlider updateValueWithX:panViewX];
    [_splitSlider updateImage];
    _numberOfPeopleLabel.text = [NSString stringWithFormat:@"%ld",(long)[_splitSlider getValue]];
     [self calculateTip];
}

- (void)tipHandleTap:(UIPanGestureRecognizer *)recognizer {
    float tappedViewX = [recognizer locationInView:_tipSlider].x;
    [_tipSlider updateValueWithX:tappedViewX];
    [_tipSlider updateImage];
    switch ([_tipSlider getValue]) {
        case 1:
            self.tipPortion = @0.1;
            break;
        case 2:
            self.tipPortion = @0.13;
            break;
        case 3:
            self.tipPortion = @0.15;
            break;
        case 4:
            self.tipPortion = @0.18;
            break;
        case 5:
            self.tipPortion = @0.2;
            break;
        default:
            break;
    }
    _tipPortionLabel.text = [NSString stringWithFormat:@"%d%%",(int)([self.tipPortion floatValue]*100)];
     [self calculateTip];
}

- (void)tipHandlePan:(UIPanGestureRecognizer *)recognizer {
    float panViewX = [recognizer locationInView:_tipSlider].x;
    [_tipSlider updateValueWithX:panViewX];
    [_tipSlider updateImage];
    switch ([_tipSlider getValue]) {
        case 1:
            self.tipPortion = @0.1;
            break;
        case 2:
            self.tipPortion = @0.13;
            break;
        case 3:
            self.tipPortion = @0.15;
            break;
        case 4:
            self.tipPortion = @0.18;
            break;
        case 5:
            self.tipPortion = @0.2;
            break;
        default:
            break;
    }
    _tipPortionLabel.text = [NSString stringWithFormat:@"%d%%",(int)([self.tipPortion floatValue]*100)];
    [self calculateTip];
}



#pragma mark - IBActions

- (IBAction)didTapPeopleSplitButton:(id)sender {
    
    self.whichPopupCalled = splitPopup;
    
    splitPickerViewController *popupViewController = [[splitPickerViewController alloc] initWithNibName:@"splitPickerViewController" bundle:nil];
    
    [self presentPopupViewController:popupViewController animated:YES completion:^(void) {
        //NSLog(@"popup view presented");
    }];
    //show default selected row as current value
    if (_numberOfPeopleLabel.text) {
        [popupViewController.pickerView selectRow:[_numberOfPeopleLabel.text integerValue]-1 inComponent:0 animated:YES];
    }
}

- (IBAction)didTapTipPortionButton:(id)sender {
    
    self.whichPopupCalled = portionPopup;
    
    portionViewController *popupViewController = [[portionViewController alloc] initWithNibName:@"portionViewController" bundle:nil];
                                                  
    [self presentPopupViewController:popupViewController animated:YES completion:^(void) {
        //NSLog(@"popup view presented");
    }];
    
    NSString *selectValue = [NSString stringWithFormat:@"%ld%%",(long)[_tipPortionLabel.text integerValue]];
    NSInteger row = [popupViewController.pickerData indexOfObject:selectValue];
    [popupViewController.pickerView selectRow:row inComponent:0 animated:YES];
}

//present restaurant list to user
//根据list长度改popup view的大小？
- (IBAction)didRequestRecommendation:(id)sender {
    
    switch ([CLLocationManager authorizationStatus]) {
        case 3:
        {
            self.whichPopupCalled = listPopup;
            
            //call api
            if (self) {
                self.filterConfig = nil;
                self.term = @"German"; // default query term;
                self.location = @"San Francisco"; // default location
                self.cll = @"37.784702, -122.417564"; //defeault lat/lon
                self.ll = [NSString stringWithFormat:@"%f,%f,%zd", self.coordinate.latitude, self.coordinate.longitude,11];
                // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
                self.client = [[YelpClient alloc] initWithConsumerKey:kConsumerKey consumerSecret:kConsumerSecret accessToken:kToken accessSecret:kTokenSecret];
                
                NSDictionary *config = @{@"term": self.term, @"ll": self.ll};
                [self doSearch: config];
                //        //do search function
            }
        }
            break;
            
        default:
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Notice"
                                                          message:@"In order to be recommended about tip percentage, please open this app's settings and set location access to 'Always'."
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
            [alert show];
            
        }
            break;
    }
    

    
}

//- (IBAction)didTapCalculateButton:(id)sender {
//    
//    [_checkAmountTextfield resignFirstResponder];
//    [self calculateTip];
//}


- (IBAction)backgroundButtonTapped:(UIButton *)sender {
    [_checkAmountTextfield resignFirstResponder];
    [self calculateTip];
}

- (IBAction)clearAllNumbers:(id)sender {
    _checkAmountTextfield.text = @"";
    _calculatedTipPerPerson.text = @"";
    _calculatedTotalPerPerson.text = @"";
    _calculatedTotalTip.text = @"";
    _calculatedAllTogether.text = @"";
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            //present setting page at initial launch
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
                //NSLog(@"didDismissWithButtonIndex");
                
                //        settingViewController *settingVC = [[settingViewController alloc] init];
                //        [self.navigationController pushViewController:settingVC animated:YES];
                //        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"toSettingView" source:self destination:settingVC];
                
                //use segue
                [self performSegueWithIdentifier:@"toSettingView" sender:self];
                
                //use storyboard id
                //        UIStoryboard *theStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                //        settingViewController *setting = [theStoryboard instantiateViewControllerWithIdentifier:@"setting"];
                //        [self presentViewController:setting animated:YES completion:nil];
                
            }
            break;
            
        default:
            break;
    }

}


#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [_checkAmountTextfield becomeFirstResponder];
    _checkAmountTextfield.returnKeyType = UIReturnKeyDone;
}


#pragma mark - UIGestureRecognizerDelegate
// so that tapping popup view doesnt dismiss it
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    BOOL b = (touch.view != self.popupViewController.view);
    //NSLog(@"%zd",self.popupViewController.view.subviews.count);
    for (UIView *view in self.popupViewController.view.subviews) {
        //NSLog(@"%@",view.class);
        //if tap on subviews like PickerView
        //b = NO
        b = (touch.view != view) && (touch.view != self.popupViewController.view);
        //UITableView -> UITableViewWrapperView ->UITableViewCell
        if ([view isKindOfClass:[UITableView class]]) {
            //NSLog(@"yes");
            for (UIView *subview in view.subviews){
                //NSLog(@"%@",subview);
                //NSLog(@"%@",subview.subviews);
                b = (touch.view != subview);
                for (UIView *subsubview in subview.subviews){
                    //NSLog(@"%@",subsubview);
                    //if tap on cell
                    //b = NO
                    b = (touch.view != subsubview) && (touch.view != ((UITableViewCell *)subsubview).contentView);
                    if (b == false) {
                        break;
                    }
                }
                if (b == false) {
                    break;
                }
            }
        }
        if (b == false) {
            break;
        }
    }
    return b;
    //return (touch.view != self.popupViewController.view);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //NSLog(@"%zd",[CLLocationManager authorizationStatus]);
    
    CLLocation *location = locations[0];
    self.coordinate = location.coordinate;
    
    if (self.geocoder.isGeocoding) {
        [self.geocoder cancelGeocode];
    }
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks) {
            for (CLPlacemark *placemark in placemarks){
                NSLog(@"%@", placemark);
                self.city = placemark.subAdministrativeArea;
                self.stateCode = placemark.administrativeArea;
            }
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }];

}

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    //NSLog(@"%zd",[CLLocationManager authorizationStatus]);
}

#pragma mark -
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toSettingView"]) {
        //settingViewController *destination = segue.destinationViewController;
    }
}

@end
