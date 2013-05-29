//
//  CStringUtility.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CStringUtility.h"

@implementation CStringUtility

+ (NSString *)spacedMoneyString:(NSString *)moneyString
{
    NSMutableString *temp = [NSMutableString stringWithString:moneyString];
    
    int strLen = [temp length];
    while (strLen >= 4)
    {
        [temp insertString:@" " atIndex:strLen - 3];
        strLen -= 3;
    }
    
    return temp;
}

@end
