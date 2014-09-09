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

@protocol dataReCall <ASIHTTPRequestDelegate>

-(void) backString:(NSString*) valueString;

@end


@interface AsynchronousRequest : NSObject

@property(nonatomic,assign) id<dataReCall> delegate;
-(void) getRequestForServes:(NSString*) path andPostValue:(NSDictionary*) dic;
@end
