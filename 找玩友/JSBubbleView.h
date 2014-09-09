//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kJSAvatarSize;

typedef enum {
    JSBubbleMessageTypeIncoming = 0,
    JSBubbleMessageTypeOutgoing
} JSBubbleMessageType;

typedef enum {
    JSBubbleMediaTypeText = 0,
    JSBubbleMediaTypeImage,
}JSBubbleMediaType;

typedef enum {
    JSBubbleMessageStyleDefault = 0,
    JSBubbleMessageStyleSquare,
    JSBubbleMessageStyleDefaultGreen,
    JSBubbleMessageStyleFlat
} JSBubbleMessageStyle;


@interface JSBubbleView : UIView

@property (assign, nonatomic) JSBubbleMessageType type;
@property (assign, nonatomic) JSBubbleMessageStyle style;
@property (nonatomic,assign) JSBubbleMediaType mediaType;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) id data;
@property (assign, nonatomic) BOOL selectedToShowCopyMenu;

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)rect
         bubbleType:(JSBubbleMessageType)bubleType
        bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
          mediaType:(JSBubbleMediaType)bubbleMediaType;

#pragma mark - Drawing
- (CGRect)bubbleFrame;
- (UIImage *)bubbleImage;
- (UIImage *)bubbleImageHighlighted;

#pragma mark - Bubble view
+ (UIImage *)bubbleImageForType:(JSBubbleMessageType)aType
                          style:(JSBubbleMessageStyle)aStyle;

+ (UIFont *)font;

+ (CGSize)textSizeForText:(NSString *)txt;
+ (CGSize)bubbleSizeForText:(NSString *)txt;
+ (CGSize)bubbleSizeForImage:(UIImage *)image;
+ (CGSize)imageSizeForImage:(UIImage *)image;
+ (CGFloat)cellHeightForText:(NSString *)txt;
+ (CGFloat)cellHeightForImage:(UIImage *)image;

+ (int)maxCharactersPerLine;
+ (int)numberOfLinesForMessage:(NSString *)txt;

@end