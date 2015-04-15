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
@property NSMutableArray *nuevosGeneros;
@end

@implementation GendersViewController

- (void)viewDidLoad {
      [super viewDidLoad];
    [self getGenders];
    // Do any additional setup after loading the view.
   
    //RECIEN COMENTADO
    //self.familyNameLabel.text = [NSString stringWithFormat: @"%@ %@", @" Familia ", [self.familySelected objectForKey:@"Nombre"]];
    
    self.familyNameLabel.text = [NSString stringWithFormat: @"%@ %@", @" Familia ", [self.familySelected name]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getGenders{
  // RECIEN COMENTADO
  //  NSMutableDictionary *diccionarioAMandar = [[NSMutableDictionary alloc]initWithObjectsAndKeys: [self.familySelected objectForKey:@"Id"],@"id",nil];
    NSNumber *numberObject = [NSNumber numberWithInteger:[self.familySelected id]];
    NSMutableDictionary *diccionarioAMandar = [[NSMutableDictionary alloc]initWithObjectsAndKeys:numberObject,@"id",nil];
    
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
    return [self.familySelected cantgen];
    
    //RECIEN COMENTADO
    //return ((NSNumber *)[self.familySelected objectForKey:@"cantGen"]).intValue;
    
    //return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    //Gender *gender = [self.familySelected.genders objectAtIndex:indexPath.row];
    //cell.textLabel.text = gender.name;
    //Family *family = [self.families objectAtIndex:indexPath.row];
    cell.textLabel.text = [[self.genders objectAtIndex:indexPath.row] objectForKey:@"Nombre"] ;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@" , [[self.genders objectAtIndex:indexPath.row] objectForKey:@"COUNT"], @"especies"];
    return cell;
    
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *alphabet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L" , @"M", @"N", @"O", @"P", @"Q", @"R",  @"S", @"T", @"U" , @"V", @"W", @"X" , @"Y", @"Z",  nil] ;
    return alphabet;
}

/*-(void)getGenderNames{
    self.nuevosGeneros = [[NSMutableArray alloc]init];
    Gender *newGender;
    for (NSMutableDictionary *ObjetoDiccionario in self.genders){
        //nameFam = [ObjetoDiccionario objectForKey:@"Nombre"];
        newFamily = [Family initWithJson:ObjetoDiccionario];
        [self.nuevasFamilias addObject:newFamily];
    }
    
    NSString * plantaAux = ((Family *)[self.nuevasFamilias objectAtIndex: 0]).name; // Se obtiene el nombre de la primera planta
    NSString * primLetraAnt = [plantaAux substringToIndex:1]; // Se obtiene la primera letra del nombre
    
    NSMutableArray * arrLetraFamilias = [[NSMutableArray alloc] init]; //Este es el arreglo que tiene los objetos familia con una letra
    [arrLetraFamilias addObject:[self.nuevasFamilias objectAtIndex:0]];
    //NSMutableDictionary * PlantasDic = [[NSMutableDictionary alloc] init]; //Este es el diccionario que tiene las letras y el arreglo de nombres
    [self.plantasDiccionario setObject:arrLetraFamilias forKey: primLetraAnt];
    
    for(int i=1; i< [self.nuevasFamilias count]; i++){
        NSString * planta = ((Family *)[self.nuevasFamilias objectAtIndex: i]).name;
        NSString * primLetra = [planta substringToIndex:1];
        
        if([primLetraAnt isEqualToString:primLetra]){//Si es igual a la letra anterior solo se agrega al arreglo
            [arrLetraFamilias addObject: [self.nuevasFamilias objectAtIndex:i]];
            
        }else{ // Si son diferentes se agrega el arreglo al diccionario ya que ya se acabo una letra, luego se reinicia el arreglo y se agrega la palabra
            [self.plantasDiccionario setObject:arrLetraFamilias forKey:primLetraAnt]; //agrego el anterior arreglo
            arrLetraFamilias = [[NSMutableArray alloc] init];
            [arrLetraFamilias addObject: [self.nuevasFamilias objectAtIndex:i]];
            primLetraAnt = primLetra; // Se actualiza el primLetra
            
        }
        
        if (i == [self.nuevasFamilias count]-1){ //Si es que es el ùltimo del arreglo se agrega al dicionario de todas maneras
            [self.plantasDiccionario setObject:arrLetraFamilias forKey:primLetraAnt];
        }
    }
    
    self.familySectionTitles = [[self.plantasDiccionario allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.GenderTableView indexPathForSelectedRow];
    SpeciesViewController *SpeciesViewController = [segue destinationViewController];
    SpeciesViewController.familySelected = self.familySelected;
    //SpeciesViewController.genderSelected = [self.familySelected.genders objectAtIndex:path.row];
}


@end
