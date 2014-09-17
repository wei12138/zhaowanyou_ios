//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "UIView+AnimationOptionsForCurve.h"

@implementation UIView (AnimationOptionsForCurve)

+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}

@end