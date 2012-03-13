//
//  NSArray+Extras.m
//  MoombaPlusMobile
//
//  Created by  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Extras.h"

@implementation NSArray (Extras)

- (NSUInteger) indexForInsertingObject:(id)anObject sortedUsingBlock:(compareBlock)compare {
    NSUInteger i = 0, n = [self count];
    
    while (i < n) {
        NSUInteger j = (i + n) / 2;
        id current = [self objectAtIndex:j];
        
        if (compare(anObject, current) < 0) {
            i = j + 1;
        } else {
            n = j;
        }
    }
    
    return i;
}


@end
