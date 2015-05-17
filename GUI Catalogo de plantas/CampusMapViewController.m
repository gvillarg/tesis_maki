//
//  CampusMapViewController.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 11-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "CampusMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SearchMapTableViewController.h"
#import "Plant.h"
#import "CustomInfoWindow.h"
#include <stdlib.h>
#import <math.h>
#import "PlantViewController.h"
#import "Cell.h"
@import UIKit;

#define ARC4RANDOM_MAX      0x100000
@interface CampusMapViewController ()


@end

@implementation CampusMapViewController

//@synthesize selectedPlant;
 GMSMapView *mapView_;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //-12.068943,-77.08019,17
    
    // Creates a marker in the center of the map.
  //  GMSMarker *marker = [[GMSMarker alloc] init];
  //  marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
  //  marker.title = @"Sydney";
  //  marker.snippet = @"Australia";
  //  marker.map = mapView_;
    
  //  self.searchButton.layer.cornerRadius = 6;
  //  self.searchButton.clipsToBounds = YES;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-12.068938
                                                            longitude:-77.080190
                                                                 zoom:16.60];
    mapView_ = [GMSMapView mapWithFrame:self.mapView.bounds camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    
    
    [self.mapView addSubview: mapView_];
    
    [self muestraMarkerPlants];
    
    [self updateUIForSelectedPlant];
    
   }

-(void)setSelectedPlant:(Plant *)selectedPlant {
    _selectedPlant = selectedPlant;
    [self updateUIForSelectedPlant];
}

-(void) updateUIForSelectedPlant {

    self.selectedPlantImage.image = nil;
    
    if (self.selectedPlant) {
        
        self.nameLabel.text = self.selectedPlant.name;
        NSString *urlString = [[NSString alloc] initWithString:[self.selectedPlant urlImage]];
        
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        
        NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error==nil) {
                    self.selectedPlantImage.image = [UIImage imageWithData:data];
                    [self glowForView:self.selectedPlantImage];
                }
                [self.spinner stopAnimating];
            });
        }];
        
        [task resume];
        [self.spinner startAnimating];
        
        mapView_.camera = [GMSCameraPosition cameraWithLatitude:((NSNumber *)self.selectedPlant.localidad_x).doubleValue longitude:((NSNumber *)self.selectedPlant.localidad_y).doubleValue zoom:16.60];
    }
}

-(void)prepareGlowForView: (UIView *)view {
    
    view.layer.shadowColor = [UIColor blueColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowRadius = 20;
}

-(void)glowForView: (UIView *)view {
    [self prepareGlowForView:view];
    
    CABasicAnimation *glowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    glowAnimation.fromValue = @0;
    glowAnimation.toValue = @1;
    glowAnimation.repeatCount = 10;
    glowAnimation.duration = 2.0;
    glowAnimation.autoreverses = YES;
    
    [view.layer addAnimation:glowAnimation forKey:@"glow"];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    mapView_.frame = self.mapView.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)muestraMarkerPlants{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.appearAnimation=YES;
    //marker.position = CLLocationCoordinate2DMake(-12.069525, -77.080566);
    marker.position = CLLocationCoordinate2DMake([self.selectedPLant localidad_x].doubleValue, [self.selectedPLant localidad_y].doubleValue);
    marker.icon = [UIImage imageNamed:@"plantIcon.png"];
    marker.map = mapView_;
}*/

-(void)muestraMarkerPlants{
   
    
    int randomNumber = arc4random_uniform(5);
    NSLog(@"numero random %d", randomNumber);
    for ( int i=0; i<=randomNumber; i++) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.appearAnimation=YES;
        //double valSum = ((double)arc4random() / ARC4RANDOM_MAX);
        
        if (i==0){
           marker.position = CLLocationCoordinate2DMake(((NSNumber *)[self.selectedPlant localidad_x]).doubleValue, ((NSNumber *)[self.selectedPlant localidad_y]).doubleValue);
        }else{
            NSString *posx = [self.selectedPlant localidad_x];
            NSRange range1 = NSMakeRange(7,1);
            posx = [posx stringByReplacingCharactersInRange:range1 withString:[NSString stringWithFormat: @"%d",i]];
            NSString *posy = [self.selectedPlant localidad_y];
            NSRange range2 = NSMakeRange(8,1);
            posy = [posy stringByReplacingCharactersInRange:range2 withString:[NSString stringWithFormat: @"%d",i+1]];
            marker.position = CLLocationCoordinate2DMake(((NSNumber *)posx).doubleValue , ((NSNumber *)posy).doubleValue);

        }
        
        marker.icon = [UIImage imageNamed:@"mapPin"];
        marker.map = mapView_;
        
        /*if (self.seleccionoUnaPlanta == 1){
        NSString *urlString = [[NSString alloc] initWithString:[self.selectedPLant urlSmallImage]];
        
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        
        NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error==nil) {
                    self.selectedPlantImage.image = [UIImage imageWithData:data];
                }
                //[cell.spinner stopAnimating];
            });
        }];
        
        [task resume];
        //[infoWindow.spinner startAnimating];
        }*/
        
    }
}

