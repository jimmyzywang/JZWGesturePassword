//
//  VerifyPasswordViewController.m
//  JZWGesturePass
//
//  Created by jimmyzywang-nb on 14/11/27.
//  Copyright (c) 2014年 com.JZWang.com. All rights reserved.
//

#import "VerifyPasswordViewController.h"
#import "JZWGesturePass.h"

static NSString* const kGesturePasswordKey = @"kGesturePasswordKey";

@interface VerifyPasswordViewController () <JZWGestureViewDelegate>

@end

@implementation VerifyPasswordViewController{
  JZWGestureView* _gestureView;
  UILabel* _hintLabel;
  UIButton* _showPasswordButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  _hintLabel = [[UILabel alloc] init];
  [self.view addSubview:_hintLabel];
  
  _showPasswordButton = [[UIButton alloc] init];
  [_showPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [_showPasswordButton setHidden:YES];
  _showPasswordButton.backgroundColor = StateNormalColor;
  _showPasswordButton.layer.cornerRadius = 3;
  [self.view addSubview:_showPasswordButton];
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
  
  [_showPasswordButton sizeToFit];
  _showPasswordButton.frame = CGRectInset(_showPasswordButton.frame, -10, 0);
  _showPasswordButton.frame = CGRectSetXY(_showPasswordButton.frame, (self.view.bounds.size.width - _showPasswordButton.bounds.size.width)/2, CGRectGetMaxY(_gestureView.frame) + 10);
}

-(void)viewWillAppear:(BOOL)animated{
  _hintLabel.text = @"please unlock the password";
  [_showPasswordButton setHidden:NO];
  [_showPasswordButton setTitle:@"hold here to show password" forState:UIControlStateNormal];
  [_showPasswordButton addTarget:self action:@selector(p_onClickedShowPassword:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)JZWGestureViewDidFinishWithNumber:(NSNumber *)number{
  NSNumber* password = [[NSUserDefaults standardUserDefaults] objectForKey:kGesturePasswordKey];
  if (!password) {
    _hintLabel.text = @"please set your password first";
    [self.navigationController popViewControllerAnimated:YES];
  }else{
    if ([number isEqualToNumber:password]) {
      _hintLabel.text = @"success!";
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_gestureView reset];
      });
    }else{
      _hintLabel.text = @"fail!";
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_gestureView drawError];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.4 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
          [_gestureView reset];
        });
      });
    }
  }
  [self.view setNeedsLayout];
}

-(void)p_onClickedShowPassword:(UIButton*)sender{
  NSNumber* password = [[NSUserDefaults standardUserDefaults] objectForKey:kGesturePasswordKey];
  [_showPasswordButton setTitle:[NSString stringWithFormat:@"%ld",[password longValue]] forState:UIControlStateHighlighted];
}
@end