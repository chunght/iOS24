//
//  MathUtil.m
//  Calculator
//
//  Created by Jackie Chun on 7/13/14.
//  Copyright (c) 2014 Jackie Chun. All rights reserved.
//

#import "MathUtil.h"

@implementation MathUtil
+(BOOL)isNum:(NSString*)text{
	return [text isEqualToString:@"0"] || [text isEqualToString:@"1"] || [text isEqualToString:@"2"] || [text isEqualToString:@"3"] || [text isEqualToString:@"4"] || [text isEqualToString:@"5"] || [text isEqualToString:@"6"] || [text isEqualToString:@"7"] || [text isEqualToString:@"8"] || [text isEqualToString:@"9"];
}
+(BOOL)isRealNum:(NSString*)text{
	NSRange range = [text rangeOfString:@"."];
	return range.length != 0;
}
+(BOOL)isNagtive:(NSString *)text{
	return 	[text hasPrefix:@"-"];
}
+(NSString*)calculateRegarded:(NSString*)regarded{
	
	return @"";
}

@end
