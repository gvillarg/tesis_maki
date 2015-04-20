//
//  SpeciesViewController.m
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 4/5/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "SpeciesViewController.h"
#import "AFNetworking.h"
#import "Specie.h"
#import "Cell.h"
#import "HeaderClass.h"
#import "PlantViewController.h"
#import "Plant.h"

@interface SpeciesViewController ()

@property NSMutableArray *species;
@property NSMutableArray *nuevasEspecies;
@property NSMutableArray *nuevasPlantas;

@end

@implementation SpeciesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background2"]];
    
    [self getSpecies];
    self.familyNameLabel.text = [NSString stringWithFormat: @"%@ %@", @" Familia ", self.familySelected.name];
    self.genderNameLabel.text = [NSString stringWithFormat: @"%@ %@", @" Genero ", self.genderSelected.name];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSpecies{
    // RECIEN COMENTADO
    //  NSMutableDictionary *diccionarioAMandar = [[NSMutableDictionary alloc]initWithObjectsAndKeys: [self.familySelected objectForKey:@"Id"],@"id",nil];
    NSNumber *numberObject = [NSNumber numberWithInteger:[self.genderSelected id]];
    NSMutableDictionary *diccionarioAMandar = [[NSMutableDictionary alloc]initWithObjectsAndKeys:numberObject,@"id",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:@"http://inform.pucp.edu.pe/~a20090212/servicioEspecie.php" parameters:diccionarioAMandar success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSMutableDictionary * respuesta = [[NSMutableDictionary alloc] init];
        respuesta = responseObject;
        self.species  = [respuesta objectForKey:@"result"];
        
        [self getSpeciesObjects];
        NSLog(@"JSON: %@", responseObject);
        [self.SpeciesCollectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No se pudo acceder al servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

-(void)getSpeciesObjects{
    self.nuevasEspecies = [[NSMutableArray alloc]init];
    self.nuevasPlantas = [[NSMutableArray alloc] init];
    Specie *newSpecie;
    Plant *newPlant;
    for (NSMutableDictionary *ObjetoDiccionario in self.species){
        //nameFam = [ObjetoDiccionario objectForKey:@"Nombre"];
        newSpecie = [Specie initWithJson:ObjetoDiccionario];
        newPlant = [Plant initWithJson:ObjetoDiccionario];
        [self.nuevasEspecies addObject:newSpecie];
        [self.nuevasPlantas addObject:newPlant];
    }
  
}



#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    //NSString *searchTerm = self.searches[section];
    //return [self.searchResults[searchTerm] count];
    return [self.nuevasEspecies count];
    //return 1;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    
    //return [self.nuevasEspecies count];
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"SpecieCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor whiteColor];
    cell.nombrePlantaLabel.text = [[self.nuevasEspecies objectAtIndex:indexPath.row] name];
    
    NSString *urlString = [[NSString alloc] initWithString:[[self.nuevasPlantas objectAtIndex:indexPath.row] urlImage]];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error==nil) {
            cell.PlantaImagen.image = [UIImage imageWithData:data];
        }
        [cell.spinner stopAnimating];
        
    }];
    
    [task resume];
    [cell.spinner startAnimating];
    
    return cell;
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
     HeaderClass *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader" forIndexPath:indexPath];
     header.titleLabel.text = [NSString stringWithFormat:@"Especie"];
     return header;
     
 }*/

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout


/*- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
    //self.searchResults[searchTerm][indexPath.row];
    UIImage *PlantPicture = [UIImage imageNamed:@"PlantaModelo"];
    
    CGSize retval = PlantPicture.size.width > 0 ? PlantPicture.size: CGSizeMake(10, 10);
    retval.height += 10; retval.width += 10; return retval;
    //CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
    //retval.height += 35; retval.width += 35; return retval;
}*/


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(25, 10, 25, 10);
    //return UIEdgeInsetsMake(50, 20, 50, 20);
}



 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"DetailSegue"]){
        Cell *cell = (Cell *)sender;
        NSIndexPath *indexPath = [self.SpeciesCollectionView indexPathForCell:cell];
        
        PlantViewController *pv = [segue destinationViewController];
        
        Plant *plant = [self.nuevasPlantas objectAtIndex:indexPath.row];
        
        pv.plantSelected = plant;
    }
}


@end
