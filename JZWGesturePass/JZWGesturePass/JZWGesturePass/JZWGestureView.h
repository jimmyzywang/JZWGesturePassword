//
//  JZWGestureView.h
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/5.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZWGestureViewDelegate <NSObject>

-(void)JZWGestureViewDidFinishWithNumber:(NSNumber*)number;

@end

@interface JZWGestureView : UIView
-(instancetype)initWithLength:(CGFloat)length;
@property(nonatomic,weak)id<JZWGestureViewDelegate> deleagte;
@property(nonatomic,assign)BOOL canSelectTwice;
@end
