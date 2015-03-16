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
#import "Entidades/Music.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"

@interface TableViewController () {
    NSMutableArray *midias;
//    NSMutableArray *filmes;
//    NSMutableArray *musicas;
//    NSMutableArray *podcasts;
//    NSMutableArray *ebooks;
}

@end

@implementation TableViewController
{
    iTunesManager *itunes;
}

@synthesize header, pesquisaTermo, userDefaults;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
// Orleans: Implementado armazenamento na memória do celular
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    if ([self.userDefaults objectForKey:@"termoPesquisado"] == nil) {
        [self.userDefaults setObject:@0 forKey:@"termoPesquisado"];
    }
    self.pesquisaTermo.text = [NSString stringWithFormat:@"%@", [self.userDefaults objectForKey:@"termoPesquisado"]];
    
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
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger i = 0;
    
    if (section == 0){
        i = [[midias objectAtIndex:0] count];
    }
    if (section == 1){
        i = [[midias objectAtIndex:1] count];
    }
    if (section == 2){
        i = [[midias objectAtIndex:2] count];
    }
    if (section == 3){
        i = [[midias objectAtIndex:3] count];
    }
    return i;
}

- (NSString *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    UIView *headerView = [[UIView alloc] init];
    [headerView setFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, tableView.frame.size.width, 18)];
    [headerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [headerView setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    UIImage *imagem;

    switch (section)
    {
        case 0:
             sectionName = @"Podcasts";
             [headerLabel setText:sectionName];
             imagem = [UIImage imageNamed:sectionName];
             break;
        case 1:
             sectionName = @"Filmes";
             [headerLabel setText:sectionName];
             imagem = [UIImage imageNamed:sectionName];
             break;
        case 2:
             sectionName = @"Musicas";
             [headerLabel setText:sectionName];
             imagem = [UIImage imageNamed:sectionName];
             break;
        case 3:
             sectionName = @"Ebooks";
             [headerLabel setText:sectionName];
             imagem = [UIImage imageNamed:sectionName];
             break;
        default:
             sectionName = @"";
             break;
    }
    
    UIImageView *headerImage = [[UIImageView alloc] initWithImage:imagem];
    headerImage.frame = CGRectMake(0, 2, 20, 20);
    [headerView addSubview:headerImage];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    if (indexPath.section == 0){

        Podcast *podcast = [[midias objectAtIndex:0] objectAtIndex:indexPath.row];
        [celula.nome setText:podcast.nome];
        [celula.tipo setText:NSLocalizedString(podcast.tipo,nil)];
        [celula.artista setText:podcast.artista];
        [celula.pais setText:podcast.pais];
        [celula.genero setText:podcast.genero];
        [celula.duracao setText:[NSString stringWithFormat:@"%d min",[podcast.duracao intValue]/6000]];
        [celula.pais setText:podcast.pais];
        [celula.lancamento setText:podcast.lancamento];
    }

    if (indexPath.section == 1){

        Filme *filme = [[midias objectAtIndex:1] objectAtIndex:indexPath.row];
        [celula.nome setText:filme.nome];
        [celula.tipo setText:NSLocalizedString(filme.tipo,nil)];
        [celula.artista setText:filme.artista];
        [celula.pais setText:filme.pais];
        [celula.genero setText:filme.genero];
        [celula.duracao setText:[NSString stringWithFormat:@"%d min",[filme.duracao intValue]/6000]];
        [celula.pais setText:filme.pais];
        [celula.lancamento setText:filme.lancamento];
        
//        Filme *todasMidias = [midias objectAtIndex:indexPath.row];
//        
//        [celula.nome setText:todasMidias.nome];
//        [celula.tipo setText:todasMidias.tipo];
//        [celula.autor setText:todasMidias.artista];
//        [celula.genero setText:todasMidias.genero];
//        [celula.duracao setText:[NSString stringWithFormat:@"%d min",[todasMidias.duracao intValue]/6000]];
//        [celula.pais setText:todasMidias.pais];
//        [celula.lancamento setText:todasMidias.lancamento];
    }

    if (indexPath.section == 2){

        Musica *music = [[midias objectAtIndex:2] objectAtIndex:indexPath.row];
        [celula.nome setText:music.nome];
        [celula.tipo setText:NSLocalizedString(music.tipo,nil)];
        [celula.artista setText:music.artista];
        [celula.pais setText:music.pais];
        [celula.genero setText:music.genero];
        [celula.duracao setText:[NSString stringWithFormat:@"%d min",[music.duracao intValue]/6000]];
        [celula.pais setText:music.pais];
        [celula.lancamento setText:music.lancamento];
    }
    
    if (indexPath.section == 3){
        
        Ebook *ebook = [[midias objectAtIndex:3] objectAtIndex:indexPath.row];
        [celula.nome setText:ebook.nome];
        [celula.tipo setText:NSLocalizedString(ebook.tipo,nil)];
        [celula.artista setText:ebook.artista];
        [celula.pais setText:ebook.pais];
        [celula.genero setText:ebook.genero];
        [celula.duracao setText:[NSString stringWithFormat:@"%d min",[ebook.duracao intValue]/6000]];
        [celula.pais setText:ebook.pais];
        [celula.lancamento setText:ebook.lancamento];
    }
    
    return celula;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    midias = [[NSMutableArray alloc] init];
    iTunesManager *itunes = [iTunesManager sharedInstance];
    
    // Atualiza termo Pesquisado armazenado na memória do celular
    if ([self.pesquisaTermo.text isEqualToString: [self.userDefaults objectForKey:@"termoPesquisado"]]) {
        [self.userDefaults setObject:self.pesquisaTermo.text forKey:@"termoPesquisado"];
        self.pesquisaTermo.text = [NSString stringWithFormat:@"%@",  [self.userDefaults objectForKey:@"termoPesquisado"]];
    }
    
//    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia: @"all" ]];
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia: @"podcast" ]];
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia:@"movie"]];
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia:@"music"]];
    [midias addObjectsFromArray:[itunes buscarMidias:(pesquisaTermo.text) andMedia:@"ebook"]];
    
    [searchBar endEditing:YES];
    [self.pesquisaTermo resignFirstResponder];
    [self.tableview reloadData];
    
}

@end
