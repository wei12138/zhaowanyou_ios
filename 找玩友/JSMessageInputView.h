//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessageTextView.h"


typedef enum
{
  JSInputBarStyleDefault,
  JSInputBarStyleFlat
} JSInputBarStyle;



@protocol JSMessageInputViewDelegate <NSObject>

@optional
- (JSInputBarStyle)inputBarStyle;

@end


@interface JSMessageInputView : UIImageView

@property (strong, nonatomic) JSMessageTextView *textView;
@property (strong, nonatomic) UIButton *sendButton;

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame delegate:(id<UITextViewDelegate, JSMessageInputViewDelegate>)delegate;

#pragma mark - Message input view
- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight;

+ (CGFloat)textViewLineHeight;
+ (CGFloat)maxLines;
+ (CGFloat)maxHeight;
+ (JSInputBarStyle)inputBarStyle;

@end