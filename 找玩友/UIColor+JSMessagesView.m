//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//
#import "UIColor+JSMessagesView.h"
#import "JSMessageInputView.h"


@implementation UIColor (JSMessagesView)

+ (UIColor *)messagesBackgroundColor
{
    if ([JSMessageInputView inputBarStyle] == JSInputBarStyleFlat)
        return [UIColor whiteColor];

    return [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
}

+ (UIColor *)messagesTimestampColor
{
    return [UIColor colorWithRed:0.533f green:0.573f blue:0.647f alpha:1.0f];
}

@end