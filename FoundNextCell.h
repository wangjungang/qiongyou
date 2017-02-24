//
//  FoundNextCell.h
//  QiongTreval
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subjectData.h"

@protocol FoundCellDelegate <NSObject>

- (void)tapImageViewWith:(subjectData * )data;
- (void)seeMoreContentButtonClick;

@end

@interface FoundNextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

- (IBAction)moreButton:(id)sender;
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,weak) id <FoundCellDelegate> delegate;
@end
