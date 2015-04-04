//
//  FamiliesViewController.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 30-03-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "FamiliesViewController.h"
#import "Family.h"

@interface FamiliesViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barHeight;
@property NSMutableArray *families;

@end

@implementation FamiliesViewController


# pragma mark - View Controller Life Cicle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.families = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

// metodo para crear data inicial, luego cuando cargue de la BD puedo borrar esto
-(void) loadInitialData {
    Family *family1 = [[Family alloc] init];
    family1.name = @"Acanthaceae";
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

- (void)viewWillAppear:(BOOL)animated {
    [self.barHeight setConstant:88];
}

# pragma mark  - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.families count];
    //return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    Family *family = [self.families objectAtIndex:indexPath.row];
    cell.textLabel.text = family.name;
    return cell;
    
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *alphabet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L" , @"M", @"N", @"O", @"P", @"Q", @"R",  @"S", @"T", @"U" , @"V", @"W", @"X" , @"Y", @"Z",  nil] ;
    return alphabet;
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