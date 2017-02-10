//
//  GWLTextView.m
//  GWLTextView
//
//  Created by gaowanli on 01/22/2017.
//  https://github.com/gaowanli
//  Copyright (c) 2017 gaowanli. All rights reserved.
//

#import "GWLTextView.h"

@interface GWLTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation GWLTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.placeHolderLabel];
        
        self.defaultToNumberOfLines = 1.0f;
        self.limitedToNumberOfLines = NSIntegerMax;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidBegin:) name:UITextViewTextDidBeginEditingNotification object:self];
        
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
    UIEdgeInsets textContainerInset = self.textContainerInset;
    
    CGFloat x = lineFragmentPadding + textContainerInset.left;
    CGFloat width = CGRectGetWidth(self.bounds) - x - lineFragmentPadding - textContainerInset.right;
    CGFloat height = [self.placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
    
    CGRect rect = CGRectMake(x, self.textContainerInset.top, width, height);
    
    self.placeHolderLabel.frame = rect;
    
    if ([self.aDelegate respondsToSelector:@selector(textView:didChangeHeight:)]) {
        rect.size.height = CGFLOAT_MAX;
        
        CGFloat minHeight = [self.placeHolderLabel textRectForBounds:rect limitedToNumberOfLines:_defaultToNumberOfLines].size.height;
        CGFloat maxHeight = [self.placeHolderLabel textRectForBounds:rect limitedToNumberOfLines:_limitedToNumberOfLines].size.height;
        
        height = MAX(height, minHeight);
        height = MIN(height, maxHeight);
        
        [self.aDelegate textView:self didChangeHeight:textContainerInset.top + height + textContainerInset.bottom];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self) {
        if ([keyPath isEqualToString:@"font"]) {
            self.placeHolderLabel.font = self.font;
        }else if ([keyPath isEqualToString:@"text"]) {
            if (self.text.length <= 0) {
                self.placeHolderLabel.hidden = NO;
            }
        }
    }
}

#pragma mark - methods
- (void)textViewTextDidChange:(NSNotification *)notification {
    if (notification.object == self) {
        if (self.text.length > 0) {
            self.placeHolderLabel.text = self.text;
            self.placeHolderLabel.hidden = YES;
        }else {
            self.placeHolderLabel.text = _placeHolder;
            self.placeHolderLabel.hidden = NO;
        }
    }
}

- (void)textViewTextDidBegin:(NSNotification *)notification {
    if (notification.object == self) {
        if (self.text.length <= 0) {
            self.placeHolderLabel.hidden = NO;
        }
    }
}

#pragma mark - setter
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
}

#pragma mark - getter
- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeHolderLabel;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"font"];
    [self removeObserver:self forKeyPath:@"text"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

@end
