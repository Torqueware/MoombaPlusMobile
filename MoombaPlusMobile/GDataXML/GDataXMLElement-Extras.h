//
//  GDataXMLElement-Extras.h
//  MoombaPlusMobile
//
//  Created by  on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GDataXMLNode.h"

@interface GDataXMLElement (Extras) //: GDataXMLElement

- (GDataXMLElement *) elementForChild:(NSString *)childName;
- (NSString *)        valueForChild:(NSString *)childName;

@end
