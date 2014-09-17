//
//  RJAlertView.h
//  RJAlertView
//
//  Created by jun on 14-6-4.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import "UIView+AnimationOptionsForCurve.h"
@class RJBlurAlertView;
@protocol RJBlurAlertViewDelegate<NSObject>

-(void) down;

@end


@interface RJBlurAlertView : UIView



@property (nonatomic,weak) id<RJBlurAlertViewDelegate> delegate;

@property(nonatomic,copy) void(^completionBlock)(RJBlurAlertView *alertView,UIButton *button);


- (id)initWithContentView:(UIView *)contentView;
- (void)show;
- (void)dismiss;

-(void)click;

@end

