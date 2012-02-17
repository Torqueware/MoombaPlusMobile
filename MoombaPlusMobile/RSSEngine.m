//
//  RSSEngine.m
//  MoombaPlusMobile
//
//  Created by William Millard on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSEngine.h"

@interface RSSEngine () {
   __strong NSString *identity;
}

@property (readwrite, strong, atomic) RSSEngine             *RSSingleton;
@property (readwrite, strong, atomic) NSMutableDictionary   *cache;

- (id) startEngine: (NSString *) identifier;

@end

@implementation RSSEngine : NSObject

@synthesize RSSingleton = _RSSingleton;
@synthesize cache       = _cache;



(id) init: (NSString *) identifier {
   identity = identifier;
   
   return _RSSingleton = [self init: identifier];
}

(id) startEngine: (NSString *) identifier {
   _identity    = identifier;
   _RSSingleton = [super init];
   
   if (identifier) {
      if (self = [super init]) {
         self.cache 
      }
//   raise: hell;
//   } else if (self = super [init]) {
//      self.cache
//   }
//   }
//   self = [super init];
//   
//   if (self) {
//       
//   }
//   
//}





@end
