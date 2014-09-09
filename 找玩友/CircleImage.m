//
//  CircleImage.m
//  找玩友
//
//  Created by 军魏 on 14-8-18.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "CircleImage.h"

@implementation CircleImage

+(UIImageView*) returnCircleImageView:(UIImageView *)valueImageView andFrame:(CGRect)frame
{
    
    valueImageView.frame = frame;
    valueImageView.layer.masksToBounds = YES;
    valueImageView.layer.cornerRadius =frame.size.height/2;
    return valueImageView;
}

@end
