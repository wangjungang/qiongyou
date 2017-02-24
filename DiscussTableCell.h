//
//  DiscussTableCell.h
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "discussData.h"

@protocol DiscussCellDelegate <NSObject>

- (void)collectionViewCellDidselectWith:(discussData *)data;

@end
@interface DiscussTableCell : UITableViewCell
@property (nonatomic,strong)discussData *data;
@property (nonatomic,assign)id<DiscussCellDelegate>delegate;
@end
