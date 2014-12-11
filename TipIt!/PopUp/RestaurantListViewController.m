//
//  RestaurantListViewController.m
//  TipIt!
//
//  Created by Sara on 12/10/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "AppDelegate.h"
#import "mainViewController.h"

@interface RestaurantListViewController ()

@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    // Configure the cell...
    NSDictionary *restaurant = [self.data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [restaurant objectForKey:@"name"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *restaurant = [self.data objectAtIndex:indexPath.row];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.rating = [restaurant objectForKey:@"rating"];
    appDelegate.restaurantName = [restaurant objectForKey:@"name"];
//    mainViewController *mainVC = [[mainViewController alloc] init];
//    [self.navigationController pushViewController:mainVC animated:YES];
//    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"backToMain" source:self destination:mainVC];
//    [self performSegueWithIdentifier:@"backToMain" sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)dismiss:(id)sender {
//    mainViewController *main = self.presentingViewController;
//    [main dismissViewControllerAnimated:YES completion:nil];
//}
@end
