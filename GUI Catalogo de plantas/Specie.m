//
//  Specie.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17/04/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "Specie.h"

@implementation Specie

+ (Specie *) initWithJson: (NSMutableDictionary *) ObjetoJason{
    Specie *newspecie = [[Specie alloc] init];
    newspecie.name = [ObjetoJason objectForKey:@"Nombre"];
    newspecie.id = ((NSNumber *)[ObjetoJason objectForKey:@"Id"]).integerValue;
    
    
    return newspecie;
}


@end
