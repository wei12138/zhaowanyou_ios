//
//  ShowPlayCellView.h
//  找玩友
//
//  Created by 军魏 on 14-8-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowPlayCellView : NSObject


-(void) getData:(NSArray*) showPlayArray;
-(UIView*) createShowPlayCellView:(NSInteger) index andCellFrame:(CGRect) frame;


@end
