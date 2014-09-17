//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (JSMessagesView)

#pragma mark - Avatar styles
- (UIImage *)circleImageWithSize:(CGFloat)size;
- (UIImage *)squareImageWithSize:(CGFloat)size;

- (UIImage *)imageAsCircle:(BOOL)clipToCircle
               withDiamter:(CGFloat)diameter
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
              shadowOffSet:(CGSize)shadowOffset;

#pragma mark - Input bar
+ (UIImage *)inputBar;
+ (UIImage *)inputField;

#pragma mark - Bubble cap insets
- (UIImage *)makeStretchableDefaultIncoming;
- (UIImage *)makeStretchableDefaultOutgoing;

- (UIImage *)makeStretchableSquareIncoming;
- (UIImage *)makeStretchableSquareOutgoing;

- (UIImage *)makeStretchableFlatIncoming;
- (UIImage *)makeStretchableFlatOutgoing;

#pragma mark - Incoming message bubbles
+ (UIImage *)bubbleDefaultIncoming;
+ (UIImage *)bubbleDefaultIncomingSelected;

+ (UIImage *)bubbleDefaultIncomingGreen;

+ (UIImage *)bubbleSquareIncoming;
+ (UIImage *)bubbleSquareIncomingSelected;

+ (UIImage *)bubbleFlatIncoming;
+ (UIImage *)bubbleFlatIncomingSelected;

#pragma mark - Outgoing message bubbles
+ (UIImage *)bubbleDefaultOutgoing;
+ (UIImage *)bubbleDefaultOutgoingSelected;

+ (UIImage *)bubbleDefaultOutgoingGreen;

+ (UIImage *)bubbleSquareOutgoing;
+ (UIImage *)bubbleSquareOutgoingSelected;

+ (UIImage *)bubbleFlatOutgoing;
+ (UIImage *)bubbleFlatOutgoingSelected;

@end
