//
//  pickerViewController.h
//  TipIt!
//
//  Created by Sara on 11/11/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface splitPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *pickerData;
}

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;


@end
