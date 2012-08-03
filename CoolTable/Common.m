//
//  Common.m
//  CoolTable
//
//  Created by Ray Wenderlich on 9/29/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "Common.h"
#import "CommonColors.h"


CGRect rectFor1PxStroke(CGRect rect) {
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
}

void drawLinearGradient(CGContextRef context, CGRect rect, NSArray *startAndEndColors) {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) startAndEndColors, locations);

 
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
 

 
}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, id color) {
    
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, (__bridge CGColorRef)(color));
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);        
    
}

void drawGlossAndGradient(CGContextRef context, CGRect rect, NSArray *startAndEndColors) {
    
    drawLinearGradient(context, rect, startAndEndColors);

    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);
    

    drawLinearGradient(context, topHalf, [NSArray arrayWithObjects:(id)GLOSS_COLOR_1, (id)GLOSS_COLOR_2, nil]);
    
}

CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight) {
    
    CGRect arcRect = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height - arcHeight,
                                rect.size.width, arcHeight);
    
    CGFloat arcRadius = (arcRect.size.height/2) + (pow(arcRect.size.width, 2) / (8*arcRect.size.height));
    CGPoint arcCenter = CGPointMake(arcRect.origin.x + arcRect.size.width/2, arcRect.origin.y + arcRadius);
    
    CGFloat angle = acos(arcRect.size.width / (2*arcRadius));
    CGFloat startAngle = radians(180) + angle;
    CGFloat endAngle = radians(360) - angle;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, arcRadius, startAngle, endAngle, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    return path;
    
}