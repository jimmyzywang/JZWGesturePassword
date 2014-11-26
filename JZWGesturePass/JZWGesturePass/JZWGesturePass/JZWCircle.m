//
//  JZWCircle.m
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/4.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import "JZWCircle.h"
#import "JZWUtils.h"

static const CGFloat kNormalLineWidth = 1;

@implementation JZWCircle{
  CGFloat _circleRadius;
  JZWCircleState _state;
  NSInteger _pos;
}

-(instancetype)initWithRadius:(CGFloat)radius withPostion:(NSInteger)pos{
  if (self = [super initWithFrame:CGRectMake(0, 0, 2*radius, 2*radius)]) {
    self.backgroundColor = [UIColor whiteColor];
    _circleRadius = radius;
    _state = JZWCircleStateNormal;
    _pos = pos;
  }
  return self;
}

-(void)drawRect:(CGRect)rect{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
  CGContextFillRect(context, rect);
  CGContextSetLineWidth(context, kNormalLineWidth);
  if (_state == JZWCircleStateNormal) {
    CGContextSetStrokeColorWithColor(context, StateNormalColor.CGColor);
    CGContextStrokeEllipseInRect(context, CGRectInset(rect, 1, 1));
  }
  
  if (_state == JZWCircleStateError) {
    CGContextSetStrokeColorWithColor(context, StateErrorColor.CGColor);
    CGContextStrokeEllipseInRect(context, CGRectInset(rect, 1, 1));
    
    CGContextSetFillColorWithColor(context,StateErrorShadowColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(rect, rect.size.width * 0.1 , rect.size.height * 0.1));
    
    CGContextSetFillColorWithColor(context, StateErrorInnerColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(rect, rect.size.width * 0.25 , rect.size.height * 0.25));
  }
  
  if (_state == JZWCircleStateSelected) {
    CGContextSetStrokeColorWithColor(context,StateNormalColor.CGColor);
    CGContextStrokeEllipseInRect(context, CGRectInset(rect, 1, 1));
    
    CGContextSetFillColorWithColor(context, StateSelectShadowColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(rect, rect.size.width * 0.1 , rect.size.height * 0.1));
    CGContextSetFillColorWithColor(context, StateSelectInnerColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(rect, rect.size.width * 0.25 , rect.size.height * 0.25));
  }
}

-(NSInteger)pos{
  return _pos;
}

-(void)setSelected{
  _state = JZWCircleStateSelected;
  [self setNeedsDisplay];
}

-(NSString*)description{
  return [NSString stringWithFormat:@"%@, JZWCircle state = %d pos = %d",[super description],_state,_pos];
}

-(void)reset{
  _state = JZWCircleStateNormal;
  [self setNeedsDisplay];
}
@end
