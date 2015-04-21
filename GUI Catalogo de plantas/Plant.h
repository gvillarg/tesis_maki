//
//  Plant.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plant : NSObject

@property NSString *name;
@property NSString *urlImage;
@property NSInteger id;

@property NSString *descripcion;
@property NSString *habitat;
@property NSString *urlMasInfo;

@property NSInteger *Familia_Id;
@property NSInteger *Genero_Id;
@property NSInteger *Especie_Id;


+ (Plant *) initWithJson: (NSMutableDictionary *) ObjetoJason;
+ (Plant *) initWithJson2: (NSMutableDictionary *) ObjetoJason;
@end
