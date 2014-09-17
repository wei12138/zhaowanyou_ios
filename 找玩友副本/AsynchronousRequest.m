//
//  AsynchronousRequest.m
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "AsynchronousRequest.h"

@implementation AsynchronousRequest
{
    BOOL is_Json;
}



-(void) getRequestForServes:(NSString *)path andPostValue:(NSDictionary *)dict andIsJson:(BOOL)isjson
{
    NSURL *url = [NSURL URLWithString:path];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url] ;
    for (NSString *key in dict) {
        [request setPostValue:[dict objectForKey:key] forKey:key];
    }
    is_Json = isjson;
    //设置响应时间为10秒
    [request setTimeOutSeconds:10];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];
    request.delegate = self;
    
    if (request.error) {
        NSLog(@"网络错误 ：%@",request.error);
    }
    
}

-(void) requestFinished:(ASIHTTPRequest *)request
{
    if (is_Json) {
        NSArray* arry = [request.responseString objectFromJSONString];
        [self.delegate AsyRequestFinished:arry];
        request.delegate = nil;  //关闭数据请求接口;
        return;
    }
    else
    {
        NSArray* arry = [[NSArray alloc] initWithObjects:request.responseString, nil];
        [self.delegate AsyRequestFinished:arry];
        return;
        
    }
    
    
}





@end
