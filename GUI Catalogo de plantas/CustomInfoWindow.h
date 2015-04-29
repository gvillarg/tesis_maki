//
//  CustomInfoWindow.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 28-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomInfoWindow : UIView
@property (weak, nonatomic) IBOutlet UILabel *nombreComunLabel;
@property (weak, nonatomic) IBOutlet UILabel *familiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *generoLabel;
@property (weak, nonatomic) IBOutlet UILabel *especieLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoPlant;

@end
