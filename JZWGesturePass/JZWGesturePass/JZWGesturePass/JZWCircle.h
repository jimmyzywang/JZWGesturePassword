//
//  JZWCircle.h
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/4.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JZWCircleState){
  JZWCircleStateNormal,
  JZWCircleStateError,
  JZWCircleStateSelected
};

@interface JZWCircle : UIView
/**
 *  圆圈的desigated init
 *
 *  @param radius
 *  @param pos
 *
 *  @return
 */
-(instancetype)initWithRadius:(CGFloat)radius withPostion:(NSInteger)pos;
-(NSInteger)pos;
-(void)setSelected;
-(void)reset;
@end
