//
//  AppDelegate.m
//  TipIt!
//
//  Created by Sara on 11/6/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import "AppDelegate.h"
#import "mainViewController.h"
#import "ChameleonFramework/Chameleon.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    [self registerStandardDefaults];
    self.stateTaxRate = [self acquireTaxRateData];
    
    //trigger mainViewController - trigger authentication
    [mainViewController new];

    [[UINavigationBar appearance] setBarTintColor:[UIColor flatRedColor]];

    [[UINavigationBar appearance] setTranslucent:NO];

    return YES;
}

- (void)registerStandardDefaults
{
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:@"removeTax"];
    
    [defaultValues setObject:[NSNumber numberWithDouble:0.15] forKey:@"lunchTipPortion"];
    [defaultValues setObject:[NSNumber numberWithDouble:0.20] forKey:@"dinnerTipPortion"];
    [defaultValues setObject:[NSNumber numberWithInteger:1] forKey:@"splitNumber"];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

- (NSString *)applicationDocumentsFolderName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths firstObject];
    NSParameterAssert(documentsPath);
    NSLog(@"%@",documentsPath);
    self.folderPath = documentsPath;
    return documentsPath;
}

- (NSDictionary *)acquireTaxRateData
{
//    NSMutableDictionary *stateTaxRate = [[NSMutableDictionary alloc] init];
//    //Transform csv file into array
//    NSString *path = [[self applicationDocumentsFolderName] stringByAppendingString:@"/statetax.csv"];
//    NSString *contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSArray *contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
//    //NSLog(@"%@",contentsArray);
//    
//    for (NSInteger index = 1; index < contentsArray.count; index++) {
//        NSString *singleRowContent = [contentsArray objectAtIndex:index];
//        //NSLog(@"%@",singleRowContent);
//        if (![singleRowContent  isEqual: @""]) {
//            NSArray *singleRowArray = [singleRowContent componentsSeparatedByString:@","];
//            //NSLog(@"%@,%@,%@,%@",singleRowArray,singleRowArray[0],singleRowArray[1],singleRowArray[2]);
//            
//            [stateTaxRate setValue:singleRowArray[2] forKey:singleRowArray[1]];
//        }
//    }
//    //NSLog(@"%@", stateTaxRate);
//    if (stateTaxRate.count == 0) {
//        return nil;
//    } else {
//        return stateTaxRate;
//    }
    
    //need to change data acquire method
    //
    NSArray *states = [[NSArray alloc]initWithObjects:@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DE",@"FL",@"GA",@"HI",@"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN",@"MS",@"MO",@"MT",@"NE",@"NV",@"NH",@"NJ",@"NM",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",@"TN",@"TX",@"UT",@"VT",@"VA",@"WA",@"WV",@"WI",@"WY", nil];
    NSArray *rates = [[NSArray alloc]initWithObjects:@"4.00%",@"0.00%",@"5.60%",@"6.50%",@"7.50%",@"2.90%",@"6.35%",@"0.00%",@"6.00%",@"4.00%",@"4.00%",@"6.00%",@"6.25%",@"7.00%",@"6.00%",@"6.15%",@"6.00%",@"4.00%",@"5.50%",@"6.00%",@"5.50%",@"6.00%",@"6.88%",@"7.00%",@"4.23%",@"0.00%",@"5.50%",@"6.85%",@"0.00%",@"7.00%",@"5.13%",@"4.00%",@"4.75%",@"5.00%",@"5.75%",@"4.50%",@"0.00%",@"6.00%",@"7.00%",@"6.00%",@"4.00%",@"7.00%",@"6.25%",@"4.70%",@"6.00%",@"4.30%",@"6.50%",@"6.00%",@"5.00%",@"4.00%", nil];
    NSDictionary *stateTaxRate = [[NSDictionary alloc] initWithObjects:rates forKeys:states];
    NSLog(@"%@",stateTaxRate);
    NSLog(@"%zd",stateTaxRate.count);
    return stateTaxRate;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
