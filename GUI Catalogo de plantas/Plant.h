//
//  Plant.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Plant : NSObject

@property NSString *name;
@property NSString *urlImage;
@property NSString *urlSmallImage;
@property NSInteger id;

@property NSString *descripcion;
@property NSString *habitat;
@property NSString *urlMasInfo;

@property NSInteger *Familia_Id;
@property NSInteger *Genero_Id;
@property NSInteger *Especie_Id;

@property NSString *nombreFamilia;
@property NSString *nombreGenero;
@property NSString *nombreEspecie;

@property NSString *localidad_x;
@property NSString *localidad_y;

@property UIImage *smallImage;
@property UIImage *image;

+ (Plant *) initWithJson: (NSMutableDictionary *) ObjetoJason;
+ (Plant *) initWithJson2: (NSMutableDictionary *) ObjetoJason;
@end
