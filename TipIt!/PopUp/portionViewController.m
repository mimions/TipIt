//
//  portionViewController.m
//  TipIt!
//
//  Created by Sara on 11/24/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import "portionViewController.h"
#import "AppDelegate.h"

@interface portionViewController ()

@end

@implementation portionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //暂时只做显示灰色用
    UIToolbar *toolbarBackground = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    [self.view addSubview:toolbarBackground];
    [self.view sendSubviewToBack:toolbarBackground];
    
    //set up pickerview
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:_pickerView];
    
    NSArray *dataArray = [[NSArray alloc]initWithObjects:@"0% (Included)",@"1%",@"2%",@"3%",@"4%",@"5%",@"6%",@"7%",@"8%",@"9%",@"10%",@"11%",@"12%",@"13%",@"14%",@"15%",@"16%",@"17%",@"18%",@"19%",@"20%",@"21%",@"22%",@"23%",@"24%",@"25%",@"26%",@"27%",@"28%",@"29%",@"30%", nil];
    self.pickerData = dataArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UIPickerViewDataSource Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
}

#pragma mark - UIPickerViewDelegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *number = [self.pickerData objectAtIndex:row];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.tipPortion = [NSNumber numberWithDouble: [number doubleValue]/100];
    //appDelegate.portion = number;
}

//指定初始显示的行为当前默认split number


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
