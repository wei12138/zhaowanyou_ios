//
//  localInformation.m
//  找玩友
//
//  Created by 军魏 on 14-9-3.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "localInformation.h"
#import "bmkLoction.h"
@implementation localInformation
static localInformation* information;
@synthesize address;
@synthesize latitude;
@synthesize longtitude;
+(localInformation*) shareLocalInformation
{
     static  dispatch_once_t once;
    dispatch_once(&once,^{
        information = [[self alloc] init];
    });
    return information;
}

-(void) setLocalInfolatitude:(NSString *)la andlongtitude:(NSString *)lo
{
    latitude = la;
    longtitude = lo;
}

-(void) setLocalInfoAddress:(NSString *)addr
{
    address = addr;
}

-(NSString*) getAddr
{
    return address;
}

-(NSString*) getLat
{
    return latitude;
}

-(NSString*) getLon
{
    return longtitude;
}



@end
