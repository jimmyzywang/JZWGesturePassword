//
//  JZWLineView.m
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/24.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import "JZWLineView.h"
#import "JZWCircle.h"
#import "JZWUtils.h"
#import "JZWLine.h"
static const CGFloat kLineWidth = 1;

@implementation JZWLineView{
  NSArray* _circleToDraw;
  NSMutableArray* _lines;
  BOOL _isError;
}

-(instancetype)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

-(void)setCirclesToDraw:(NSArray *)circles{
  _circleToDraw = [circles copy];
  _lines = [NSMutableArray array];
  [self p_computeLines];
  [self setNeedsDisplay];
}

-(void)drawErrorLine{
  _isError = YES;
  [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, kLineWidth);
  
  if (_isError) {
    CGContextSetStrokeColorWithColor(context, StateErrorColor.CGColor);
  }else{
    CGContextSetStrokeColorWithColor(context, StateSelectInnerColor.CGColor);
  }
  
  for (JZWLine* line in _lines) {
    CGContextMoveToPoint(context, line.fromX, line.fromY);
    CGContextAddLineToPoint(context, line.toX, line.toY);
    CGContextStrokePath(context);
  }
}

-(void)p_computeLines{
  for (NSInteger index = 0; index < [_circleToDraw count]; index++) {
    JZWCircle* currentCircle = [_circleToDraw objectAtIndex:index];
    if (index != [_circleToDraw count] - 1) {
      JZWCircle* nextCircle = [_circleToDraw objectAtIndex:index + 1];
      JZWLine* line = [[JZWLine alloc] init];
      line.fromX = currentCircle.center.x;
      line.fromY = currentCircle.center.y;
      line.toX = nextCircle.center.x;
      line.toY = nextCircle.center.y;
      [_lines addObject:line];
    }else{
      break;
    }
  }
}

@end
