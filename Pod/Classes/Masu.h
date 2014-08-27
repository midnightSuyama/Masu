//
//  Masu.h
//  Masu
//
//  Created by midnightSuyama on 07/26/2014.
//  Copyright (c) 2014年 midnightSuyama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Masu : UIView

@property (strong, nonatomic) NSString *text;

+ (UIImage *)imageWithSize:(CGSize)size;
+ (UIImage *)imageWithSize:(CGSize)size backgroundColor:(UIColor *)color;
+ (UIImage *)imageWithSize:(CGSize)size labelText:(NSString *)text;
+ (UIImage *)imageWithSize:(CGSize)size backgroundColor:(UIColor *)color labelText:(NSString *)text;

@end
