//
//  GDataXMLElement-Extras.m
//  MoombaPlusMobile
//
//  Created by  on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GDataXMLElement-Extras.h"

@implementation GDataXMLElement (Extras)

- (GDataXMLElement *) elementForChild:(NSString *)childName {
   NSArray *children = [self elementsForName:childName];
   
   if (children.count > 0) {
      GDataXMLElement *element = (GDataXMLElement *) [children objectAtIndex:0];
      
      return element;
   } else {
      return nil;
   }
}

- (NSString *) valueForChild:(NSString *)childName {
   return [[self elementForChild: childName] stringValue];
}

@end
