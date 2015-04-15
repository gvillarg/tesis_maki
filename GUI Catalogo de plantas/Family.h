//
//  Family.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 30-03-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gender.h"

@interface Family : NSObject

@property NSString *name;
@property NSInteger id;
@property NSInteger cantgen;
@property NSMutableArray *genders;

+ (Family *) initWithJson: (NSMutableDictionary *) ObjetoJason;
@end
