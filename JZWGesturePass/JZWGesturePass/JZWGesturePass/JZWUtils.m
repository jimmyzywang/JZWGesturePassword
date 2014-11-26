//
//  JZWUtils.m
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/4.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import "JZWUtils.h"
#import "JZWCircle.h"

@implementation JZWUtils

+(JZWUtils*)sharedInstance{
  static dispatch_once_t pred;
  static JZWUtils* instance = nil;
  dispatch_once(&pred, ^{
    instance = [[JZWUtils alloc] init];
  });
  return instance;
}

-(NSNumber*)numberForSelectedCells:(NSArray*)cells{
  NSInteger number = 0;
  for (NSInteger index = 0; index < [cells count]; index ++) {
    NSInteger pow = [cells count] - index - 1;
    JZWCircle* cell = [cells objectAtIndex:index];
    number = number + [cell pos] * powf(10, pow);
  }
  return [NSNumber numberWithInteger:number];
}

@end


