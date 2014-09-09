//
//  localInformation.h
//  找玩友
//
//  Created by 军魏 on 14-9-3.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface localInformation : NSObject

@property(strong,nonatomic) NSString* address;
@property(strong,nonatomic) NSString* latitude;
@property(strong,nonatomic) NSString* longtitude;

+(localInformation*) shareLocalInformation;

-(void) setLocalInfolatitude:(NSString*) la andlongtitude:(NSString*) lo;
-(void) setLocalInfoAddress:(NSString*) addr;
-(NSString*) getAddr;
-(NSString*) getLat;
-(NSString*) getLon;
@end
