//
//  THSingleLabelCell.h
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THSingleLabelCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *singleLabel;

@property (nonatomic) BOOL isSelected;

@end
