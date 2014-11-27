//
//  SetUpPasswordViewController.m
//  JZWGesturePass
//
//  Created by jimmyzywang-nb on 14/11/27.
//  Copyright (c) 2014年 com.JZWang.com. All rights reserved.
//

#import "SetUpPasswordViewController.h"
#import "JZWGesturePass.h"

static NSString* const kGesturePasswordKey = @"kGesturePasswordKey";

@interface SetUpPasswordViewController () <JZWGestureViewDelegate>

@end

@implementation SetUpPasswordViewController{
  JZWGestureView* _gestureView;
  UILabel* _hintLabel;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  _hintLabel = [[UILabel alloc] init];
  _hintLabel.text = @"please setup a new password!";
  [self.view addSubview:_hintLabel];
}

-(void)viewWillLayoutSubviews{
  [super viewWillLayoutSubviews];
  if (!_gestureView) {
    _gestureView = [[JZWGestureView alloc] initWithLength:MIN(self.view.bounds.size.width,self.view.bounds.size.height)];
    _gestureView.frame = CGRectSetY(_gestureView.frame, (self.view.bounds.size.height - _gestureView.bounds.size.height)/2);
    _gestureView.deleagte = self;
    [self.view addSubview:_gestureView];
  }
  
  [_hintLabel sizeToFit];
  _hintLabel.frame = CGRectSetXY(_hintLabel.frame, (self.view.bounds.size.width - _hintLabel.bounds.size.width)/2, CGRectGetMinY(_gestureView.frame) - 10 - _hintLabel.bounds.size.height);
}

-(void)JZWGestureViewDidFinishWithNumber:(NSNumber *)number{
  _hintLabel.text = [NSString stringWithFormat:@"your password is %ld",[number longValue]];
  [[NSUserDefaults standardUserDefaults] setObject:number forKey:kGesturePasswordKey];
  [self.view setNeedsLayout];
}

@end
