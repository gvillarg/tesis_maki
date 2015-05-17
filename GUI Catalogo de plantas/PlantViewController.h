//
//  PlantViewController.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plant.h"
#import "Family.h"
#import "Gender.h"
#import "Specie.h"

@interface PlantViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *fotoPlanta;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UILabel *nombreComunLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripcionLabel;
@property (weak, nonatomic) IBOutlet UILabel *habitatLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (strong, nonatomic) IBOutlet UIButton *btnMapa;

@property (strong, nonatomic) IBOutlet UILabel *familyLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *specieLabel;

@property Plant *plantSelected;
@property Family *familySelected;
@property Gender *genderSelected;
@property Specie *specieSelected;

@property int vieneDelMapa;

-(void) showSaveImageMenu: (UILongPressGestureRecognizer *)recognizer;

@end
