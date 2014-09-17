//
//  CCSegmentedControl.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSegmentedControl : UIControl<NSCoding>

@property (strong, nonatomic) UIView*     selectedStainView;        //阴影效果
@property (strong, nonatomic) UIColor*    segmentTextColor;
@property (strong, nonatomic) UIColor*    selectedSegmentTextColor;
@property (strong, nonatomic) UIImage*    backgroundImage;
@property (assign, nonatomic) NSInteger   selectedSegmentIndex;


- (id)initWithItems:(NSArray *)items;

- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment;
- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment;

- (void)removeAllSegments;
- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;

@end
