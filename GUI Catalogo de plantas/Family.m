//
//  Family.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 30-03-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "Family.h"

@implementation Family

+ (Family *) initWithJson: (NSMutableDictionary *) ObjetoJason{
    Family *newfamily = [[Family alloc] init];
    newfamily.name = [ObjetoJason objectForKey:@"Nombre"];
    newfamily.id = ((NSNumber *)[ObjetoJason objectForKey:@"Id"]).integerValue;
    newfamily.cantgen = ((NSNumber *)[ObjetoJason objectForKey:@"cantGen"]).integerValue;
    
    return newfamily;
}

@end
