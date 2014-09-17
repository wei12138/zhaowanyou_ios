//
//  Valid.m
//  找玩友
//
//  Created by 军魏 on 14-8-14.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "Valid.h"

@implementation Valid


+(BOOL)isValiPhoneNumber:(NSString *)mobile
{
   
        //手机号以13， 15，18开头，八个 \d 数字字符
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
        return [phoneTest evaluateWithObject:mobile];
}


+(BOOL)isValiPassword:(NSString *)password
{
    NSString * regex = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return   isMatch;
}
@end
