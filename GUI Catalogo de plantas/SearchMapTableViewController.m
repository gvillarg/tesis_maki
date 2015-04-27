//
//  SearchMapTableViewController.m
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 4/26/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "SearchMapTableViewController.h"
#import "AFNetworking.h"
#import "Plant.h"

@interface SearchMapTableViewController ()
@property NSMutableDictionary *plantasDiccionario;
@property NSArray *plantSectionTitles;

@property NSMutableArray *plants;
@property NSMutableArray *nuevasPlantas;

@property NSMutableArray *filteredPlants;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@end

@implementation SearchMapTableViewController

@synthesize filteredPlants, searchController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.plantasDiccionario = [[NSMutableDictionary alloc] init];
    self.plantSectionTitles = [[NSArray alloc] init];
    filteredPlants = [[NSMutableArray alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    searchController = [[UISearchDisplayController alloc] init];
    searchController.searchResultsDataSource = self;
    [self getPlants];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPlants{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:@"http://inform.pucp.edu.pe/~a20090212/ServicioPlanta.php" parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSMutableDictionary * respuesta = [[NSMutableDictionary alloc] init];
        respuesta = responseObject;
        self.plants  = [respuesta objectForKey:@"result"];
        
        [self getPlantNames];
        NSLog(@"JSON: %@", responseObject);
        [self.tableView reloadData];
        
        
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
    
    NSString * plantaAux = ((Plant *)[self.nuevasPlantas objectAtIndex: 0]).name; // Se obtiene el nombre de la primera planta
    NSString * primLetraAnt = [plantaAux substringToIndex:1]; // Se obtiene la primera letra del nombre
    
    NSMutableArray * arrLetraPlantas = [[NSMutableArray alloc] init]; //Este es el arreglo que tiene los objetos familia con una letra
    [arrLetraPlantas addObject:[self.nuevasPlantas objectAtIndex:0]];
    //NSMutableDictionary * PlantasDic = [[NSMutableDictionary alloc] init]; //Este es el diccionario que tiene las letras y el arreglo de nombres
    [self.plantasDiccionario setObject:arrLetraPlantas forKey: primLetraAnt];
    
    for(int i=1; i< [self.nuevasPlantas count]; i++){
        NSString * planta = ((Plant *)[self.nuevasPlantas objectAtIndex: i]).name;
        NSString * primLetra = [planta substringToIndex:1];
        
        if([primLetraAnt isEqualToString:primLetra]){//Si es igual a la letra anterior solo se agrega al arreglo
            [arrLetraPlantas addObject: [self.nuevasPlantas objectAtIndex:i]];
            
        }else{ // Si son diferentes se agrega el arreglo al diccionario ya que ya se acabo una letra, luego se reinicia el arreglo y se agrega la palabra
            [self.plantasDiccionario setObject:arrLetraPlantas forKey:primLetraAnt]; //agrego el anterior arreglo
            arrLetraPlantas = [[NSMutableArray alloc] init];
            [arrLetraPlantas addObject: [self.nuevasPlantas objectAtIndex:i]];
            primLetraAnt = primLetra; // Se actualiza el primLetra
            
        }
        
        if (i == [self.nuevasPlantas count]-1){ //Si es que es el ùltimo del arreglo se agrega al dicionario de todas maneras
            [self.plantasDiccionario setObject:arrLetraPlantas forKey:primLetraAnt];
        }
    }
    
    self.plantSectionTitles = [[self.plantasDiccionario allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if (tableView.tag == 1){
    return [self.plantSectionTitles count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (tableView.tag == 1){
    NSString *sectionTitle = [self.plantSectionTitles objectAtIndex:section];
    NSArray *sectionPlant = [self.plantasDiccionario objectForKey:sectionTitle];
    return [sectionPlant count];
    } else {
        return [filteredPlants count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    
    NSString *sectionTitle = [self.plantSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionPlants = [self.plantasDiccionario objectForKey:sectionTitle];
    Plant *plantToShow = [[Plant alloc] init];
    if (tableView.tag == 1){
        plantToShow = [sectionPlants objectAtIndex:indexPath.row];
    } else {
        plantToShow = [filteredPlants objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = plantToShow.name;
    
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1){
        return [self.plantSectionTitles objectAtIndex:section];
    } else {
        return nil;
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.tag==1){
    return self.plantSectionTitles;
    } else {
        return nil;
    }
//    if (tableView.tag == 1){
//        NSArray *alphabet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L" , @"M", @"N", @"O", @"P", @"Q", @"R",  @"S", @"T", @"U" , @"V", @"W", @"X" , @"Y", @"Z",  nil] ;
//        return alphabet;
//    } else{
//        return nil;
//    }
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return [self.plantSectionTitles indexOfObject:title];
}


#pragma mark Search DIsplay Delegate Methods

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NewCell"];
    //tableView = self.GenderTableView;
}

-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [filteredPlants removeAllObjects];
    
    if (searchString.length > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c]  %@", self.searchBar.text];
        filteredPlants = [NSMutableArray arrayWithArray:[self.nuevasPlantas filteredArrayUsingPredicate:predicate]];
    }
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"GenderDetail"]){
        SpeciesViewController *SpeciesViewController = [segue destinationViewController];
        SpeciesViewController.familySelected = self.familySelected;
        
        
        //Gender *genderToSend = [[Gender alloc]init];
        if (sender == self.searchDisplayController.searchResultsTableView){
            NSIndexPath *path = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            Gender *genderToSend = [filteredFamilies objectAtIndex:path.row];
            SpeciesViewController.genderSelected = genderToSend;
        } else {
            NSIndexPath *path = [self.GenderTableView indexPathForSelectedRow];
            NSString *sectionTitle = [self.genderSectionTitles objectAtIndex:path.section];
            NSArray *sectionGenders = [self.plantasDiccionario objectForKey:sectionTitle];
            Gender *genderToSend = [sectionGenders objectAtIndex:path.row];
            SpeciesViewController.genderSelected = genderToSend;
        }
        
        //NSIndexPath *path = [self.GenderTableView indexPathForSelectedRow];
    }

}

*/
@end
