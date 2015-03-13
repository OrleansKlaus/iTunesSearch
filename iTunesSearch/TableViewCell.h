//
//  TableViewCell.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
// Adicionado pelo Orleans
@property (weak, nonatomic) IBOutlet UILabel *autor;
@property (weak, nonatomic) IBOutlet UILabel *genero;
@property (weak, nonatomic) IBOutlet UILabel *duracao;
@property (weak, nonatomic) IBOutlet UILabel *pais;
@property (weak, nonatomic) IBOutlet UILabel *lancamento;

@end
