//
//  LoginCheck.m
//  找玩友
//
//  Created by 军魏 on 14-8-30.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "LoginCheck.h"


@implementation LoginCheck

static LoginCheck* sharedCheck = nil;

@synthesize Check;
@synthesize user_id;
+(LoginCheck*) sharedLoginCheck
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedCheck = [[self alloc] init];
    }
                  );
    return sharedCheck;
}
-(void) setup
{
    Check = false;
}

-(BOOL) returnCheckValue
{
    return Check;
}

-(void) changeCheckValue:(BOOL) value
{
    Check = value;
}

-(NSString*) getUserId
{
    return user_id;
}

-(void) setUserId:(NSString*) ID
{
    user_id = ID;
}

@end
