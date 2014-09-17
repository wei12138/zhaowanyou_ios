//
//  RJAlertView.m
//  RJAlertView
//
//  Created by jun on 14-6-4.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//


/*Default Colors*/


#define screenBounds [[UIScreen mainScreen] bounds]
#define IS_IOS7_Or_Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#import "RJBlurAlertView.h"

@interface RJBlurAlertView ()

@property (nonatomic,strong) GPUImageiOSBlurFilter *blurFilter;

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIImageView *backgroundView;

@property (nonatomic,assign) CGSize contentSize;

@property (nonatomic,strong) UIView *contentView;
@end

@implementation RJBlurAlertView

- (id)initWithContentView:(UIView *)contentView
{
    self = [super initWithFrame:screenBounds];
    if (self) {
        self.opaque = YES;
        self.alpha = 1;
      
        _contentView = contentView;
        [self _setupViews];
    }
    return self;
}



- (void)keyboardWillShow:(NSNotification *)notification
{
    //[self keyBoardAnimations:notification];
    /*
     switch (self.animationType) {
     case RJBlurAlertViewAnimationTypeBounce:
     [self triggerBounceAnimations];
     break;
     case RJBlurAlertViewAnimationTypeDrop:
     [self triggerDropAnimations];
     break;
     default:
     break;
     }
     */
    self.alertView.alpha = 0;
    self.alertView.center = CGPointMake(CGRectGetWidth(screenBounds)/2, (CGRectGetHeight(screenBounds)/3-20));
   	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:[UIView animationOptionsForCurve:curve]
                     animations:^{
                         [self.backgroundView setAlpha:1.0];
                         [self.alertView setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                         
                     }];

          
}




- (void)keyboardWillHide:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Show and Dismiss
- (void)show
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
  

    

    
    // 键盘高度变化通知，ios5.0新增的

    
    
    
     [self triggerBounceAnimations];
    /*
    switch (self.animationType) {
        case RJBlurAlertViewAnimationTypeBounce:
            [self triggerBounceAnimations];
            break;
        case RJBlurAlertViewAnimationTypeDrop:
            [self triggerDropAnimations];
            break;
        default:
            break;
    }
     */
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!window){
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window addSubview:self];
}

- (void)dismiss
{
           [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                        
                     }];
    [self.delegate down];
}



#pragma mark - Animations
- (void) triggerBounceAnimations
{
    
    self.alertView.alpha = 0;
    self.alertView.center = CGPointMake(CGRectGetWidth(screenBounds)/2, (CGRectGetHeight(screenBounds)/2));
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3f;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.alertView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.backgroundView setAlpha:1.0];
                         [self.alertView setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                                             }];
}



#pragma mark - View Setup
- (void)_setupViews
{
    UIButton*  button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    button.backgroundColor = [UIColor clearColor];
   
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    /*setup backgroundView*/
    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _blurFilter.blurRadiusInPixels = 2.0;
    _backgroundView = [[UIImageView alloc]initWithFrame:screenBounds];
    UIImage * image = [self _convertViewToImage];
    UIImage *blurredSnapshotImage = [_blurFilter imageByFilteringImage:image];
    [self.backgroundView setImage:blurredSnapshotImage];
    self.backgroundView.alpha = 0.0;
    [self addSubview:self.backgroundView];
    /*setup alertPopupView*/
    self.alertView = [self _alertPopupView];
    /*setup title and content view*/
   [self addSubview:button];    //背景按钮
    [self addSubview:self.alertView];

    /*setup buttons*/
   
}
-(void)click
{
    NSLog(@"click  weijun！！！");
}

- (UIView*)_alertPopupView
{
    return _contentView;
}

-(UIImage *)_convertViewToImage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}






#pragma mark - Button Action
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
