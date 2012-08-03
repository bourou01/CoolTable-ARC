//
//  CustomFooter.m
//  CoolTable
//
//  Created by Ray Wenderlich on 9/30/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "CustomFooter.h"
#import "Common.h"

#define WHITE_COLOR [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] CGColor]

#define LIGHT_GRAY_COLOR_ [[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0] CGColor]

#define DARK_GRAY_COLOR [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0] CGColor]
#define SHADOW_COLOR [[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5] CGColor]


@implementation CustomFooter


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat paperMargin = 9.0;
    CGRect paperRect = CGRectMake(self.bounds.origin.x+paperMargin, 
                            self.bounds.origin.y,
                            self.bounds.size.width-paperMargin*2, 
                            self.bounds.size.height);

    CGRect arcRect = paperRect;
    arcRect.size.height = 8;

    CGContextSaveGState(context);
    CGMutablePathRef arcPath = createArcPathFromBottomOfRect(arcRect, 4.0);
    CGContextAddPath(context, arcPath);
    CGContextClip(context);            
    drawLinearGradient(context, paperRect, [NSArray arrayWithObjects:(id)LIGHT_GRAY_COLOR_, (id)DARK_GRAY_COLOR, nil]);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGPoint pointA = CGPointMake(arcRect.origin.x, arcRect.origin.y + arcRect.size.height - 1);
    CGPoint pointB = CGPointMake(arcRect.origin.x, arcRect.origin.y);
    CGPoint pointC = CGPointMake(arcRect.origin.x + arcRect.size.width - 1, arcRect.origin.y);
    CGPoint pointD = CGPointMake(arcRect.origin.x + arcRect.size.width - 1, arcRect.origin.y + arcRect.size.height - 1);
    draw1PxStroke(context, pointA, pointB, (id)WHITE_COLOR);
    draw1PxStroke(context, pointC, pointD, (id)WHITE_COLOR);
    CGContextRestoreGState(context);

    CGContextAddRect(context, paperRect);
    CGContextAddPath(context, arcPath);
    CGContextEOClip(context);
    CGContextAddPath(context, arcPath);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, SHADOW_COLOR);
    CGContextFillPath(context);
    
    CFRelease(arcPath);
    
}

- (void)dealloc {

}


@end