/*-(UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    CustomInfoWindow *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    infoWindow.nombreComunLabel.text = [NSString stringWithFormat: @"%@", [self.selectedPLant name]];
    infoWindow.familiaLabel.text = [NSString stringWithFormat: @"Familia: %@", [self.selectedPLant nombreFamilia]];
    infoWindow.generoLabel.text = [NSString stringWithFormat: @"Genero: %@", [self.selectedPLant nombreGenero]];
    infoWindow.especieLabel.text = [NSString stringWithFormat: @"Especie: %@", [self.selectedPLant nombreEspecie]];

    NSString *urlString = [[NSString alloc] initWithString:[self.selectedPLant urlImage]];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error==nil) {
            infoWindow.photoPlant.image = [UIImage imageWithData:data];
        }
        [infoWindow.spinner stopAnimating];
    }];
    //infoWindow.photoPlant.image = [UIImage imageNamed:@"PlantaModelo2"];
    [task resume];
    [infoWindow.spinner startAnimating];
    return infoWindow;
}*/

/*-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
     NSLog(@"perform segue");
    [self performSegueWithIdentifier:@"ShowPlantDetails" sender:self];
}*/



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    
    //Para que desaparazca la ventana
    if (![segue.sourceViewController isBeingDismissed]){
        [segue.sourceViewController dismissViewControllerAnimated:true completion:nil];
    }
    
//    SearchMapTableViewController *source = [segue sourceViewController];
//    self.selectedPlant = source.plantSelected;
    
    [mapView_ clear];
    
    
    

    
    [self muestraMarkerPlants];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]){
        
        PlantViewController *pv = [segue destinationViewController];
        
        Plant *plant = self.selectedPlant;
//        Specie *specie = [self.nuevasEspecies objectAtIndex:indexPath.row];
//        plant.nombreFamilia = [self.familySelected name];
//        plant.nombreGenero = [self.genderSelected name];
//        plant.nombreEspecie = [specie name];
        
        pv.plantSelected = plant;
        
        //pv.familySelected = self.familySelected;
        //pv.genderSelected = self.genderSelected;
        //pv.specieSelected = specie;
        
    }
    
    if ([segue.identifier isEqualToString:@"ShowPlantDetails"]){
        
        PlantViewController *pv = [segue destinationViewController];

        Plant *plant = self.selectedPlant;
        
        pv.plantSelected = plant;
        pv.vieneDelMapa = 1;
    }
    if ([segue.identifier isEqualToString:@"buttonSegue"]){
        
        PlantViewController *pv = [segue destinationViewController];
        
        Plant *plant = self.selectedPlant;
        
        pv.plantSelected = plant;
        pv.vieneDelMapa = 1;
    }
    
}


@end
