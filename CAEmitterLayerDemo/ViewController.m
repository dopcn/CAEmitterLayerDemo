//
//  ViewController.m
//  CAEmitterLayerDemo
//
//  Created by 纬洲 冯 on 06/04/2017.
//  Copyright © 2017 com.fengweizhou All rights reserved.
//

#import "ViewController.h"
#import "LayerSetting.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init value
    LayerSetting *setting = [LayerSetting sharedInstance];
    setting.emitterPosition = CGPointMake(self.view.frame.size.width/2, -10);
    setting.emitterSize = CGSizeMake(self.view.frame.size.width, 0);
    
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"cell";
    cell.contents = (id)[UIImage imageNamed:@"cell"].CGImage;
    layer.emitterCells = @[cell];
    
    self.emitterCell = cell;
    self.emitterLayer = layer;
    
    [self.view.layer addSublayer:self.emitterLayer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (NSString *name in [[LayerSetting sharedInstance] propertyNames]) {
        id value = [[LayerSetting sharedInstance] valueForKey:name];
        if (class_getProperty([self.emitterCell class], name.UTF8String)) {
            [self.emitterLayer setValue:[[LayerSetting sharedInstance] valueForKey:name] forKeyPath:[@"emitterCells.cell." stringByAppendingString:name]];
            NSLog(@"set cell: %@ to %@", name, value);
        } else if (class_getProperty([self.emitterLayer class], name.UTF8String)) {
            [self.emitterLayer setValue:[[LayerSetting sharedInstance] valueForKey:name] forKey:name];
            NSLog(@"set layer: %@ to %@", name, value);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
