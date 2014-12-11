//
//  TDStar.h
//  TipIt!
//
//  Created by iGuest on 12/9/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TDStar : UIView
{
    UIColor *starCr;
    UIColor *strokeCr;
}
- (id)initWithFrame:(CGRect)theFrame starColor:(UIColor *)starColor strokeColor:(UIColor *)strokeColor;

@end
