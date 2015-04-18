//
//  Cell.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nombrePlantaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *PlantaImagen;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
