//
//  MasuTests.m
//  MasuTests
//
//  Created by midnightSuyama on 07/26/2014.
//  Copyright (c) 2014 midnightSuyama. All rights reserved.
//

#import <Masu/Masu.h>

SpecBegin(Masu)

describe(@"view matching", ^{
    
    NSArray *values = @[
                        [NSValue valueWithCGSize:CGSizeMake(200.0f, 200.0f)],
                        [NSValue valueWithCGSize:CGSizeMake(200.0f, 100.0f)],
                        [NSValue valueWithCGSize:CGSizeMake(100.0f, 200.0f)],
                        ];
    for (NSValue *value in values) {
        __block CGSize size = [value CGSizeValue];
        
        context([NSString stringWithFormat:@"size %.0fx%.0f", size.width, size.height], ^{
            __block Masu *masu;
            
            beforeEach(^{
                masu = [[Masu alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
            });
            
            it(@"matches default", ^{
                expect(masu).to.haveValidSnapshot();
            });
            
            it(@"matches background", ^{
                masu.backgroundColor = [UIColor colorWithRed:0.75f green:1 blue:0.75f alpha:1];
                expect(masu).to.haveValidSnapshot();
            });
            
            it(@"matches label", ^{
                masu.text = @"Label";
                expect(masu).to.haveValidSnapshot();
            });
        });
    }
    
});

SpecEnd
