//
//  AsynchronousRequest.h
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@protocol AsynchronousRequestDelegate <ASIHTTPRequestDelegate>

-(void) AsyRequestFinished:(NSArray*) valueArray;

@end


@interface AsynchronousRequest : NSObject<ASIHTTPRequestDelegate>

@property(nonatomic,assign) id<AsynchronousRequestDelegate> delegate;
-(void) getRequestForServes:(NSString*) path andPostValue:(NSDictionary*) dic andIsJson:(BOOL) isjson;
@end
