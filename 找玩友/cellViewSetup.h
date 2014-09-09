//
//  cellViewSetup.h
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol activityButtonAction <NSObject>

-(void) activityGood;

@end


@interface cellViewSetup : NSObject
{
}

@property(assign,nonatomic) id<activityButtonAction> delegate;
-(void) getData:(NSArray*) value;
-(UIView*) setupCellView:(NSInteger) index andCellFrame:(CGRect) frame;
-(CGFloat*) returnCellViewHight;
-(void) clickGood;
-(void) clickMore;

-(void)onClickReverseGeocode:(CGFloat) localLatitude and:(CGFloat) localLongitude;
@end
