//
//  AcComment.h
//  找玩友
//
//  Created by 军魏 on 14-8-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcComment : NSObject
-(void) setupData:(NSArray*) commentArray;

-(UIView*) createCommentView:(NSInteger) index andFrame:(CGRect) frame;

@end
