//
//  XXBTransitionCell.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing5 on 2018/9/12.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBTransitionCell.h"


@interface XXBTransitionCell()

@property(nonatomic, weak) UILabel  *messageLable;
@end

@implementation XXBTransitionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTransitionModel:(XXBTransitionModel *)transitionModel {
    _transitionModel = transitionModel;
    [self updateUI];
}

- (void)updateUI {
    self.messageLable.text = self.transitionModel.title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.messageLable.frame = CGRectMake(10, 0, self.contentView.frame.size.width - 10, self.contentView.frame.size.height);
}

- (UILabel *)messageLable {
    if (_messageLable == nil) {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:messageLabel];
        messageLabel.autoresizingMask = (1 << 6) - 1;
        _messageLable = messageLabel;
    }
    return _messageLable;
}

@end
