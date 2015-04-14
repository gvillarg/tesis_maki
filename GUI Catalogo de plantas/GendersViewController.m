//
//  GendersViewController.m
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 3/31/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "GendersViewController.h"
#import "Family.h"
#import "SpeciesViewController.h"
#import "AFNetworking.h"

@interface GendersViewController ()

@property NSMutableArray *genders;
@end

@implementation GendersViewController

- (void)viewDidLoad {
      [super viewDidLoad];
    [self getGenders];
    // Do any additional setup after loading the view.
    self.familyNameLabel.text = [NSString stringWithFormat: @"%@ %@", @" Familia ", [self.familySelected objectForKey:@"Nombre"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getGenders{
    NSMutableDictionary *diccionarioAMandar = [[NSMutableDictionary alloc]initWithObjectsAndKeys: [self.familySelected objectForKey:@"Id"],@"id",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:@"http://inform.pucp.edu.pe/~a20090212/servicioGenero.php" parameters:diccionarioAMandar success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSMutableDictionary * respuesta = [[NSMutableDictionary alloc] init];
        respuesta = responseObject;
        self.genders  = [respuesta objectForKey:@"result"];
        
        NSLog(@"JSON: %@", responseObject);
        [self.GenderTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No se pudo acceder al servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}


# pragma mark  - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.familySelected.genders count];
    return ((NSNumber *)[self.familySelected objectForKey:@"cantGen"]).intValue;
    //return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    //Gender *gender = [self.familySelected.genders objectAtIndex:indexPath.row];
    //cell.textLabel.text = gender.name;
    //Family *family = [self.families objectAtIndex:indexPath.row];
    cell.textLabel.text = [[self.genders objectAtIndex:indexPath.row] objectForKey:@"Nombre"] ;
    return cell;
    
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *alphabet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L" , @"M", @"N", @"O", @"P", @"Q", @"R",  @"S", @"T", @"U" , @"V", @"W", @"X" , @"Y", @"Z",  nil] ;
    return alphabet;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.GenderTableView indexPathForSelectedRow];
    SpeciesViewController *SpeciesViewController = [segue destinationViewController];
    SpeciesViewController.familySelected = self.familySelected;
    //SpeciesViewController.genderSelected = [self.familySelected.genders objectAtIndex:path.row];
}


@end
