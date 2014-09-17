//
//  SceneryDetailScroViewViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-19.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneryDetailScroViewViewController : UIScrollView
{
    NSArray* userMessage;
}



-(id) initMessageScroViewWithData:(NSArray *)value;
-(void) addViews;
-(UIView*) createViews:(CGRect)frame;
@end
