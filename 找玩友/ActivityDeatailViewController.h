//
//  ActivityDeatailViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-16.
//  Copyright (c) 2014年 军魏. All rights reserved.
//


#import "ActivityMessageInfo.h"
#import  "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AcComment.h"
@interface ActivityDeatailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ActivityDetailTableView;
-(void) reciveDict:(NSDictionary*) dic;
@end
