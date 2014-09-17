//
//  bmkLoction.h
//  找玩友
//
//  Created by 军魏 on 14-8-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

@protocol locationData <NSObject>

-(void) getLocData:(NSString*) locaString;
-(void) getlatitude:(NSString*) latitude andlongtitude:(NSString*) longtitude;
@end



#import <Foundation/Foundation.h>
#import "BMapKit.h"


@interface bmkLoction : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,locationData>
{
    BMKLocationService* _locServices;
    BMKGeoCodeSearch* _geocodesearch;
}

@property(assign,nonatomic) id<locationData> delegate;
-(void) start;
-(void)onClickReverseGeocode;
-(void) down;
-(void) setup;
@end
