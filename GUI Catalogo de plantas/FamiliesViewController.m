//
//  FamiliesViewController.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 30-03-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "FamiliesViewController.h"
#import "Family.h"
#import "GendersViewController.h"
#import "PlantViewController.h"
#import "Gender.h"
#import "AFNetworking.h"
#import "Plant.h"
@interface FamiliesViewController ()

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *barHeight;
@property NSMutableArray *families;

@property NSMutableArray *nuevasFamilias;
@property NSMutableDictionary *plantasDiccionario; //Este es el diccionario que tiene las letras y el arreglo de nombres
@property NSArray *familySectionTitles;

@property NSMutableArray *plants;
@property NSMutableArray *nuevasPlantas;

@property NSMutableArray *filteredFamilies;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@property NSInteger esPlanta;
@end



@implementation FamiliesViewController

@synthesize filteredFamilies, searchController;


# pragma mark - View Controller Life Cicle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background4"]];
    bgImageView.frame = self.FamilyTableView.frame;
    [self.FamilyTableView setBackgroundView:bgImageView];
    // Do any additional setup after loading the view.
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
   
    self.plantasDiccionario = [[NSMutableDictionary alloc] init];
    self.familySectionTitles = [[NSArray alloc] init];
    
    filteredFamilies = [[NSMutableArray alloc]init];
    searchController = [[UISearchDisplayController alloc] init];
    searchController.searchResultsDataSource = self;
    
    self.esPlanta = 0;
    
    
    [self getFamily];
    
    //[self loadInitialData];
}

// metodo para crear data inicial, luego cuando cargue de la BD puedo borrar esto
-(void) loadInitialData {
    NSMutableArray *genders = [[NSMutableArray alloc] init];
    
    Gender *gender1 = [[Gender alloc] init];
    gender1.name = @"Anisacanthus quadrifidus";
    [genders addObject:gender1];
    Gender *gender2 = [[Gender alloc] init];
    gender2.name = @"Aphelandra deppeana";
    [genders addObject:gender2];
    Gender *gender3 = [[Gender alloc] init];
    gender3.name = @"Aphelandra scabra";
    [genders addObject:gender3];
    Gender *gender4 = [[Gender alloc] init];
    gender4.name = @"Carlowrightia parvifolia";
    [genders addObject:gender4];
    
    
    Family *family1 = [[Family alloc] init];
    family1.name = @"Acanthaceae";
    //family1.genders = genders;
    family1.genders = [[NSMutableArray alloc] initWithArray:genders];
    [self.families addObject: family1];
    Family *family2 = [[Family alloc] init];
    family2.name = @"Achariaceae";
    [self.families addObject:family2];
    Family *family3 = [[Family alloc] init];
    family3.name = @"Achatocarpaceae";
    [self.families addObject:family3];
    Family *family4 = [[Family alloc] init];
    family4.name = @"Acoraceae";
    [self.families addObject:family4];
    Family *family5 = [[Family alloc]init];
    family5.name = @"Balanopaceae";
    [self.families addObject:family5];
    Family *family6 = [[Family alloc]init];
    family6.name = @"Daltoniaceae";
    [self.families addObject:family6];
    Family *family7 = [[Family alloc]init];
    family7.name = @"Daphniphyllaceae";
    [self.families addObject:family7];
    Family *family8 = [[Family alloc]init];
    family8.name = @"Dasypogonaceae";
    [self.families addObject:family8];
    Family *family9 = [[Family alloc]init];
    family9.name = @"Ochnaceae";
    [self.families addObject:family9];
    Family *family10 = [[Family alloc]init];
    family10.name = @"Octoblepharaceae";
    [self.families addObject:family10];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)viewWillAppear:(BOOL)animated {
    [self.barHeight setConstant:88];
}*/

