//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Music.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"
#import <UIKit/UIKit.h>

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo andMedia: (NSString *)media
{
    if (!termo) {
        termo = @"";
    }
    
    @try
    {
        NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=%@", termo, media];

        NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
        
        NSError *error;
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                    options:NSJSONReadingMutableContainers
                                    error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *filmes = [[NSMutableArray alloc] init];
        NSMutableArray *musicas = [[NSMutableArray alloc] init];
        NSMutableArray *podcasts = [[NSMutableArray alloc] init];
        NSMutableArray *ebooks = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados)
        {
            
            NSString *tipo = [item objectForKey:@"kind"];

            if ([tipo isEqualToString: @"feature-movie"])
            {
                Filme *filme = [[Filme alloc] init];
                [filme setNome:[item objectForKey:@"trackName"]];
                [filme setTrackId:[item objectForKey:@"trackId"]];
                [filme setArtista:[item objectForKey:@"artistName"]];
                [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [filme setGenero:[item objectForKey:@"primaryGenreName"]];
                [filme setPais:[item objectForKey:@"country"]];
                [filme setTipo:[item objectForKey:@"kind"]];
                [filmes addObject:filme];
            }
            
            if ([tipo isEqualToString: @"song"])
            {
                Musica *musica = [[Musica alloc] init];
                [musica setNome:[item objectForKey:@"trackName"]];
                [musica setTrackId:[item objectForKey:@"trackId"]];
                [musica setArtista:[item objectForKey:@"artistName"]];
                [musica setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [musica setGenero:[item objectForKey:@"primaryGenreName"]];
                [musica setPais:[item objectForKey:@"country"]];
                [musica setTipo:[item objectForKey:@"kind"]];
                [musicas addObject:musica];
            }

            if ([tipo isEqualToString: @"podcast"])
            {
                Podcast *podcast = [[Podcast alloc] init];
                [podcast setNome:[item objectForKey:@"trackName"]];
                [podcast setTrackId:[item objectForKey:@"trackId"]];
                [podcast setArtista:[item objectForKey:@"artistName"]];
                [podcast setDuracao:[item objectForKey:@"trackTimeMillis"]];
                [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
                [podcast setPais:[item objectForKey:@"country"]];
                [podcast setTipo:[item objectForKey:@"kind"]];
                [podcasts addObject:podcast];
            }
            
            if ([tipo isEqualToString: @"ebook"])
            {
                Ebook *ebook = [[Ebook alloc] init];
                [ebook setNome:[item objectForKey:@"trackName"]];
                [ebook setTrackId:[item objectForKey:@"trackId"]];
                [ebook setArtista:[item objectForKey:@"artistName"]];
                [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
                [ebook setPais:[item objectForKey:@"country"]];
                [ebook setTipo:[item objectForKey:@"kind"]];
                [ebooks addObject:ebook];
            }
            
            NSArray *midiasArray = [[NSArray alloc]initWithObjects:podcasts,filmes,musicas,ebooks, nil];
            return midiasArray;
            
        }
    }

    @catch (NSException *exception)
    {
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                             message:@"Mídia não encontrada"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
            
            [alerta show];
            
            return nil;
    }
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
