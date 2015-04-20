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
@property NSMutableDictionary *plantasDiccionario; //Este es el diccionario que tiene las letras y el arreglo de nombres
@property NSArray *genderSectionTitles;

@property NSMutableArray *filteredFamilies;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@end

@implementation GendersViewController

@synthesize filteredFamilies, searchController;

- (void)viewDidLoad {
      [super viewDidLoad];
    
    self.plantasDiccionario = [[NSMutableDictionary alloc] init];
    self.genderSectionTitles = [[NSArray alloc] init];
    
    //UITableView *tableVIew = (id) [self.view viewWithTag:1];
    //[tableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NewCell"];
    
   
    filteredFamilies = [[NSMutableArray alloc]init];
    searchController = [[UISearchDisplayController alloc] init];
    searchController.searchResultsDataSource = self;
    
    //searchController.searchResultsTableView.frame = CGRectMake(0, 400, self.view.frame.size.width,300);
    
    [self getGenders];
    // Do any additional setup after loading the view.
   
    //RECIEN COMENTADO
    //self.familyNameLabel.text = [NSString stringWithFormat: @"%@ %@", @" Familia ", [self.familySelected objectForKey:@"Nombre"]];
    
    self.familyNameLabel.text = [NSString stringWithFormat: @"Familia %@", [self.familySelected name]];
    self.searchBar.placeholder = [NSString stringWithFormat: @"Buscar en Familia %@", [self.familySelected name]];
    //
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
        
        [self getGenderNames];
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
    //return 1;
    if (tableView.tag == 1){
        return [self.genderSectionTitles count];
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return [self.familySelected cantgen];
    
    //RECIEN COMENTADO
    //return ((NSNumber *)[self.familySelected objectForKey:@"cantGen"]).intValue;
    
    //return  0;
    
    if (tableView.tag == 1){
    NSString *sectionTitle = [self.genderSectionTitles objectAtIndex:section];
    NSArray *sectionGender = [self.plantasDiccionario objectForKey:sectionTitle];
    return [sectionGender count];
    } else {
        return [filteredFamilies count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    //Gender *gender = [self.familySelected.genders objectAtIndex:indexPath.row];
    //cell.textLabel.text = gender.name;
    //Family *family = [self.families objectAtIndex:indexPath.row];
    /*cell.textLabel.text = [[self.genders objectAtIndex:indexPath.row] objectForKey:@"Nombre"] ;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@" , [[self.genders objectAtIndex:indexPath.row] objectForKey:@"COUNT"], @"especies"];
    return cell;*/
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:@"NewCell"];
    }
    NSString *sectionTitle = [self.genderSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionGenders = [self.plantasDiccionario objectForKey:sectionTitle];
    Gender *genderToShow = [[Gender alloc] init];
    if (tableView.tag == 1){
        genderToShow = [sectionGenders objectAtIndex:indexPath.row];
    } else {
        genderToShow = [filteredFamilies objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = genderToShow.name;
    if (genderToShow.cantEsp == 1) {
    
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld %@", (long)genderToShow.cantEsp, @"especie"];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld %@", (long)genderToShow.cantEsp, @"especies"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1){
    return [self.genderSectionTitles objectAtIndex:section];
    } else {
        return nil;
    }
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.tag == 1) {
    NSArray *alphabet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L" , @"M", @"N", @"O", @"P", @"Q", @"R",  @"S", @"T", @"U" , @"V", @"W", @"X" , @"Y", @"Z",  nil] ;
    return alphabet;
    } else {
        return nil;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView
    sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{

    return [self.genderSectionTitles indexOfObject:title];

}


#pragma mark Search DIsplay Delegate Methods

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NewCell"];
    //tableView = self.GenderTableView;
}

//-(void) searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{
//    CGRect f = self.GenderTableView.frame;
//    CGRect s = searchController.searchBar.frame;
//    CGRect newFrame = CGRectMake(f.origin.x,
//                                 s.size.height + s.origin.y,
//                                 f.size.width,
//                                 f.size.height - s.size.height - s.origin.y);
//    
//    tableView.frame = f;
//}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

    self.familyNameHeightConstraint.constant = 0;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.familyNameHeightConstraint.constant = 47;
}

-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [filteredFamilies removeAllObjects];
    
    if (searchString.length > 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c]  %@", self.searchBar.text];
        filteredFamilies = [NSMutableArray arrayWithArray:[self.nuevosGeneros filteredArrayUsingPredicate:predicate]];
    }
    return YES;
}



-(void)getGenderNames{
    self.nuevosGeneros = [[NSMutableArray alloc]init];
    Gender *newGender;
    for (NSMutableDictionary *ObjetoDiccionario in self.genders){
        //nameFam = [ObjetoDiccionario objectForKey:@"Nombre"];
        newGender = [Gender initWithJson:ObjetoDiccionario];
        [self.nuevosGeneros addObject:newGender];
    }
    
    NSString * plantaAux = ((Gender *)[self.nuevosGeneros objectAtIndex: 0]).name; // Se obtiene el nombre de la primera planta
    NSString * primLetraAnt = [plantaAux substringToIndex:1]; // Se obtiene la primera letra del nombre
    
    NSMutableArray * arrLetraGeneros = [[NSMutableArray alloc] init]; //Este es el arreglo que tiene los objetos familia con una letra
    [arrLetraGeneros addObject:[self.nuevosGeneros objectAtIndex:0]];
    //NSMutableDictionary * PlantasDic = [[NSMutableDictionary alloc] init]; //Este es el diccionario que tiene las letras y el arreglo de nombres
    [self.plantasDiccionario setObject:arrLetraGeneros forKey: primLetraAnt];
    
    for(int i=1; i< [self.nuevosGeneros count]; i++){
        NSString * planta = ((Gender *)[self.nuevosGeneros objectAtIndex: i]).name;
        NSString * primLetra = [planta substringToIndex:1];
        
        if([primLetraAnt isEqualToString:primLetra]){//Si es igual a la letra anterior solo se agrega al arreglo
            [arrLetraGeneros addObject: [self.nuevosGeneros objectAtIndex:i]];
            
        }else{ // Si son diferentes se agrega el arreglo al diccionario ya que ya se acabo una letra, luego se reinicia el arreglo y se agrega la palabra
            [self.plantasDiccionario setObject:arrLetraGeneros forKey:primLetraAnt]; //agrego el anterior arreglo
            arrLetraGeneros = [[NSMutableArray alloc] init];
            [arrLetraGeneros addObject: [self.nuevosGeneros objectAtIndex:i]];
            primLetraAnt = primLetra; // Se actualiza el primLetra
            
        }
        
        if (i == [self.nuevosGeneros count]-1){ //Si es que es el ùltimo del arreglo se agrega al dicionario de todas maneras
            [self.plantasDiccionario setObject:arrLetraGeneros forKey:primLetraAnt];
        }
    }
    
    self.genderSectionTitles = [[self.plantasDiccionario allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SpeciesViewController *SpeciesViewController = [segue destinationViewController];
    SpeciesViewController.familySelected = self.familySelected;
    
    NSIndexPath *path = [self.GenderTableView indexPathForSelectedRow];
    NSString *sectionTitle = [self.genderSectionTitles objectAtIndex:path.section];
    NSArray *sectionGenders = [self.plantasDiccionario objectForKey:sectionTitle];
    Gender *genderToSend = [[Gender alloc]init];
    
    if(sender == searchController.searchResultsTableView){
        genderToSend = [filteredFamilies objectAtIndex:path.row];
    } else {
        genderToSend = [sectionGenders objectAtIndex:path.row];
    }
    
    
    SpeciesViewController.genderSelected = genderToSend;

    
    //SpeciesViewController.genderSelected = [self.familySelected.genders objectAtIndex:path.row];
}


@end
