//
//  PlantViewController.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 17-04-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "PlantViewController.h"
#import "Plant.h"
#import <QuartzCore/QuartzCore.h>
#import "CampusMapViewController.h"
@interface PlantViewController ()

@end

@implementation PlantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // MAKI: He comentado esto porque aqui se cae
    NSURL *url = [[NSURL alloc] initWithString:[self.plantSelected urlImage]];
    [self fetchImageFromURL:url];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundDetailView"]];
    self.nombreComunLabel.text = [NSString stringWithFormat: @"Nombre Comun: %@", [self.plantSelected name]];
    self.descripcionLabel.text =[NSString stringWithFormat: @"%@", [self.plantSelected descripcion]];
    self.habitatLabel.text = [NSString stringWithFormat: @"%@", [self.plantSelected habitat]];
    self.familyLabel.text = [NSString stringWithFormat:@"Familia: %@", [self.plantSelected nombreFamilia]];
    self.genderLabel.text = [NSString stringWithFormat:@"Genero: %@", [self.plantSelected nombreGenero]];
    self.specieLabel.text = [NSString stringWithFormat:@"Especie: %@", [self.plantSelected nombreEspecie]];
    self.btnInfo.layer.cornerRadius = 6;
    self.btnInfo.clipsToBounds = YES;
    self.btnMapa.layer.cornerRadius = 6;
    self.btnMapa.clipsToBounds = YES;
    
    if (self.vieneDelMapa == 1){
        self.btnMapa.hidden = 1;
    }
    /*UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Background2"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];*/
    
}
- (IBAction)MasInfoButton:(UIButton *)sender {
    NSString *miURLString = [[NSString alloc] initWithString:[self.plantSelected urlMasInfo]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:miURLString]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)fetchImageFromURL: (NSURL *)url {
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error==nil) {
            self.fotoPlanta.image = [UIImage imageWithData:data];
        }
        [self.spinner stopAnimating];
        
    }];
    
    [task resume];
    [self.spinner startAnimating];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"plantToMapSegue"]){
        
        CampusMapViewController *pv = [segue destinationViewController];
        
        pv.selectedPLant = self.plantSelected;
    }
}


@end
