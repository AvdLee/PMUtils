//
//  SpinnerViewController.m
//  OperatorIOS
//
//  Created by Peter Meyers on 10/15/14.
//  Copyright (c) 2014 Operator. All rights reserved.
//

#import "PMProgressHUD.h"
#import "UIView+PMUtils.h"

@interface PMProgressHUD ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *spinnerOverlayImageView;

@end

@implementation PMProgressHUD

+ (instancetype) progressHUD
{
    NSString *bundleName = [NSString stringWithFormat:@"%@.bundle", NSStringFromClass(self)];
    NSURL *URL = [[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:bundleName];
    NSBundle *PMProgressHUDBundle = [NSBundle bundleWithURL:URL];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:PMProgressHUDBundle];
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.contentView.layer.cornerRadius = ceilf(self.contentView.bounds.size.height/2.0f);
    self.progressHUDState = PMProgressHUDStatePending;
}

- (void)setProgressHUDState:(PMProgressHUDState)progressHUDState
{
    _progressHUDState = progressHUDState;
    switch (progressHUDState)
    {
        case PMProgressHUDStatePending:
            self.spinnerOverlayImageView.hidden = YES;
            self.activityIndicator.hidden = NO;
            [self.activityIndicator startAnimating];
            break;
        case PMProgressHUDStateComplete:
            self.spinnerOverlayImageView.hidden = NO;
            self.activityIndicator.hidden = YES;
            break;
        case PMProgressHUDStateFailed:
            self.spinnerOverlayImageView.hidden = YES;
            self.activityIndicator.hidden = NO;
            [self.activityIndicator stopAnimating];
            break;
    }
}

- (void)setMessage:(NSString *)message
{
    self.messageLabel.text = message;
    CGSize size = [self.messageLabel sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
    if (self.superview == nil || self.messageLabel.frame.size.width < size.width) {
        self.labelWidth.constant = size.width;
    }
}

- (NSString *)message
{
    return self.messageLabel.text;
}

- (void) presentAfterDelay:(NSTimeInterval)delay completion:(void(^)(void))completion
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (!self.superview) {
            self.frame = [UIApplication sharedApplication].keyWindow.bounds;
            [[UIApplication sharedApplication].keyWindow addSubview:self];
            if (completion) {
                completion();
            }
        }
    });
}

- (void) dismissAfterDelay:(NSTimeInterval)delay completion:(void(^)(void))completion
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        if (completion) {
            completion();
        }
    });
}

@end
