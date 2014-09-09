//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface JSMessageSoundEffect : NSObject

+ (void)playMessageReceivedSound;
+ (void)playMessageSentSound;

@end