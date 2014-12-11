//
//  RestaurantListViewController.h
//  TipIt!
//
//  Created by Sara on 12/10/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end
