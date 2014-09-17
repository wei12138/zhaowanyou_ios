//
//  LoginCheck.h
//  找玩友
//
//  Created by 军魏 on 14-8-30.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginCheck : NSObject
+(LoginCheck*) sharedLoginCheck;

-(void) setup;
-(BOOL) returnCheckValue;
-(void) changeCheckValue:(BOOL) value;
-(NSString*) getUserId;
-(void) setUserId:(NSString*) ID;

@property BOOL Check;   //该值为TURN，表示用户已经登录。反之用户未登录
@property(strong,nonatomic) NSString* user_id;
@end
