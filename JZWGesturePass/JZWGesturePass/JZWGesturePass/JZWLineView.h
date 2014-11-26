//
//  JZWLineView.h
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/24.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZWCircle;
@class JZWLine;
@interface JZWLineView : UIView
-(void)drawSelectedCircles:(NSArray*)circles;
-(void)drawErrorLine;
-(void)drawSelectedCircles:(NSArray *)circles andLine:(JZWLine*)line;
-(void)reset;
@end
