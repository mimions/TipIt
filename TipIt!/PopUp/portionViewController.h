//
//  portionViewController.h
//  TipIt!
//
//  Created by Sara on 11/24/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface portionViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;


@end
