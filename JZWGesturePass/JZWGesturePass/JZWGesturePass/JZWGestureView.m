//
//  JZWGestureView.m
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/5.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import "JZWGestureView.h"
#import "JZWCircle.h"
#import "JZWUtils.h"
#import "JZWLineView.h"
#import "JZWLine.h"

static const NSUInteger kCircleNum = 9;

@implementation JZWGestureView{
  NSArray* _circleViewArray;
  CGFloat _radius;
  NSMutableArray* _selectedCircles;
  NSMutableArray* _linesArray;
  JZWCircle* _lastCirle;
  JZWLineView* _lineView;
}

-(instancetype)initWithLength:(CGFloat)length{
  if (self = [super initWithFrame:CGRectMake(0, 0, length, length)]) {
    _radius = length / 10;
    _lineView = [[JZWLineView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
    [self addSubview:_lineView];
    [self p_initSubViewsWithLength:length];
    [self p_addGestureRecognizer];
    _selectedCircles = [NSMutableArray array];
  }
  return self;
}

-(void)p_initSubViewsWithLength:(CGFloat)length{
  NSMutableArray* array = [NSMutableArray array];
  for (NSInteger index = 0; index < kCircleNum; index++) {
    JZWCircle* circle = [[JZWCircle alloc] initWithRadius:_radius withPostion:index + 1];
    [array addObject:circle];
  }
  _circleViewArray = [array copy];
  
  CGFloat verticalInset = length / 20;
  CGFloat horizontalInset = length / 20;
  
  for (NSInteger index = 0;index < [_circleViewArray count];index++) {
    CGFloat x = verticalInset + (index % 3) * (length - 2 * verticalInset) * 0.4;
    CGFloat y = horizontalInset + (index / 3) * (length - 2 * horizontalInset) * 0.4;
    JZWCircle* circle = [_circleViewArray objectAtIndex:index];
    circle.frame = CGRectSetXY(circle.frame, x, y);
    [self addSubview:circle];
  }
}

-(void)p_addGestureRecognizer{
  UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_onGesture:)];
  UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(p_onGesture:)];
  [self addGestureRecognizer:tap];
  [self addGestureRecognizer:pan];
}

-(void)p_onGesture:(UIGestureRecognizer*)gestureRecognizer{
  CGPoint point = [gestureRecognizer locationInView:self];
  
  if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
      [self p_handleTouchPointWhenTap:point];
    }else{
      [self p_handleFinishTap];
    }
  }
  
  if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
    
  }
}

-(void)p_handleTouchPointWhenTap:(CGPoint)point{
  for (JZWCircle* circle in _circleViewArray) {
    CGPoint pointInCircle = [self convertPoint:point toView:circle];
    BOOL isCircleHit = [circle pointInside:pointInCircle withEvent:nil];
    
    if (isCircleHit && !_canSelectTwice) {
      [self p_handleSelectCircle:circle];
    }else{
      JZWCircle* lastSelectCricle = [_selectedCircles lastObject];
      if (lastSelectCricle) {
        JZWLine* line = [[JZWLine alloc] initWithFromX:lastSelectCricle.center.x FromY:lastSelectCricle.center.y ToX:point.x ToY:point.y];
        [self p_handleDrawLinesWithSelectedCircles:_selectedCircles andLine:line];
      }
    }
  }
}

-(void)p_handleDrawLinesWithSelectedCircles:(NSArray*)selectedCircles andLine:(JZWLine*)line{
  [_lineView drawSelectedCircles:_selectedCircles andLine:line];
}

-(void)p_handleSelectCircle:(JZWCircle*)circle{
  [circle setSelected];
  _lastCirle = circle;
  if (![_selectedCircles containsObject:circle]) {
    [_selectedCircles addObject:circle];
  }
  [_lineView drawSelectedCircles:_selectedCircles];
}

-(void)p_handleFinishTap{
  NSNumber* number = [[JZWUtils sharedInstance] numberForSelectedCells:_selectedCircles];
  [_deleagte JZWGestureViewDidFinishWithNumber:number];
}

@end
