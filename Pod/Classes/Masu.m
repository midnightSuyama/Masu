//
//  Masu.m
//  Masu
//
//  Created by midnightSuyama on 07/26/2014.
//  Copyright (c) 2014年 midnightSuyama. All rights reserved.
//

#import "Masu.h"

@implementation Masu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [Masu defaultBackgroundColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [Masu renderWithSize:rect.size backgroundColor:self.backgroundColor labelText:self.text];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - UIImage

+ (UIImage *)imageWithSize:(CGSize)size
{
    return [Masu imageWithSize:size backgroundColor:nil labelText:nil];
}

+ (UIImage *)imageWithSize:(CGSize)size backgroundColor:(UIColor *)color
{
    return [Masu imageWithSize:size backgroundColor:color labelText:nil];
}

+ (UIImage *)imageWithSize:(CGSize)size labelText:(NSString *)text
{
    return [Masu imageWithSize:size backgroundColor:nil labelText:text];
}

+ (UIImage *)imageWithSize:(CGSize)size backgroundColor:(UIColor *)color labelText:(NSString *)text
{
    UIImage *image;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    [Masu renderWithSize:size backgroundColor:color labelText:text];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - private

+ (void)renderWithSize:(CGSize)size backgroundColor:(UIColor *)color labelText:(NSString *)text
{
    if (color == nil) color = [Masu defaultBackgroundColor];
    UIColor *strokeColor = [Masu strokeColorOnBackgroundColor:color];
    
    // Background
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    // Path
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, size.width, 0);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, size.width, 0);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextStrokePath(context);
    
    // Label
    NSString *label = [NSString stringWithFormat:@"%.0f x %.0f", size.width, size.height];
    if (text != nil) label = [NSString stringWithFormat:@"%@\n%@", text, label];
    
    NSMutableParagraphStyle *paragraphSyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphSyle setAlignment:NSTextAlignmentCenter];
    [paragraphSyle setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *labelAttr = @{
                                NSParagraphStyleAttributeName:  paragraphSyle,
                                NSFontAttributeName:            [UIFont boldSystemFontOfSize:13.0f],
                                NSForegroundColorAttributeName: [Masu strokeColorOnBackgroundColor:color],
                                };
    
    CGRect labelRect;
    if ([label respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // iOS 7.0 later
        labelRect = [label boundingRectWithSize:CGSizeMake(size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:labelAttr context:nil];
    } else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        const CGSize labelSize = [label sizeWithFont:labelAttr[NSFontAttributeName] constrainedToSize:CGSizeMake(size.width, CGFLOAT_MAX)];
        labelRect = CGRectMake(0, 0, labelSize.width, labelSize.height);
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
    labelRect.origin.x = (size.width  - labelRect.size.width)  / 2;
    labelRect.origin.y = (size.height - labelRect.size.height) / 2;
    
    [color setFill];
    UIRectFill(labelRect);
    
    if ([label respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        // iOS 7.0 later
        [label drawInRect:labelRect withAttributes:labelAttr];
    } else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        [strokeColor set];
        [label drawInRect:labelRect withFont:labelAttr[NSFontAttributeName]
            lineBreakMode:((NSMutableParagraphStyle *)labelAttr[NSParagraphStyleAttributeName]).lineBreakMode
                alignment:((NSMutableParagraphStyle *)labelAttr[NSParagraphStyleAttributeName]).alignment];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
}

+ (UIColor *)strokeColorOnBackgroundColor:(UIColor *)color
{
    CGFloat r, g, b;
    [color getRed:&r green:&g blue:&b alpha:NULL];
    const CGFloat y = (r * 0.299f) + (g * 0.587f) + (b * 0.114f);
    
    return (y > 0.75f) ? [UIColor blackColor] : [UIColor whiteColor];
}

+ (UIColor *)defaultBackgroundColor
{
    return [UIColor lightGrayColor];
}

@end
