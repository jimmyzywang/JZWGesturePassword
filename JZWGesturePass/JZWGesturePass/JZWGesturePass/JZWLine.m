//
//  JZWLine.m
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/24.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import "JZWLine.h"

@implementation JZWLine

-(instancetype)initWithFromX:(CGFloat)fromX FromY:(CGFloat)fromY ToX:(CGFloat)toX ToY:(CGFloat)toY{
  if (self = [super init]) {
    _fromX = fromX;
    _fromY = fromY;
    _toX = toX;
    _toY = toY;
  }
  return self;
}

@end
