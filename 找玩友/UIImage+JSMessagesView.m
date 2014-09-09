//
//  SegementPageThreeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-24.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "UIImage+JSMessagesView.h"
#import "JSMessageInputView.h"

@implementation UIImage (JSMessagesView)

#pragma mark - Avatar styles
- (UIImage *)circleImageWithSize:(CGFloat)size
{
    return [self imageAsCircle:YES
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

- (UIImage *)squareImageWithSize:(CGFloat)size
{
    return [self imageAsCircle:NO
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

- (UIImage *)imageAsCircle:(BOOL)clipToCircle
               withDiamter:(CGFloat)diameter
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
              shadowOffSet:(CGSize)shadowOffset
{
    // increase given size for border and shadow
    CGFloat increase = diameter * 0.15f;
    CGFloat newSize = diameter + increase;
    
    CGRect newRect = CGRectMake(0.0f,
                                0.0f,
                                newSize,
                                newSize);
    
    // fit image inside border and shadow
    CGRect imgRect = CGRectMake(increase,
                                increase,
                                newRect.size.width - (increase * 2.0f),
                                newRect.size.height - (increase * 2.0f));
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // draw shadow
    if(!CGSizeEqualToSize(shadowOffset, CGSizeZero))
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(shadowOffset.width, shadowOffset.height),
                                    3.0f,
                                    [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    
    // draw border
    // as circle or square
    CGPathRef borderPath = (clipToCircle) ? CGPathCreateWithEllipseInRect(imgRect, NULL) : CGPathCreateWithRect(imgRect, NULL);
    
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetLineWidth(context, borderWidth);
    CGContextAddPath(context, borderPath);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(borderPath);
    CGContextRestoreGState(context);
    
    // clip to circle
    if(clipToCircle) {
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:imgRect];
        [imgPath addClip];
    }
    
    [self drawInRect:imgRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
} 


#pragma mark - Input bar
+ (UIImage *)inputBar
{
  if ([JSMessageInputView inputBarStyle] == JSInputBarStyleFlat)
    return [UIImage imageNamed:@"input-bar-flat"];
  else      // jSInputBarStyleDefault
    return [[UIImage imageNamed:@"input-bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)];
}

+ (UIImage *)inputField
{
  if ([JSMessageInputView inputBarStyle] == JSInputBarStyleFlat)
    return nil; // no graphic around input field.
  else          // jSInputBarStyleDefault
    return [[UIImage imageNamed:@"input-field"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 12.0f, 18.0f, 18.0f)];
}

#pragma mark - Bubble cap insets
- (UIImage *)makeStretchableDefaultIncoming
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)makeStretchableDefaultOutgoing
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)makeStretchableSquareIncoming
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 25.0f, 16.0f, 23.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)makeStretchableSquareOutgoing
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 18.0f, 16.0f, 23.0f)
                                resizingMode:UIImageResizingModeStretch];
}

// JeremyStone
- (UIImage *)makeStretchableFlatIncoming
{
  return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f)
                              resizingMode:UIImageResizingModeStretch];
}

// JeremyStone
- (UIImage *)makeStretchableFlatOutgoing
{
  return [self resizableImageWithCapInsets:UIEdgeInsetsMake(14.0f, 15.0f, 14.0f, 20.0f)
                              resizingMode:UIImageResizingModeStretch];
}

#pragma mark - Incoming message bubbles
+ (UIImage *)bubbleDefaultIncoming
{
    return [[UIImage imageNamed:@"bubble-default-incoming"] makeStretchableDefaultIncoming];
}

+ (UIImage *)bubbleDefaultIncomingSelected
{
    return [[UIImage imageNamed:@"bubble-default-incoming-selected"] makeStretchableDefaultIncoming];
}

+ (UIImage *)bubbleDefaultIncomingGreen
{
    return [[UIImage imageNamed:@"bubble-default-incoming-green"] makeStretchableDefaultIncoming];
}

+ (UIImage *)bubbleSquareIncoming
{
    return [[UIImage imageNamed:@"bubble-square-incoming"] makeStretchableSquareIncoming];
}

+ (UIImage *)bubbleSquareIncomingSelected
{
    return [[UIImage imageNamed:@"bubble-square-incoming-selected"] makeStretchableSquareIncoming];
}

// JeremyStone
+ (UIImage *)bubbleFlatIncoming
{
  return [[UIImage imageNamed:@"bubble-flat-incoming"] makeStretchableFlatIncoming];
}

// JeremyStone
+ (UIImage *)bubbleFlatIncomingSelected
{
  return [[UIImage imageNamed:@"bubble-flat-incoming-selected"] makeStretchableFlatIncoming];
}

#pragma mark - Outgoing message bubbles
+ (UIImage *)bubbleDefaultOutgoing
{
    return [[UIImage imageNamed:@"bubble-default-outgoing"] makeStretchableDefaultOutgoing];
}

+ (UIImage *)bubbleDefaultOutgoingSelected
{
    return [[UIImage imageNamed:@"bubble-default-outgoing-selected"] makeStretchableDefaultOutgoing];
}

+ (UIImage *)bubbleDefaultOutgoingGreen
{
    return [[UIImage imageNamed:@"bubble-default-outgoing-green"] makeStretchableDefaultOutgoing];
}

+ (UIImage *)bubbleSquareOutgoing
{
    return [[UIImage imageNamed:@"bubble-square-outgoing"] makeStretchableSquareOutgoing];
}

+ (UIImage *)bubbleSquareOutgoingSelected
{
    return [[UIImage imageNamed:@"bubble-square-outgoing-selected"] makeStretchableSquareOutgoing];
}

// JeremyStone
+ (UIImage *)bubbleFlatOutgoing
{
  return [[UIImage imageNamed:@"bubble-flat-outgoing-selected"] makeStretchableFlatOutgoing];
}

// JeremyStone
+ (UIImage *)bubbleFlatOutgoingSelected
{
  return [[UIImage imageNamed:@"bubble-flat-outgoing"] makeStretchableFlatOutgoing];
}

@end
