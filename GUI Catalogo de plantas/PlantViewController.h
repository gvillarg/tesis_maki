//
//  PlantViewController.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plant.h"

@interface PlantViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *fotoPlanta;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UILabel *nombreComunLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripcionLabel;
@property (weak, nonatomic) IBOutlet UILabel *habitatLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;

@property Plant *plantSelected;


@end
