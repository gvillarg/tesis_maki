//
//  CampusMapViewController.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 11-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Plant.h"

@interface CampusMapViewController : UIViewController <GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;

@property (weak, nonatomic) IBOutlet UIImageView *selectedPlantImage;

@property (nonatomic) Plant *selectedPlant;


@end
