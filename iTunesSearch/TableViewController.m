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
    NSMutableArray *midias;
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
    
    [iTunesManager sharedInstance];
 
    //Utilizar o SearchBar  para pesquisar o termo digitado pelo usuario
    [self.pesquisaTermo setDelegate:self];
    [pesquisaTermo resignFirstResponder];
    pesquisaTermo.translucent = YES;
    self.pesquisaTermo.placeholder = NSLocalizedString(@"Buscar",nil);

#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    
    header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 100)];
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
    
    Filme *todasMidias = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:todasMidias.nome];
    [celula.tipo setText:todasMidias.midia];
    [celula.autor setText:todasMidias.artista];
    [celula.genero setText:todasMidias.genero];
    [celula.duracao setText:[NSString stringWithFormat:@"%d min",[todasMidias.duracao intValue]/6000]];
    [celula.pais setText:todasMidias.pais];
    [celula.lancamento setText:todasMidias.lancamento];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    midias = [[NSMutableArray alloc] init];
    iTunesManager *itunes = [iTunesManager sharedInstance];
//    searchBar = pesquisaTermo;
//    NSString *termo = [[NSString alloc] init];
//    termo = searchBar.text;
//    midias = [itunes buscarMidias:termo];
    
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia:@"movie"]];
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia:@"ebook"]];
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia: @"podcast" ]];
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia:@"music"]];
    
    [searchBar endEditing:YES];
    [self.pesquisaTermo resignFirstResponder];
    [self.tableview reloadData];
}

@end
