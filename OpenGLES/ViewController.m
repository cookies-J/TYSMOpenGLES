//
//  ViewController.m
//  OpenGLES
//
//  Created by jele lam on 8/12/2019.
//  Copyright © 2019 CookiesJ. All rights reserved.
//

#import "ViewController.h"
#import "TYSMGLBlankView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TYSMGLBlankView *blankView = [[TYSMGLBlankView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:blankView];
    // Do any additional setup after loading the view.
}

@end
