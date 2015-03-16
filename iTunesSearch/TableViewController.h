//
//  ViewController.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableview;
// Orleans: Implementado a pesquisa pelo usuario
@property (weak, nonatomic) IBOutlet UISearchBar *pesquisaTermo;
@property (strong, nonatomic) IBOutlet UIView *header;
@property  NSUserDefaults *userDefaults;

@end

