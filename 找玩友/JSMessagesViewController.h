//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "JSBubbleMessageCell.h"
#import "JSMessageInputView.h"
#import "JSMessageSoundEffect.h"
#import "UIButton+JSMessagesView.h"
#import "FaceSelectedViewController.h"


#define kAllowsMedia		YES

typedef enum {
    JSMessagesViewTimestampPolicyAll = 0,
    JSMessagesViewTimestampPolicyAlternating,
    JSMessagesViewTimestampPolicyEveryThree,
    JSMessagesViewTimestampPolicyEveryFive,
    JSMessagesViewTimestampPolicyCustom
} JSMessagesViewTimestampPolicy;


typedef enum {
    JSMessagesViewAvatarPolicyIncomingOnly = 0,
    JSMessagesViewAvatarPolicyBoth,
    JSMessagesViewAvatarPolicyNone
} JSMessagesViewAvatarPolicy;


@protocol JSMessagesViewDelegate <NSObject>
@required
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text;
- (void)cameraPressed:(id)sender;
- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath;
- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (JSBubbleMediaType)messageMediaTypeForRowAtIndexPath:(NSIndexPath *)indexPath;
- (JSMessagesViewTimestampPolicy)timestampPolicy;
- (JSMessagesViewAvatarPolicy)avatarPolicy;
- (JSAvatarStyle)avatarStyle;

@optional
- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath;

@end



@protocol JSMessagesViewDataSource <NSObject>
@required
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIImage *)avatarImageForIncomingMessage;
- (UIImage *)avatarImageForOutgoingMessage;
@optional
- (id)dataForRowAtIndexPath:(NSIndexPath *)indexPath;
@end



@interface JSMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, JSMessageInputViewDelegate>

@property (weak, nonatomic) id<JSMessagesViewDelegate> delegate;
@property (weak, nonatomic) id<JSMessagesViewDataSource> dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JSMessageInputView *inputToolBarView;
@property (assign, nonatomic) CGFloat previousTextViewContentHeight;
@property (assign, nonatomic, readonly) UIEdgeInsets originalTableViewContentInset;

#pragma mark - Initialization
- (UIButton *)sendButton;


#pragma mark - Actions
- (void)sendPressed:(UIButton *)sender;

#pragma mark - Messages view controller
- (BOOL)shouldHaveTimestampForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldHaveAvatarForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)finishSend;
- (void)setBackgroundColor:(UIColor *)color;
- (void)scrollToBottomAnimated:(BOOL)animated;

#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification;
- (void)handleWillHideKeyboard:(NSNotification *)notification;
- (void)keyboardWillShowHide:(NSNotification *)notification;

@end