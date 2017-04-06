//
//  SettingTableViewController.m
//  CAEmitterLayerDemo
//
//  Created by 纬洲 冯 on 06/04/2017.
//  Copyright © 2017 im.enai. All rights reserved.
//

#import "SettingTableViewController.h"
#import "LayerSetting.h"
#import <objc/runtime.h>

@interface SettingTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *positionX;
@property (weak, nonatomic) IBOutlet UITextField *positionY;
@property (weak, nonatomic) IBOutlet UITextField *emitterZPosition;
@property (weak, nonatomic) IBOutlet UITextField *width;
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UITextField *emitterDepth;
@property (weak, nonatomic) IBOutlet UITextField *birthRate;
@property (weak, nonatomic) IBOutlet UITextField *lifetime;
@property (weak, nonatomic) IBOutlet UITextField *lifetimeRange;
@property (weak, nonatomic) IBOutlet UITextField *emissionLatitude;
@property (weak, nonatomic) IBOutlet UITextField *emissionLongitude;
@property (weak, nonatomic) IBOutlet UITextField *emissionRange;
@property (weak, nonatomic) IBOutlet UITextField *velocity;
@property (weak, nonatomic) IBOutlet UITextField *velocityRange;
@property (weak, nonatomic) IBOutlet UITextField *xAcceleration;
@property (weak, nonatomic) IBOutlet UITextField *yAcceleration;
@property (weak, nonatomic) IBOutlet UITextField *zAcceleration;
@property (weak, nonatomic) IBOutlet UITextField *scale;
@property (weak, nonatomic) IBOutlet UITextField *scaleRange;
@property (weak, nonatomic) IBOutlet UITextField *scaleSpeed;
@property (weak, nonatomic) IBOutlet UITextField *spin;
@property (weak, nonatomic) IBOutlet UITextField *spinRange;

@property (weak, nonatomic) IBOutlet UIButton *shape;
@property (weak, nonatomic) IBOutlet UIButton *mode;
@property (weak, nonatomic) IBOutlet UIButton *renderModeBtn;


@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (NSString *name in [[LayerSetting sharedInstance] propertyNames]) {
        if (class_getProperty([self class], name.UTF8String)) {
            id value = [[LayerSetting sharedInstance] valueForKey:name];
            if ([value isKindOfClass:[NSNumber class]]) {
                value = [(NSNumber *)value stringValue];
            }
            NSString *keyPath = [name stringByAppendingString:@".text"];
            [self setValue:value forKeyPath:keyPath];
        }
    }
    self.positionX.text = @([LayerSetting sharedInstance].emitterPosition.x).stringValue;
    self.positionY.text = @([LayerSetting sharedInstance].emitterPosition.y).stringValue;
    self.width.text = @([LayerSetting sharedInstance].emitterSize.width).stringValue;
    self.height.text = @([LayerSetting sharedInstance].emitterSize.height).stringValue;
    
    [self.shape setTitle:[LayerSetting sharedInstance].emitterShape forState:UIControlStateNormal];
    [self.mode setTitle:[LayerSetting sharedInstance].emitterMode forState:UIControlStateNormal];
    [self.renderModeBtn setTitle:[LayerSetting sharedInstance].renderMode forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)apply:(id)sender {
    LayerSetting *setting = [LayerSetting sharedInstance];
    setting.emitterPosition = CGPointMake(self.positionX.text.floatValue, self.positionY.text.floatValue);
    setting.emitterZPosition = self.emitterZPosition.text.floatValue;
    setting.emitterSize = CGSizeMake(self.width.text.floatValue, self.height.text.floatValue);
    setting.emitterDepth = self.emitterDepth.text.floatValue;
    setting.birthRate = self.birthRate.text.floatValue;
    setting.lifetime = self.lifetime.text.floatValue;
    setting.lifetimeRange = self.lifetimeRange.text.floatValue;
    setting.emissionLatitude = self.emissionLatitude.text.floatValue;
    setting.emissionLongitude = self.emissionLongitude.text.floatValue;
    setting.emissionRange = self.emissionRange.text.floatValue;
    setting.velocity = self.velocity.text.floatValue;
    setting.velocityRange = self.velocityRange.text.floatValue;
    setting.xAcceleration = self.xAcceleration.text.floatValue;
    setting.yAcceleration = self.yAcceleration.text.floatValue;
    setting.zAcceleration = self.zAcceleration.text.floatValue;
    setting.scale = self.scale.text.floatValue;
    setting.scaleRange = self.scaleRange.text.floatValue;
    setting.scaleSpeed = self.scaleSpeed.text.floatValue;
    setting.spin = self.spin.text.floatValue;
    setting.spinRange = self.spinRange.text.floatValue;
    
    setting.emitterShape = self.shape.titleLabel.text;
    setting.emitterMode = self.mode.titleLabel.text;
    setting.renderMode = self.renderModeBtn.titleLabel.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeShape:(UIButton *)sender {
    NSArray *shapes = @[kCAEmitterLayerPoint, kCAEmitterLayerLine, kCAEmitterLayerCircle, kCAEmitterLayerCuboid, kCAEmitterLayerRectangle, kCAEmitterLayerSphere];
    [self showActionSheetForButton:sender title:@"change shape" actions:shapes];
}

- (IBAction)changeMode:(UIButton *)sender {
    NSArray *modes = @[kCAEmitterLayerPoints, kCAEmitterLayerOutline, kCAEmitterLayerSurface, kCAEmitterLayerVolume];
    [self showActionSheetForButton:sender title:@"change mode" actions:modes];
}

- (IBAction)changeRenderMode:(UIButton *)sender {
    NSArray *renderModes = @[kCAEmitterLayerUnordered, kCAEmitterLayerOldestFirst, kCAEmitterLayerOldestLast, kCAEmitterLayerBackToFront, kCAEmitterLayerAdditive];
    [self showActionSheetForButton:sender title:@"change render mode" actions:renderModes];
}

- (void)showActionSheetForButton:(UIButton *)btn title:(NSString *)title actions:(NSArray *)actions {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *name in actions) {
        UIAlertAction *aa = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [btn setTitle:action.title forState:UIControlStateNormal];
        }];
        [ac addAction:aa];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];
    [ac addAction:cancel];
    [self presentViewController:ac animated:YES completion:nil]; 
}

@end
