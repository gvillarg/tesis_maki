//
//  CampusMapViewController.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 11-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "CampusMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface CampusMapViewController ()
@end

@implementation CampusMapViewController
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
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-12.068938
                                                            longitude:-77.080190
                                                                 zoom:15.60];
    mapView_ = [GMSMapView mapWithFrame:self.mapView.bounds camera:camera];
    mapView_.myLocationEnabled = YES;
    [self.mapView addSubview: mapView_];
    
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    mapView_.frame = self.mapView.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
