//
//  JZWLineView.h
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/24.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZWCircle;
@interface JZWLineView : UIView
-(void)setCirclesToDraw:(NSArray*)circles;
-(void)drawErrorLine;
@end
