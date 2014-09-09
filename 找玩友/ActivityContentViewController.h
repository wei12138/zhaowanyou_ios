//
//  ActivityContentViewController.h
//  找玩友
//
//  Created by 军魏 on 14-9-2.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ViewController.h"

@interface ActivityContentViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextView *ContentTextView;

-(void) getDataFromReleaseActivityStartTime:(NSString*) Stime andEndtime:(NSString*) Etime andAssem:(NSString*) Place andLimited:(NSString*) limite andCost:(NSString*) cost;
@end
