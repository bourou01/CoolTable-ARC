//
//  CustomCellBackground.m
//  CoolTable
//
//  Created by Ray Wenderlich on 9/29/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "CustomCellBackground.h"
#import "Common.h"

#import "CommonColors.h"

@implementation CustomCellBackground


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGRect paperRect = self.bounds;
    
    // Fill with gradient
    drawLinearGradient(context, paperRect, [NSArray arrayWithObjects:(id)WHITE_COLOR, (id)LIGHT_GRAY_COLOR, nil]);

    // Add white 1 px stroke
    CGRect strokeRect = paperRect;
    strokeRect.size.height -= 1;
    strokeRect = rectFor1PxStroke(strokeRect);
    
    
    CGContextSetStrokeColorWithColor(context, WHITE_COLOR);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, strokeRect);
    
 
    // Add separator
    CGPoint startPoint = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
    CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
    draw1PxStroke(context, startPoint, endPoint, (id)SEPARATOR_COLOR);
}

@end
