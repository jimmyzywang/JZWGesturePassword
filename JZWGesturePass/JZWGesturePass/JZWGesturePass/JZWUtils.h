//
//  JZWUtils.h
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/4.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define StateNormalColor [UIColor colorWithRed:53.0/255.0 green:139.0/255.0 blue:210.0/255.0 alpha:1]
#define StateErrorColor [UIColor colorWithRed:253/255.0 green:79/255.0 blue:61/255.0 alpha:1]
#define StateSelectInnerColor [UIColor colorWithRed:43/255.0 green:133/255.0 blue:208/255.0 alpha:1]
#define StateSelectShadowColor [UIColor colorWithRed:43/255.0 green:133/255.0 blue:208/255.0 alpha:0.16]
#define StateErrorInnerColor StateErrorColor
#define StateErrorShadowColor [UIColor colorWithRed:253/255.0 green:79/255.0 blue:61/255.0 alpha:0.16]

CG_INLINE CGRect
CGRectLimitLeft(CGRect rect, CGFloat leftOffset)
{
  CGFloat subOffset = leftOffset - rect.origin.x;
  rect.origin.x = leftOffset;
  rect.size.width = rect.size.width - subOffset;
  return rect;
}


CG_INLINE CGRect
CGRectSetXY(CGRect rect, CGFloat x, CGFloat y)
{
  rect.origin.x = x;
  rect.origin.y = y;
  return rect;
}
CG_INLINE CGRect
CGRectLimitWidth(CGRect rect, CGFloat width)
{
  rect.size.width = rect.size.width > width ? width : rect.size.width;
  return rect;
}

CG_INLINE CGRect
CGRectSetHeight(CGRect rect, CGFloat height)
{
  rect.size.height = height;
  return rect;
}
CG_INLINE CGRect
CGRectSetX(CGRect rect, CGFloat x)
{
  rect.origin.x = x;
  return rect;
}

CG_INLINE CGRect
CGRectSetY(CGRect rect, CGFloat y)
{
  rect.origin.y = y;
  return rect;
}
CG_INLINE CGRect
CGRectSetWidth(CGRect rect, CGFloat width)
{
  rect.size.width = width;
  return rect;
}


@interface JZWUtils : NSObject

+(JZWUtils*)sharedInstance;
-(NSNumber*)numberForSelectedCells:(NSArray*)cells;
@end
