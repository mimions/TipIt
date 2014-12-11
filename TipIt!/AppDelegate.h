//
//  AppDelegate.h
//  TipIt!
//
//  Created by Sara on 11/6/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//extern?
@property (nonatomic, retain) NSNumber *numberOfSplit;
@property (nonatomic, strong) NSNumber *tipPortion;

@property (nonatomic, strong) NSString *folderPath;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *restaurantName;

@property (nonatomic, strong) NSDictionary *stateTaxRate;

@end

