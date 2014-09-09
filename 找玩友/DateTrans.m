//
//  DateTrans.m
//  找玩友
//
//  Created by 军魏 on 14-9-2.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "DateTrans.h"

@implementation DateTrans

+(NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

@end
