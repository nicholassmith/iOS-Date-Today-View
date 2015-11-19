//
//  TodaysDateView.m
//  WOTD
//
//  Created by Nicholas Smith on 01/10/2014.
//  Copyright (c) 2014 Nicholas Smith. All rights reserved.
//

#import "TodaysDateView.h"

#import <QuartzCore/QuartzCore.h>

@implementation TodaysDateView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextFillRect(context, rect);
//    CGContextStrokeRect(context, rect);
    
    CGRect topRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height*0.2);
    
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextFillRect(context, topRect);
    
    NSMutableParagraphStyle *paragraphAlign = [[NSMutableParagraphStyle alloc] init];
    [paragraphAlign setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *dict = @{NSParagraphStyleAttributeName: paragraphAlign};
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MMMM"];
    NSAttributedString* monthStr = [[NSAttributedString alloc] initWithString:[formatter stringFromDate:currentDate] attributes:dict];
    
    CGSize stringSize = [monthStr size];
    
    CGRect textRect = CGRectMake(topRect.origin.x + floorf((topRect.size.width - stringSize.width)/2),
                                 topRect.origin.y + floorf((topRect.size.height - stringSize.height)/2),
                                 stringSize.width,
                                 stringSize.height);
    
    [monthStr drawInRect:textRect];
    
    CGRect bodyRect = CGRectMake(rect.origin.x,
                                 rect.origin.y + rect.size.height*0.2,
                                 rect.size.width,
                                 rect.size.height - rect.size.height*0.2);
    
    [formatter setDateFormat:@"d"];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:36];
    
    
    NSDictionary *dayDict = @{NSParagraphStyleAttributeName: paragraphAlign, NSFontAttributeName: font};
    NSAttributedString *dayString = [[NSAttributedString alloc] initWithString:[formatter stringFromDate:currentDate] attributes:dayDict];
    
    CGSize dayStringSize = [dayString size];
    
    CGRect dayTextRect = CGRectMake(bodyRect.origin.x + floorf((bodyRect.size.width - dayStringSize.width)/2),
                                    bodyRect.origin.y + floorf((bodyRect.size.height - dayStringSize.height)/2),
                                    dayStringSize.width, dayStringSize.height);
    
    [dayString drawInRect:dayTextRect];
    
    [self.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.layer setBorderWidth:0.4f];
    [self.layer setCornerRadius:5.0f];
    [self.layer setMasksToBounds:true];
}

@end
