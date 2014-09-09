//
//  ViewBlank.m
//  找玩友
//
//  Created by 军魏 on 14-8-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ViewBlank.h"

@implementation ViewBlank
+(NSString*) returnViewBlank:(NSString *)valueString
{
  
    NSString* blankString = @"   ";
    blankString = [blankString stringByAppendingString:valueString];

    return blankString;
}
@end
