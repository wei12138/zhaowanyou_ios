//
//  AsynchronousRequest.m
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "AsynchronousRequest.h"

@implementation AsynchronousRequest


-(void) getRequestForServes:(NSString *)path andPostValue:(NSDictionary *)dict
{
    NSURL *url = [NSURL URLWithString:path];
  
      ASIFormDataRequest *ActivityRequest = [[ASIFormDataRequest alloc] initWithURL:url];
     ActivityRequest.delegate = self;
    for (NSString *key in dict) {
        
        [ActivityRequest setPostValue:[dict objectForKey:key] forKey:key];
    }
    
    //[self.delegate RecallString:nil];
    //设置响应时间为10秒
    [ActivityRequest setTimeOutSeconds:10];
    [ActivityRequest setRequestMethod:@"POST"];
    [ActivityRequest startAsynchronous];
    [ActivityRequest setCompletionBlock:^{
    // [self.delegate RecallString:nil];
        [self RecallDataString:ActivityRequest.responseString];

    }];
    
}

-(void) RecallDataString:(NSString*) valueString
{
   
    NSLog(@"%@",valueString);
   }

@end
