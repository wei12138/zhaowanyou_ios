
//
//  getCurrentTime.m
//  找玩友
//
//  Created by 军魏 on 14-9-3.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "getCurrentTime.h"

@implementation getCurrentTime
+(NSString*) getCurrent
{
    NSDate* currentDate = [NSDate date];
    NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* CurrentTime = [dateformatter stringFromDate:currentDate];
    
    return CurrentTime;
}
@end
