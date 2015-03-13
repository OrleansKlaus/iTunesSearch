//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController
{
    iTunesManager *itunes;
}

@synthesize header, pesquisaTermo;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    itunes = [iTunesManager sharedInstance];

#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    
    header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 80)];
    pesquisaTermo.translucent = YES;
    [pesquisaTermo resignFirstResponder];
    
    self.pesquisaTermo.placeholder = NSLocalizedString(@"Buscar",nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
    [celula.autor setText:filme.artista];
    [celula.genero setText:filme.genero];
    [celula.duracao setText:[NSString stringWithFormat:@"%d min",[filme.duracao intValue]/6000]];
    [celula.pais setText:filme.pais];
    [celula.lancamento setText:filme.lancamento];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar = pesquisaTermo;
    NSString *termo = [[NSString alloc] init];
    termo = searchBar.text;
    midias = [itunes buscarMidias:termo];
    [searchBar endEditing:YES];
    [self.tableview reloadData];
}

@end
