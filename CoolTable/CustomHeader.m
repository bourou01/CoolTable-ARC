//
//  CustomHeader.m
//  CoolTable
//
//  Created by Ray Wenderlich on 9/29/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "CustomHeader.h"
#import "Common.h"

#define LIGHT_COLOR [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0]
#define DARK_COLOR [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0]

#define WHITE_COLOR [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] CGColor]
#define SHADOW_COLOR [[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5] CGColor] 

@implementation CustomHeader
@synthesize titleLabel = _titleLabel;
@synthesize lightColor = _lightColor;
@synthesize darkColor = _darkColor;


- (id)init {
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:_titleLabel];
        self.lightColor = LIGHT_COLOR;
        self.darkColor = DARK_COLOR;
    }
    return self;
}

-(void) layoutSubviews {
       
    CGFloat coloredBoxMargin = 6.0;
    CGFloat coloredBoxHeight = 40.0;
    _coloredBoxRect = CGRectMake(coloredBoxMargin, 
                                 coloredBoxMargin, 
                                 self.bounds.size.width-coloredBoxMargin*2, 
                                 coloredBoxHeight);
    
    CGFloat paperMargin = 9.0;
    _paperRect = CGRectMake(paperMargin, 
                            CGRectGetMaxY(_coloredBoxRect), 
                            self.bounds.size.width-paperMargin*2, 
                            self.bounds.size.height-CGRectGetMaxY(_coloredBoxRect));
    
    _titleLabel.frame = _coloredBoxRect;
        
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    CGColorRef greenColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0].CGColor;
        
    CGContextSetFillColorWithColor(context, redColor);
    CGContextFillRect(context, _coloredBoxRect);
    
    CGContextSetFillColorWithColor(context, greenColor);
    CGContextFillRect(context, _paperRect);
    */
        
    CGContextRef context = UIGraphicsGetCurrentContext();    

    // Draw paper
    CGContextSetFillColorWithColor(context, WHITE_COLOR);
    CGContextFillRect(context, _paperRect);

    // Draw shadow
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, SHADOW_COLOR);
    CGContextSetFillColorWithColor(context, [LIGHT_COLOR CGColor]);
    CGContextFillRect(context, _coloredBoxRect);
    CGContextRestoreGState(context);
    
    // Draw gloss and gradient
    //drawGlossAndGradient(context, _coloredBoxRect, lightColor, darkColor);
    

    drawGlossAndGradient(context, _coloredBoxRect, [NSArray arrayWithObjects:(id)[LIGHT_COLOR CGColor], (id)[DARK_COLOR CGColor], nil]);

    // Draw stroke
    CGContextSetStrokeColorWithColor(context, [DARK_COLOR CGColor]);
    CGContextSetLineWidth(context, 1.0);    
    CGContextStrokeRect(context, rectFor1PxStroke(_coloredBoxRect));    
    
}


- (void)dealloc {

    _titleLabel = nil;
    _lightColor = nil;
    _darkColor = nil;

}


@end
