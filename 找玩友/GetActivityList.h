//
//  GetActivityList.h
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsynchronousRequest.h"

#import "JSONKit.h"

@protocol  activityDataRecall <NSObject>

-(void) startString:(NSString*) valueString;

@end



@interface GetActivityList : NSObject<dataReCall>

@property(assign,nonatomic) id<activityDataRecall>delegate;
-(void) getActivityListFromServe:(NSString*) cityCode andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;

@end
