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

-(void)drawSelectedCircles:(NSArray *)circles{
  _circleToDraw = [circles copy];
  _lines = [self p_computeLinesBetweenSelectedCircles:circles];
  [self setNeedsDisplay];
}

-(void)drawErrorLine{
  _isError = YES;
  _lines = [self p_computeLinesBetweenSelectedCircles:_circleToDraw];
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

-(NSMutableArray*)p_computeLinesBetweenSelectedCircles:(NSArray*)selectedCircles{
  NSMutableArray* lines = [NSMutableArray array];
  for (NSInteger index = 0; index < [selectedCircles count]; index++) {
    JZWCircle* currentCircle = [selectedCircles objectAtIndex:index];
    if (index != [selectedCircles count] - 1) {
      JZWCircle* nextCircle = [selectedCircles objectAtIndex:index + 1];
      JZWLine* line = [[JZWLine alloc] initWithFromX:currentCircle.center.x FromY:currentCircle.center.y ToX:nextCircle.center.x ToY:nextCircle.center.y];
      [lines addObject:line];
    }else{
      break;
    }
  }
  return lines;
}

-(void)drawSelectedCircles:(NSArray *)circles andLine:(JZWLine *)line{
  _circleToDraw = [circles copy];
  _lines = [self p_computeLinesBetweenSelectedCircles:circles];
  [_lines addObject:line];
  [self setNeedsDisplay];
}

-(void)reset{
  [_lines removeAllObjects];
  [self setNeedsDisplay];
}

@end
