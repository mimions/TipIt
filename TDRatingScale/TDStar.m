//
//  TDStar.m
//  TipIt!
//
//  Created by iGuest on 12/9/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import "TDStar.h"

@implementation TDStar

- (id)initWithFrame:(CGRect)theFrame starColor:(UIColor *)starColor strokeColor:(UIColor *)strokeColor;
{
    self = [super initWithFrame:theFrame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        starCr =starColor;
        strokeCr = strokeColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Get the current graphics context
    // (ie. where the drawing should appear)
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Begin the path
    CGContextBeginPath(context);
    
    NSInteger r,x,y;
    r=20;
    y = 20;
    x = 21;
    CGContextMoveToPoint(context, 0 + x,0 + y - r);
    CGContextAddLineToPoint(context, -r* 1/(tan(72 * M_PI /180)+tan(54* M_PI /180))+ x, -r* cos(72 * M_PI / 180)+ y);
    
    
    CGContextAddLineToPoint(context, -r* sin(72 * M_PI / 180)+ x, -r* cos(72 * M_PI / 180)+ y);
    CGContextAddLineToPoint(context,
                            -r*cos(18 * M_PI / 180)/((tan(72 * M_PI /180)+tan(54* M_PI /180))*sin(36 * M_PI / 180)) + x,
                            r*sin(18 * M_PI / 180)/((tan(72 * M_PI /180)+tan(54* M_PI /180))*sin(36 * M_PI / 180)) + y);
    
    CGContextAddLineToPoint(context, -r * sin(36 * M_PI /180) + x, r* cos(36 * M_PI / 180)+ y);
    CGContextAddLineToPoint(context, 0 + x, r/((tan(72 * M_PI /180)+tan(54* M_PI /180))*sin(36 * M_PI / 180)) + y);
    
    CGContextAddLineToPoint(context, r* sin(36 * M_PI / 180)+ x, r* cos(36 * M_PI / 180)+ y);
    CGContextAddLineToPoint(context,
                            r*cos(18 * M_PI / 180)/((tan(72 * M_PI /180)+tan(54* M_PI /180))*sin(36 * M_PI / 180)) + x,
                            r*sin(18 * M_PI / 180)/((tan(72 * M_PI /180)+tan(54* M_PI /180))*sin(36 * M_PI / 180)) + y);
    
    
    
    CGContextAddLineToPoint(context, r* sin(72 * M_PI / 180) + x, -r* cos(72 * M_PI / 180) + y);
    CGContextAddLineToPoint(context, r* 1/(tan(72 * M_PI /180)+tan(54* M_PI /180))+ x, -r* cos(72 * M_PI / 180) + y);
    
    
//    CGContextAddLineToPoint(context, -r * sin(36 * M_PI /180) + x, r* cos(36 * M_PI / 180)+ y);
//    CGContextAddLineToPoint(context, r* sin(72 * M_PI / 180) + x, -r* cos(72 * M_PI / 180) + y);
//    CGContextAddLineToPoint(context, -r* sin(72 * M_PI / 180)+ x, -r* cos(72 * M_PI / 180)+ y);
//    CGContextAddLineToPoint(context, r* sin(36 * M_PI / 180)+ x, r* cos(36 * M_PI / 180)+ y);


    NSLog(@"exe_______________________________________");
//    if (1) {
//        
//        // Starting Point
//        CGContextMoveToPoint(context, rect.size.width/2,0);
//        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//        CGContextAddLineToPoint(context, 0, rect.size.height);
//        // Close the path
//        
//    }
//    else
//    {
//        // Starting Point
//        CGContextMoveToPoint(context, 0,0);
//        CGContextAddLineToPoint(context, rect.size.width, 0);
//        CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height);
//        // Close the path
//        
//    }
    // Closing the path will extending a line from
    CGContextClosePath(context);
    // Set line width
    CGContextSetLineWidth(context, 2.0);
    // Set colour using RGB intensity values
    CGContextSetFillColorWithColor(context, starCr.CGColor);
    CGContextSetStrokeColorWithColor(context, strokeCr.CGColor);
    //Draw on the screen
    CGContextDrawPath(context, kCGPathFillStroke);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
