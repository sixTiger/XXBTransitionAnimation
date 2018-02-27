//
//  XXBTransitionAnimationCell.m
//  XXBTransitionAnimationDemo
//
//  Created by xiaobing on 2018/2/27.
//  Copyright © 2018年 xiaobing. All rights reserved.
//

#import "XXBTransitionAnimationCell.h"

@interface XXBTransitionAnimationCell()

@property(nonatomic, weak) UILabel  *messageLable;
@end

@implementation XXBTransitionAnimationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(XXBTransitionAnimationModel *)model {
    _model = model;
    [self updateUI];
}

- (void)updateUI {
    self.messageLable.text = self.model.titel;
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
