//
//  CampusMapViewController.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 11-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface CampusMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end
