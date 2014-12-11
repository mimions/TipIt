//
//  TDRatingView.m
//  TDRatingControl
//
//  Created by Thavasidurai on 14/02/13.
//  Copyright (c) 2013 JEMS All rights reserved.
//

#import "TDRatingView.h"
#import "TDArrow.h"
#import "TDStar.h"
#import <QuartzCore/QuartzCore.h>

#define spaceBetweenSliderandRatingView 0
@implementation TDRatingView

- (id)init {
    self = [super init];
    return self;
}

#pragma mark - Draw Rating Control

-(void)drawRatingControlWithX:(float)x Y:(float)y B:(BOOL)star;
{
    float width =  250;
    float height = 35;
    self.frame = CGRectMake(x, y, width, height);
    isStar = star;
    [self createContainerView];
    
}
-(void)createContainerView
{
    //Container view
    containerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 35)];
    if(isStar){
        containerView.image = [UIImage imageNamed:@"0star.png"];
    } else {
        containerView.image = [UIImage imageNamed:@"1people.png"];
    }
    containerView.userInteractionEnabled = YES;
    [self addSubview:containerView];
    
//    //handle tapping gesture
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    [singleTap setNumberOfTapsRequired:1];
//    [singleTap setNumberOfTouchesRequired:1];
//    [containerView addGestureRecognizer:singleTap];
//    
//    //handle  sliding gesture
//    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    panRecognizer.minimumNumberOfTouches = 1;
//    panRecognizer.delegate = self;
//    [containerView addGestureRecognizer:panRecognizer];
}

- (void)handleTap:(UIPanGestureRecognizer *)recognizer {
    
    //Accessing tapped view
    float tappedViewX = [recognizer locationInView:containerView].x;
    [self updateValueWithX:tappedViewX];
    [self updateImage];
//    value = 1+(tappedViewX -13)/46;
//    if (value>0 && value<6) {
//        NSString *img = [NSString stringWithFormat:@"%ldstar.png",(long)value];
//        containerView.image = [UIImage imageNamed:img];
//    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    float panViewX = [recognizer locationInView:containerView].x;
    [self updateValueWithX:panViewX];
    [self updateImage];
//    value = 1+(panViewX -13)/46;
//    if (value>0 && value<6) {
//        NSString *img = [NSString stringWithFormat:@"%ldstar.png",(long)value];
//        containerView.image = [UIImage imageNamed:img];
//    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self updateImage];
    }
    
}

- (NSInteger)getValue
{
    return value;
}

-(void)updateValueWithX:(float)x
{
    value = 1+(x -13)/46;
    if (value<1) {
        value=1;
    } else if (value>5){
        value =5;
    }
}

-(void)updateImage
{
    if (value>0 && value<6) {
        NSString *img;
        if (isStar) {
            img = [NSString stringWithFormat:@"%ldstar.png",(long)value];
        } else {
            img = [NSString stringWithFormat:@"%ldpeople.png",(long)value];
        }
        containerView.image = [UIImage imageNamed:img];
    }
}

    

//-(void)createSliderView
//{
////    float y =  (self.heightOfEachNo  + self.sliderHeight) + spaceBetweenSliderandRatingView;
//    float y = self.heightOfEachNo;
////    float height = self.sliderHeight - (2*spaceBetweenSliderandRatingView);
//    float height = self.heightOfEachNo;
//    sliderView = [[UIView alloc]initWithFrame:CGRectMake(self.spaceBetweenEachNo, 0, self.widthOfEachNo, self.frame.size.height )];
//    sliderView.layer.shadowColor = [[UIColor clearColor] CGColor];
//    sliderView.layer.borderColor = [[UIColor clearColor] CGColor];
//    sliderView.layer.borderWidth = 1.0f;
//    [self insertSubview:sliderView aboveSubview:containerView];
//    
    //set up star
