//
//  NSArray+Extras.h
//  MoombaPlusMobile
//
//  Created by  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extras)

typedef NSInteger (^compareBlock)(id this, id that);

- (NSUInteger) indexForInsertingObject:(id)anObject sortedUsingBlock:(compareBlock)compare;

@end
