//
//  Specie.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17/04/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Specie : NSObject

@property NSString *name;
@property NSInteger id;


+ (Specie *) initWithJson: (NSMutableDictionary *) ObjetoJason;

@end