//    UIRectFill([sliderView bounds]);
//    //拿到当前视图准备好的画板
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextBeginPath(context);//标记
//    CGContextMoveToPoint(context, 0, 0);//设置起点
//    CGContextAddLineToPoint(context, 165, 0);
//    CGContextAddLineToPoint(context, 165, 105);
//    CGContextClosePath(context);//路径结束标志，不写默认封闭
//    [[UIColor yellowColor] setStroke]; //设置边框颜色
//    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
//    
//    UIView *star = [[UIView alloc]initWithFrame:CGRectMake(0-self.widthOfEachNo*0.22, y-self.widthOfEachNo*0.38, self.widthOfEachNo *2.5, height*2)];
//    [sliderView addSubview:star];
//    TDStar *starview = [[TDStar alloc]initWithFrame:CGRectMake(0, 0, star.frame.size.width, star.frame.size.height) starColor:[UIColor clearColor] strokeColor:[UIColor redColor]];
//    [star addSubview:starview];
//    
//    UIView *upArrow = [[UIView alloc]initWithFrame:CGRectMake(0, y, self.widthOfEachNo, height)];
//    upArrow.backgroundColor = [UIColor clearColor];
//    [sliderView addSubview:upArrow];
//    
//    TDArrow *triangleUp = [[TDArrow alloc]initWithFrame:CGRectMake(0, 0, upArrow.frame.size.width, upArrow.frame.size.height) arrowColor:self.arrowColor strokeColor:self.sliderBorderColor isUpArrow:YES];
//    [upArrow addSubview:triangleUp];
//    
//    
//    UIView *downArrow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.widthOfEachNo, height)];
//    downArrow.backgroundColor = [UIColor clearColor];
//    [sliderView addSubview:downArrow];
//    
//    TDArrow *triangleDown = [[TDArrow alloc]initWithFrame:CGRectMake(0, 0, upArrow.frame.size.width, upArrow.frame.size.height) arrowColor:self.arrowColor strokeColor:self.sliderBorderColor isUpArrow:NO];
//    [sliderView addSubview:triangleDown];
//    
    //handle  sliding gesture
//    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    panRecognizer.minimumNumberOfTouches = 1;
//    panRecognizer.delegate = self;
//    [sliderView addGestureRecognizer:panRecognizer];
    
//    [self drawRatingView];
//    
//}

//-(void)drawRatingView
//{
//    float itemX = self.spaceBetweenEachNo;
//    float itemY = 0;
//    int differ = self.minimumRating;
//    //creating items
//    itemsAry = [NSMutableArray new];
//    itemsXPositionAry = [NSMutableArray new];
//    for (int i =self.minimumRating; i<self.maximumRating+1; i = i+self.difference) {
//        
//        UILabel *lblMyLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemX, itemY, self.widthOfEachNo, self.heightOfEachNo)];
//        lblMyLabel.numberOfLines = 0;
//        lblMyLabel.tag=i;
//        lblMyLabel.backgroundColor = [UIColor clearColor];
//        lblMyLabel.textAlignment = UITextAlignmentCenter;
//        lblMyLabel.text = [NSString stringWithFormat:@"%d",differ];
//        differ = differ + self.difference;
//        
//        lblMyLabel.textColor = self.disableStateTextColor;
//        
//        lblMyLabel.layer.shadowColor = [lblMyLabel.textColor CGColor];
//        lblMyLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
//        lblMyLabel.layer.shadowRadius = 2.0;
//        lblMyLabel.layer.shadowOpacity = 0.3;
//        lblMyLabel.layer.masksToBounds = NO;
//        lblMyLabel.userInteractionEnabled = YES;
//        [containerView addSubview:lblMyLabel];
//        itemX = lblMyLabel.frame.origin.x + self.widthOfEachNo + self.spaceBetweenEachNo;
//        [itemsAry addObject:lblMyLabel];
//        [itemsXPositionAry addObject:[NSString stringWithFormat:@"%f",lblMyLabel.frame.origin.x]];
//        
        //handle single tap gesture
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//        [singleTap setNumberOfTapsRequired:1];
//        [singleTap setNumberOfTouchesRequired:1];
//        [lblMyLabel addGestureRecognizer:singleTap];
//
//    }
//    
//    UILabel *firstLbl = [itemsAry objectAtIndex:0];
//    firstLbl.textColor = self.selectedStateTextColor;
//    
//    
//}
//-(void)changeTextColor:(UILabel *)myLbl
//{
//    myLbl.textColor = self.selectedStateTextColor;
//}
    
    
//    //Moving one place to another place animation
//    [UIView beginAnimations:@"MoveView" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:0.5f];
//    CGRect sliderFrame = sliderView.frame;
//    sliderFrame.origin.x = tappedViewX;
//    sliderView.frame = sliderFrame;
//    [UIView commitAnimations];
//    
//    for(UILabel *mylbl in itemsAry) // Use fast enumeration to iterate through the array
//    {
//        if (mylbl.textColor == self.selectedStateTextColor) {
//            
//            mylbl.textColor = self.disableStateTextColor;
//            
//        }
//    }
    
//    float selectedViewX =sliderView.frame.origin.x;
//    //finding index position of selected view
//    NSUInteger index = [itemsXPositionAry indexOfObject:[NSString stringWithFormat:@"%f",selectedViewX]];
//    UILabel *myLabel = [itemsAry objectAtIndex:index];
//    [self performSelector:@selector(changeTextColor:) withObject:myLabel afterDelay:0.5];
//    [delegate selectedRating:myLabel.text];
//    }

#pragma mark - Calculate position

@end
