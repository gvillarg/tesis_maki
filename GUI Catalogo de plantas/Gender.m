//
//  Gender.m
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 4/4/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "Gender.h"

@implementation Gender

+ (Gender *) initWithJson: (NSMutableDictionary *) ObjetoJason{
    Gender *newgender = [[Gender alloc] init];
    newgender.name = [ObjetoJason objectForKey:@"Nombre"];
    newgender.id = ((NSNumber *)[ObjetoJason objectForKey:@"Id"]).integerValue;
    newgender.cantEsp = ((NSNumber *)[ObjetoJason objectForKey:@"COUNT"]).integerValue;
    
    return newgender;
}

@end
