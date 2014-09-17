//
//  CommentViewController.h
//  找玩友
//
//  Created by 军魏 on 14-9-7.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ViewController.h"

@interface CommentViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextView *CommetInputView;




-(void) getACownerID:(NSString*) ACid andUserID:(NSString*) userID andActivityID:(NSString*) activityID;
@end
