//
//  MathUtil.h
//  Calculator
//
//  Created by Jackie Chun on 7/13/14.
//  Copyright (c) 2014 Jackie Chun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathUtil : NSObject
+(BOOL)isNum:(NSString*) text;
+(BOOL)isRealNum:(NSString*) text;
+(BOOL)isNagtive:(NSString*) text;
@end
