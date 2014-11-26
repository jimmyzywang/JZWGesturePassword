//
//  ViewController.m
//  JZWGesturePass
//
//  Created by jimmyzywang-nb on 14/11/26.
//  Copyright (c) 2014年 com.JZWang.com. All rights reserved.
//

#import "ViewController.h"
#import "JZWGestureView.h"
#import "JZWUtils.h"
@interface ViewController ()

@end

@implementation ViewController{
  JZWGestureView* _gestureView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

}

-(void)viewWillLayoutSubviews{
  [super viewWillLayoutSubviews];
  if (!_gestureView) {
    _gestureView = [[JZWGestureView alloc] initWithLength:self.view.bounds.size.width];
    _gestureView.frame = CGRectSetY(_gestureView.frame, (self.view.bounds.size.height - _gestureView.bounds.size.height)/2);
    [self.view addSubview:_gestureView];
  }
  
}


@end
