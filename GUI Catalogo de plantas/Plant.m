//
//  Plant.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "Plant.h"

@implementation Plant

+ (Plant *) initWithJson: (NSMutableDictionary *) ObjetoJason{
    Plant *newplant = [[Plant alloc] init];
    newplant.name = [ObjetoJason objectForKey:@"Nombre_comun"];
    newplant.id = ((NSNumber *)[ObjetoJason objectForKey:@"Planta_Id"]).integerValue;
    newplant.urlImage = [ObjetoJason objectForKey:@"Urlimagen"];
    newplant.descripcion = [ObjetoJason objectForKey:@"Dato1"];
    newplant.habitat = [ObjetoJason objectForKey:@"Dato2"];
    newplant.urlMasInfo = [ObjetoJason objectForKey:@"Dato3"];
    
    return newplant;
}

+ (Plant *) initWithJson2: (NSMutableDictionary *) ObjetoJason{
    Plant *newplant = [[Plant alloc] init];
    newplant.name = [ObjetoJason objectForKey:@"Nombre_comun"];
    newplant.id = ((NSNumber *)[ObjetoJason objectForKey:@"Id"]).integerValue;
    newplant.urlImage = [ObjetoJason objectForKey:@"Urlimagen"];
    newplant.descripcion = [ObjetoJason objectForKey:@"Dato1"];
    newplant.habitat = [ObjetoJason objectForKey:@"Dato2"];
    newplant.urlMasInfo = [ObjetoJason objectForKey:@"Dato3"];
    newplant.Familia_Id = ((NSNumber *)[ObjetoJason objectForKey:@"Familia_Id"]).integerValue;
    newplant.Genero_Id = ((NSNumber *)[ObjetoJason objectForKey:@"Genero_Id"]).integerValue;
    newplant.Especie_Id = ((NSNumber *)[ObjetoJason objectForKey:@"Especie_Id"]).integerValue;
    return newplant;
}

@end
