//
//  UIView+Masu.m
//  Masu
//
//  Created by midnightSuyama on 09/17/2014.
//  Copyright (c) 2014年 midnightSuyama. All rights reserved.
//

#import "UIView+Masu.h"
#import "Masu.h"

@interface MasuDisableHitTest : Masu
@end

@implementation MasuDisableHitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}

@end

#pragma mark

@implementation UIView (Masu)

- (void)showMasu
{
    MasuDisableHitTest *masu = (MasuDisableHitTest *)[self viewWithTag:[UIView masuTag]];
    if (masu == nil) {
        masu = [[MasuDisableHitTest alloc] initWithFrame:self.bounds];
        masu.backgroundColor  = [UIColor colorWithWhite:0 alpha:0.5f];
        masu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        masu.tag              = [UIView masuTag];
        [self addSubview:masu];
    } else {
        [masu setHidden:NO];
    }
}

- (void)hideMasu
{
    MasuDisableHitTest *masu = (MasuDisableHitTest *)[self viewWithTag:[UIView masuTag]];
    [masu setHidden:YES];
}

+ (NSInteger)masuTag
{
    return [NSStringFromClass([Masu class]) hash];
}

@end
