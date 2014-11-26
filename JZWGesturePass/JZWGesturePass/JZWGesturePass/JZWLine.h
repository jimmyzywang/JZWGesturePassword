//
//  JZWLine.h
//  JZWGesturePsw
//
//  Created by jimmyzywang-nb on 14/11/24.
//  Copyright (c) 2014年 com.tencent.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JZWLine : NSObject

-(instancetype)initWithFromX:(CGFloat)fromX FromY:(CGFloat)fromY ToX:(CGFloat)toX ToY:(CGFloat)toY;
@property(nonatomic,readonly)CGFloat fromX;
@property(nonatomic,readonly)CGFloat fromY;
@property(nonatomic,readonly)CGFloat toX;
@property(nonatomic,readonly)CGFloat toY;
@end
