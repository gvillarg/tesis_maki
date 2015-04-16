//
//  Gender.h
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 4/4/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gender : NSObject

@property NSString *name;
@property NSInteger id;
@property NSInteger cantEsp;

+ (Gender *) initWithJson: (NSMutableDictionary *) ObjetoJason;

@end
