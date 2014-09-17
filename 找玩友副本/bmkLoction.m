//
//  bmkLoction.m
//  找玩友
//
//  Created by 军魏 on 14-8-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "bmkLoction.h"


@implementation bmkLoction
{
    CGFloat  localLatitude;
    CGFloat  localLongitude;
    NSString *cityStr;
    NSString *cityName;
    BOOL isGeoSearch;
}

-(void) start
{
   
    _locServices.delegate = self;
    _geocodesearch.delegate = self;
  
    [_locServices startUserLocationService];
}
-(void) setup
{
      _locServices = [[BMKLocationService alloc] init];
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    isGeoSearch = YES;
}

-(void) down
{
    _geocodesearch.delegate = nil;
    _locServices.delegate = nil;
    [_locServices stopUserLocationService];
}

-(void)onClickReverseGeocode
{
 
    	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
	if (localLatitude != 0.0f && localLongitude != 0.0f) {
		pt = (CLLocationCoordinate2D){localLatitude, localLongitude};
	}
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
    
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
   	if (error == 0) {
        NSString* showmeg;
                showmeg = [NSString stringWithFormat:@"%@",result.address];
        NSLog(@" 位置  is %@",showmeg);
        [self.delegate getLocData:showmeg];
         //把获取到的坐标和经纬度 广播到APP中
        NSString* latitiude = [NSString stringWithFormat:@"%f",localLatitude];
        NSString* longtitude = [NSString stringWithFormat:@"%f",localLongitude];
        [self.delegate  getlatitude:latitiude andlongtitude:longtitude];
        isGeoSearch = NO;
    }
}



- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
     //   NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{

    localLatitude = userLocation.location.coordinate.latitude;
    localLongitude = userLocation.location.coordinate.longitude;
    if (isGeoSearch == YES) {
    
    [self onClickReverseGeocode];
    }
    isGeoSearch = NO;
     //  NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}


@end
