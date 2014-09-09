//
//  FaceSelectedViewController.h
//  找玩友
//
//  Created by 军魏 on 14-8-4.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FaceSelectedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(retain,nonatomic)   IBOutlet UIScrollView*  FaceScroView;
@property(retain,nonatomic)   NSMutableArray* phrase;


-(void) showEmoView;
-(IBAction) dimissFaceView;


@end
