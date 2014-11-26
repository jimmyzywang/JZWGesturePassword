//
//  ViewController.m
//  JZWGesturePass
//
//  Created by jimmyzywang-nb on 14/11/26.
//  Copyright (c) 2014年 com.JZWang.com. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "JZWGestureView.h"
#import "JZWUtils.h"

static NSString* const kGesturePasswordKey = @"kGesturePasswordKey";

@interface ViewController () <JZWGestureViewDelegate>

@end

@implementation ViewController{
  JZWGestureView* _gestureView;
  UILabel* _hintLabel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _hintLabel = [[UILabel alloc] init];
  [self.view addSubview:_hintLabel];
}

-(void)viewWillLayoutSubviews{
  [super viewWillLayoutSubviews];
  if (!_gestureView) {
    _gestureView = [[JZWGestureView alloc] initWithLength:self.view.bounds.size.width];
    _gestureView.frame = CGRectSetY(_gestureView.frame, (self.view.bounds.size.height - _gestureView.bounds.size.height)/2);
    _gestureView.deleagte = self;
    [self.view addSubview:_gestureView];
  }
  
  [_hintLabel sizeToFit];
  _hintLabel.frame = CGRectSetXY(_hintLabel.frame, (self.view.bounds.size.width - _hintLabel.bounds.size.width)/2, CGRectGetMinY(_gestureView.frame) - 10 - _hintLabel.bounds.size.height);
}

-(void)viewWillAppear:(BOOL)animated{
  if (![[NSUserDefaults standardUserDefaults] objectForKey:kGesturePasswordKey]) {
    _hintLabel.text = @"please setup a new password!";
  }else{
    _hintLabel.text = @"please unlock the password";
  }
}

-(void)JZWGestureViewDidFinishWithNumber:(NSNumber *)number{
  NSNumber* password = [[NSUserDefaults standardUserDefaults] objectForKey:kGesturePasswordKey];
  if (!password) {
    _hintLabel.text = [NSString stringWithFormat:@"your password is %ld",[number longValue]];
  }else{
    if ([number isEqualToNumber:password]) {
      _hintLabel.text = @"success!";
    }else{
      _hintLabel.text = @"fail!";
    }
  }
  [self.view setNeedsLayout];
}


@end
