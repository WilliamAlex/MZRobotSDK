//
//  MZRobotApi.m
//  demo
//
//  Created by Alex William on 2018/8/13.
//  Copyright © 2018年 MoziTechnology. All rights reserved.
//

#import "MZRobotApi.h"

@implementation MZRobotApi


+ (void)getLogWithTag:(NSInteger)tag {
    
    switch (tag) {
        case 0:
        {
            NSLog(@"ios");
        }
            break;
        case 1:
        {
            NSLog(@"Android");
        }
            break;
        case 2:
        {
            NSLog(@"区块链");
        }
            break;
        case 3:
        {
            NSLog(@"人工智能");
        }
            break;
            
        default:
            break;
    }
}
@end
