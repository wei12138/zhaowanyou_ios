//
//  MessageViewController.h
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageScro.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
-(IBAction) clickFriends;

@property (weak, nonatomic) IBOutlet UITableView *MessageTableView;

@end
