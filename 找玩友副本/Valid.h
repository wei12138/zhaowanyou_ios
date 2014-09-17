//
//  Valid.h
//  找玩友
//
//  Created by 军魏 on 14-8-14.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Valid : NSObject

+(BOOL)isValiPhoneNumber:(NSString *)mobile;
+(BOOL)isValiPassword:(NSString *)password;
@end
