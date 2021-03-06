//
//  DetailPhotoViewController.m
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 5/3/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "DetailPhotoViewController.h"
#import "AFNetworking.h"
#import "Plant.h"
#import "PlantViewController.h"
#import "DetailPhotoTableViewCell.h"

@interface DetailPhotoViewController ()

@property NSMutableArray *idList;
@property NSMutableArray *plants;
@property NSMutableArray *nuevasPlantas;
@end

@implementation DetailPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.idList = [[NSMutableArray alloc]init];
    self.photoImage.image = self.photoTaken;
    [self simularAlgoritmo];
    [self getPlants];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPlants{
    // RECIEN COMENTADO
    //  NSMutableDictionary *diccionarioAMandar = [[NSMutableDictionary alloc]initWithObjectsAndKeys: [self.familySelected objectForKey:@"Id"],@"id",nil];
    
   NSMutableDictionary *diccionarioAMandar = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.idList,@"arreglo", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:@"http://inform.pucp.edu.pe/~a20090212/servicioFoto2.php" parameters:diccionarioAMandar success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSMutableDictionary * respuesta = [[NSMutableDictionary alloc] init];
        respuesta = responseObject;
        self.plants  = [respuesta objectForKey:@"result"];
        
        [self getPlantNames];
        NSLog(@"MAKI JSON: %@", responseObject);
        [self.PlantListTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No se pudo acceder al servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

-(void)getPlantNames{
    self.nuevasPlantas = [[NSMutableArray alloc]init];
    Plant *newPlant;
    for (NSMutableDictionary *ObjetoDiccionario in self.plants){
        //nameFam = [ObjetoDiccionario objectForKey:@"Nombre"];
        newPlant = [Plant initWithJson2:ObjetoDiccionario];
        [self.nuevasPlantas addObject:newPlant];
    }
    
}
-(void) simularAlgoritmo{
    
    int seRepite = 0;
    int randomNumber = arc4random_uniform(7)+1;
    for (int i=0; i<=randomNumber; i++) {
        seRepite = 0;
        int randomId = arc4random_uniform(110)+3;
        NSNumber *randomIDNumber = [NSNumber numberWithInt:randomId];
        NSMutableDictionary *randomIdDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:randomIDNumber, @"id", nil];
        
        
        if ([self.idList count]==0){
            [self.idList addObject:randomIdDictionary];
        }
        else {
            for (NSMutableDictionary *ObjetoDiccionario in self.idList) {
                if (((NSNumber *)[ObjetoDiccionario objectForKey:@"id"]).intValue == randomId ){
                    seRepite = 1;
                }
            }
            if (seRepite == 0){
                 [self.idList addObject:randomIdDictionary];
            }
            
        }
        
        
    }
}

# pragma mark  - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return [self.nuevasPlantas count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
    DetailPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    Plant *plant = [self.nuevasPlantas objectAtIndex:indexPath.row];
    //cell.textLabel.text = plant.name;
    
    cell.plantName.text = plant.name;
    NSString *urlString = [[NSString alloc] initWithString:[[self.nuevasPlantas objectAtIndex:indexPath.row] urlImage]];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error==nil) {
                cell.photoImage.image = [UIImage imageWithData:data];
            }
            [cell.spinner stopAnimating];
        });
        
    }];
    
    [task resume];
    [cell.spinner startAnimating];
    return cell;
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"DetailSegue"]){
        
        PlantViewController *pv = [segue destinationViewController];
        NSIndexPath *path = [self.PlantListTableView indexPathForSelectedRow];
        Plant *plant = [self.nuevasPlantas objectAtIndex:path.row];
        pv.plantSelected = plant;
    }

}


@end