# pragma mark  - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (tableView.tag == 1){
    return [self.familySectionTitles count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.families count];
    //return  0;
    if (tableView.tag == 1) {
    NSString *sectionTitle = [self.familySectionTitles objectAtIndex:section];
    NSArray *sectionFamily = [self.plantasDiccionario objectForKey:sectionTitle];
    return [sectionFamily count];
    } else {
        return [filteredFamilies count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    //Family *family = [self.families objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = [[self.families objectAtIndex:indexPath.row] objectForKey:@"Nombre"] ;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@" , [[self.families objectAtIndex:indexPath.row] objectForKey:@"cantGen"], @"generos"];
    NSString *sectionTitle = [self.familySectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionFamilies = [self.plantasDiccionario objectForKey:sectionTitle];
    
    Family *familyToShow = [[Family alloc]init];
    Plant *plantToShow = [[Plant alloc]init];
    if (tableView.tag == 1){
        familyToShow = [sectionFamilies objectAtIndex:indexPath.row];
    } else {
        if (self.esPlanta == 0){
        familyToShow = [filteredFamilies objectAtIndex:indexPath.row];
        } else {
            plantToShow = [filteredFamilies objectAtIndex:indexPath.row];
        }
    }
    if (self.esPlanta == 0) {
    cell.textLabel.text = familyToShow.name;
    
    if (familyToShow.cantgen == 1){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld %@", (long)familyToShow.cantgen, @"genero"];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld %@", (long)familyToShow.cantgen, @"generos"];
    }
    } else {
        cell.textLabel.text = plantToShow.name;
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    //Family *family = [self.families objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = [[self.families objectAtIndex:indexPath.row] objectForKey:@"Nombre"] ;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@" , [[self.families objectAtIndex:indexPath.row] objectForKey:@"cantGen"], @"generos"];
    NSString *sectionTitle = [self.familySectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionFamilies = [self.plantasDiccionario objectForKey:sectionTitle];
    
    Family *familyToShow = [[Family alloc]init];
    Plant *plantToShow = [[Plant alloc]init];
    if (tableView.tag == 1){
        familyToShow = [sectionFamilies objectAtIndex:indexPath.row];
    } else {
        if (self.esPlanta == 0){
            familyToShow = [filteredFamilies objectAtIndex:indexPath.row];
        } else {
            plantToShow = [filteredFamilies objectAtIndex:indexPath.row];
        }
    }
    
    cell.textLabel.text = familyToShow.name;
    
    if (familyToShow.cantgen == 1){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld %@", (long)familyToShow.cantgen, @"genero"];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld %@", (long)familyToShow.cantgen, @"generos"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
}*/


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1){
    return [self.familySectionTitles objectAtIndex:section];
    } else {
        return nil;
    }
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.tag == 1){
    NSArray *alphabet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L" , @"M", @"N", @"O", @"P", @"Q", @"R",  @"S", @"T", @"U" , @"V", @"W", @"X" , @"Y", @"Z",  nil] ;
    return alphabet;
    } else{
        return nil;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return [self.familySectionTitles indexOfObject:title];
}

#pragma mark Search DIsplay Delegate Methods

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NewCell"];
    //tableView = self.GenderTableView;
}


/*-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [filteredFamilies removeAllObjects];
    
    if (searchString.length > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c]  %@", self.searchBar.text];
        filteredFamilies = [NSMutableArray arrayWithArray:[self.nuevasFamilias filteredArrayUsingPredicate:predicate]];
    }
    return YES;
}*/


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [filteredFamilies removeAllObjects];
    // Filter the array using NSPredicate
    if (searchText.length > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c]  %@", self.searchBar.text];
        filteredFamilies = [NSMutableArray arrayWithArray:[self.nuevasFamilias filteredArrayUsingPredicate:predicate]];
    }
    self.esPlanta = 0;
    if (![scope isEqualToString:@"Familias"]) {
        // Further filter the array with the scope
        [filteredFamilies removeAllObjects];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c]  %@", self.searchBar.text];
        filteredFamilies = [NSMutableArray arrayWithArray:[self.nuevasPlantas filteredArrayUsingPredicate:predicate]];
        self.esPlanta = 1;
    }
    
}


-(void)getFamily{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:@"http://inform.pucp.edu.pe/~a20090212/servicioFamilia.php" parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSMutableDictionary * respuesta = [[NSMutableDictionary alloc] init];
        respuesta = responseObject;
        self.families  = [respuesta objectForKey:@"result"];
        
        [self getFamilyNames];
        NSLog(@"JSON: %@", responseObject);
        [self getPlant];
        [self.FamilyTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No se pudo acceder al servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

-(void)getFamilyNames{
    self.nuevasFamilias = [[NSMutableArray alloc]init];
    Family *newFamily;
    for (NSMutableDictionary *ObjetoDiccionario in self.families){
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

-(void)getPlant{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:@"http://inform.pucp.edu.pe/~a20090212/ServicioPlanta.php" parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSMutableDictionary * respuesta = [[NSMutableDictionary alloc] init];
        respuesta = responseObject;
        self.plants  = [respuesta objectForKey:@"result"];
        
        [self getPlantNames];
        NSLog(@"JSON: %@", responseObject);
        [self.FamilyTableView reloadData];
        
        
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


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark - Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*if (tableView.tag !=1){
        [self performSegueWithIdentifier:@"FamilySegue" sender:self.searchDisplayController.searchResultsTableView];
    }*/
    if (self.esPlanta == 0){
    [self performSegueWithIdentifier:@"FamilySegue" sender:tableView];
    } else {
        [self performSegueWithIdentifier:@"PlantSegue" sender:tableView];
    }
    //self.esPlanta = 0;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (self.esPlanta == 0) {
    GendersViewController *GenderViewController = [segue destinationViewController];
    if (sender == self.searchDisplayController.searchResultsTableView){
        NSIndexPath *path = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        Family *familyToSend = [filteredFamilies objectAtIndex:path.row];
        GenderViewController.familySelected = familyToSend;
    } else {
        NSIndexPath *path = [self.FamilyTableView indexPathForSelectedRow];
        NSString *sectionTitle = [self.familySectionTitles objectAtIndex:path.section];
        NSArray *sectionFamilies = [self.plantasDiccionario objectForKey:sectionTitle];
        Family *familyToSend = [sectionFamilies objectAtIndex:path.row];
        GenderViewController.familySelected = familyToSend;
    }
    } else {
        PlantViewController *PlantViewController = [segue destinationViewController];
        NSIndexPath *path = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        Plant * plantToSend = [filteredFamilies objectAtIndex:path.row];
        PlantViewController.plantSelected = plantToSend;
    }
    
    //GenderViewController.idFamilySelected = [self.families objectAtIndex:path.row];
  
    // RECIEN COMENTADO
    //GenderViewController.familySelected = [self.families objectAtIndex:path.row];
    
    
   
    
   
    
}


@end
