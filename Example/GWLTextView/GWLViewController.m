//
//  GWLViewController.m
//  GWLTextView
//
//  Created by gaowanli on 01/22/2017.
//  https://github.com/gaowanli
//  Copyright (c) 2017 gaowanli. All rights reserved.
//

#import "GWLViewController.h"
#import "GWLTextView.h"

@interface GWLViewController () <GWLTextViewDelegate>

@property (nonatomic, strong) GWLTextView *textView;

@end


@implementation GWLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightTextColor];
    
    self.textView = [[GWLTextView alloc] initWithFrame:CGRectMake(10.0f, 40.0f, CGRectGetWidth(self.view.bounds) - 20.0f, 0.0f)];
    self.textView.layer.cornerRadius = 3.0f;
    self.textView.font = [UIFont systemFontOfSize:14.0f];
    
    self.textView.placeHolder = @"Please input something...";
    self.textView.limitedToNumberOfLines = 5;
    self.textView.aDelegate = self;
    
    [self.view addSubview:self.textView];
}

#pragma mark - GWLTextViewDelegate
- (void)textView:(GWLTextView *)textView didChangeHeight:(CGFloat)height {
    if (textView == _textView) {
        CGRect frame = _textView.frame;
        frame.size.height = height;
        self.textView.frame = frame;
    }
}

@end
