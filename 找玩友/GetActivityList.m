//
//  GetActivityList.m
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "GetActivityList.h"
static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@implementation GetActivityList
{
    NSString* requestString;
}
#define Method @"m"
#define PostData @"data"
#define Method_getList @"getList"



-(void) getActivityListFromServe:(NSString *)cityCode andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    
    NSDictionary *postData = @{
                               @"city_code": cityCode,
                               @"latitude": latitude,
                               @"longitude": longitude,
                               
                               };
    NSString *path = [baseURL stringByAppendingString:@"Activity"];
    //发送的json数据
    NSString *postJson = [postData JSONString];
    NSDictionary *dict = @{Method:Method_getList,PostData:postJson};
   
    AsynchronousRequest* ACrequest = [[AsynchronousRequest alloc] init];
    ACrequest.delegate = self;
    [ACrequest getRequestForServes:path andPostValue:dict];
 
   
}


-(void) backString:(NSString *)valueString
{
    NSLog(@"weijun");
}





@end
