//
//  SearchCell.h
//  QiongTreval
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol searchDelegate <NSObject>

- (void)tapLabelWithString:(NSString *)string;
- (void)qingchuClick;

@end

@interface SearchCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray * btnArr;
@property (nonatomic,strong)NSString *leftLbStr;
@property (nonatomic,assign)BOOL hideQcBtn;
@property (nonatomic,weak)id<searchDelegate>delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andArray:(NSMutableArray * )array;
@end
