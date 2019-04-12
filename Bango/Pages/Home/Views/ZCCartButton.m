//
//  ZCCartButton.m
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartButton.h"
#import "ZCBaseGodsModel.h"

@interface ZCCartButton ()
/** 购物车 */
@property(nonatomic, strong) UIButton *cartButton;

/** 添加 */
@property(nonatomic, strong) UIButton *addButton;

/** 减法 */
@property(nonatomic, strong) UIButton *divisionButton;

/** 购买数量 */
@property(nonatomic, strong) UILabel *countLab;

@property(nonatomic, strong) RACCommand *addCmd;

@property(nonatomic, strong) RACCommand *divisionCmd;

@end

@implementation ZCCartButton


- (void)setBaseModel:(ZCBaseGodsModel *)baseModel {
    _baseModel = baseModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
        @weakify(self);
        RAC(self.countLab, text) = RACObserve(self, baseModel.have_num);
        [RACObserve(self, baseModel.hide) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
//            self.divisionButton.hidden = self.countLab.hidden = [x boolValue];
            self.divisionButton.hidden = self.countLab.hidden = self.addButton.selected = [x boolValue];

//            [self.addButton setImage:[x boolValue] ? ImageNamed(@"tabBar3_select"): ImageNamed(@"home_add") forState:UIControlStateNormal];
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        @weakify(self);
        RAC(self.countLab, text) = RACObserve(self, baseModel.have_num);
        [RACObserve(self, baseModel.hide) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.divisionButton.hidden = self.countLab.hidden = self.addButton.selected = [x boolValue];
//            [self.addButton setImage:[x boolValue] ? ImageNamed(@"tabBar3_select"): ImageNamed(@"home_add") forState:UIControlStateNormal];
        }];
    }
    return self;
}


- (void)commonInit {
    self.addButton = [UITool imageButton:ImageNamed(@"home_add")];
    [self.addButton setImage:ImageNamed(@"tabBar3_select") forState:UIControlStateSelected];
    self.divisionButton = [UITool imageButton:ImageNamed(@"home_division")];
    self.countLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(WidthRatio(14)) alignment:NSTextAlignmentCenter];
    self.divisionButton.hidden = self.countLab.hidden = YES;
    [self.countLab setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.addButton];
    [self addSubview:self.divisionButton];
    [self addSubview:self.countLab];
    
    
    @weakify(self);
    self.addButton.rac_command = self.addCmd;
    self.divisionButton.rac_command = self.divisionCmd;
//    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self);
//        self.baseModel.count = [NSString stringWithFormat:@"%ld", self.baseModel.count.integerValue+1];
//        self.baseModel.hide = ![self.baseModel.count boolValue];
//    }];
    
//    [[self.divisionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self);
//
//        self.baseModel.count = [NSString stringWithFormat:@"%ld", self.baseModel.count.integerValue-1];
//
//        self.baseModel.hide = ![self.baseModel.count boolValue];
//    }];
    
    [self setNeedsUpdateConstraints];
}


- (void)updateConstraints {
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
    }];
    
    [self.divisionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self);
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.divisionButton.mas_right);
        make.right.equalTo(self.addButton.mas_left);
    }];
    
    [super updateConstraints];
}


- (CGSize)intrinsicContentSize {
    return CGSizeMake(76.f, 23.f);
}

- (void)sdfa {
    [NetWorkManager.sharedManager requestWithUrl:kGods_addCart withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
        
    } withFailure:^(NSError * _Nonnull error) {
        
    }];
    
    [NetWorkManager.sharedManager requestWithUrl:kGods_cartAdjustNum withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
        
    } withFailure:^(NSError * _Nonnull error) {
        
    }];
    
}


- (RACCommand *)addCmd {
    if (!_addCmd) {
        @weakify(self);
        _addCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                
                UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                NSDictionary *dic = @{@"asstoken":info.asstoken,
                                      @"goods_id":self.baseModel.goods_id,
                                      @"type":@"0"};
                
                [NetWorkManager.sharedManager requestWithUrl:kGods_cartAdjustNum withParameters:dic withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        self.baseModel.have_num = [NSString stringWithFormat:@"%ld", self.baseModel.have_num.integerValue+1];
                        self.baseModel.hide = ![self.baseModel.have_num boolValue];
                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _addCmd;
}


- (RACCommand *)divisionCmd {
    if (!_divisionCmd) {
        @weakify(self);
        _divisionCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                
                UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                NSDictionary *dic = @{@"asstoken":info.asstoken,
                                      @"goods_id":self.baseModel.goods_id,
                                      @"type":@"1"};
                
                [NetWorkManager.sharedManager requestWithUrl:kGods_cartAdjustNum withParameters:dic withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        self.baseModel.have_num = [NSString stringWithFormat:@"%ld", self.baseModel.have_num.integerValue-1];
                        self.baseModel.hide = ![self.baseModel.have_num boolValue];
                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }
                    
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _divisionCmd;
}

@end
