//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBubbleView.h"

typedef enum {
    JSAvatarStyleCircle = 0,
    JSAvatarStyleSquare,
    JSAvatarStyleNone
} JSAvatarStyle;


@interface JSBubbleMessageCell : UITableViewCell

#pragma mark - Initialization
- (id)initWithBubbleType:(JSBubbleMessageType)type
             bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
             avatarStyle:(JSAvatarStyle)avatarStyle
               mediaType:(JSBubbleMediaType)mediaType
            hasTimestamp:(BOOL)hasTimestamp
         reuseIdentifier:(NSString *)reuseIdentifier;

#pragma mark - Message cell
- (void)setMessage:(NSString *)msg;
- (void)setMedia:(id)data;
- (void)setTimestamp:(NSDate *)date;
- (void)setAvatarImage:(UIImage *)image;

+ (CGFloat)neededHeightForText:(NSString *)bubbleViewText
                     timestamp:(BOOL)hasTimestamp
                        avatar:(BOOL)hasAvatar;

+ (CGFloat)neededHeightForImage:(UIImage *)bubbleViewImage
                      timestamp:(BOOL)hasTimestamp
                         avatar:(BOOL)hasAvatar;


@end