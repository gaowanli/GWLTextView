//
//  GWLTextView.h
//  GWLTextView
//
//  Created by gaowanli on 01/22/2017.
//  https://github.com/gaowanli
//  Copyright (c) 2017 gaowanli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GWLTextView;

@protocol GWLTextViewDelegate <NSObject>

- (void)textView:(GWLTextView *)textView didChangeHeight:(CGFloat)height;

@end

@interface GWLTextView : UITextView

@property (nonatomic, assign) NSInteger defaultToNumberOfLines;
@property (nonatomic, assign) NSInteger limitedToNumberOfLines;
@property (nonatomic, copy) NSString *placeHolder; 
@property (nonatomic, weak) id<GWLTextViewDelegate> aDelegate;

@end
