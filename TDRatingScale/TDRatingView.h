//
//  TDRatingView.h
//  TDRatingControl
//
//  Created by Thavasidurai on 14/02/13.
//  Copyright (c) 2013 JEMS All rights reserved.
//


#import <UIKit/UIKit.h>
@protocol TDRatingViewDelegate <NSObject>

@required
- (void) selectedRating:(NSString *)scale;
@end

@interface TDRatingView : UIView<UIGestureRecognizerDelegate>
{
    NSInteger value;
    BOOL isStar;
    
    UIImageView *containerView;
//    UIView *containerView;
    UIView *sliderView;
    
    id<TDRatingViewDelegate>delegate;
    
}

@property(nonatomic,strong)id<TDRatingViewDelegate>delegate;


-(void)drawRatingControlWithX:(float)x Y:(float)y B:(BOOL)star;
-(void)drawRatingView;
-(void)createContainerView;
-(void)createSliderView;
-(void)calculateAppropriateSelectorXposition:(UIView *)view;
-(void)updateValueWithX:(float)x;
-(void)updateImage;
-(NSInteger)getValue;


@end
