//
//  ZCCartButton.m
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartButton.h"
#import "ZCBaseGodsModel.h"
#import "LCAlertTools.h"

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
            self.divisionButton.hidden = self.countLab.hidden = self.addButton.selected = [x boolValue];
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


- (RACCommand *)addCmd {
    if (!_addCmd) {
        @weakify(self);
        _addCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                
                UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                if (StringIsEmpty(info.asstoken)) {//存本地
                    self.baseModel.have_num = [NSString stringWithFormat:@"%ld", self.baseModel.have_num.integerValue+1];
                    self.baseModel.hide = ![self.baseModel.have_num boolValue];
                    [BaseMethod saveGoodsModel:self.baseModel withKey:self.baseModel.goods_id];
                    [subscriber sendCompleted];
                    return nil;
                }
                
                [self executeCmdWithSubscriber:subscriber type:@"0"];
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
                if (StringIsEmpty(info.asstoken)) {//本地操作
                    if (self.baseModel.have_num.integerValue == 1 && self.baseModel.deleteEnsure) { //二次确认
                        
                        [LCAlertTools showTipAlertViewWith:[UIApplication sharedApplication].keyWindow.rootViewController title:@"您确定删除该商品吗" message:nil cancelTitle:@"取消" defaultTitle:@"确定" cancelHandler:^{
                            [subscriber sendCompleted];
                        } defaultHandler:^{
                            
                            self.baseModel.have_num = [NSString stringWithFormat:@"%ld", self.baseModel.have_num.integerValue-1];
                            self.baseModel.hide = ![self.baseModel.have_num boolValue];
                            [BaseMethod deleteGoodsModelForKey:self.baseModel.goods_id];
                            [subscriber sendCompleted];
                        }];
                    }else {
                        self.baseModel.have_num = [NSString stringWithFormat:@"%ld", self.baseModel.have_num.integerValue-1];
                        self.baseModel.hide = ![self.baseModel.have_num boolValue];
                        [BaseMethod saveGoodsModel:self.baseModel withKey:self.baseModel.goods_id];
                        [subscriber sendCompleted];
                    }
                    return nil;
                }
                
                
                if (self.baseModel.have_num.integerValue == 1 && self.baseModel.deleteEnsure) { //二次确认
                    
                    [LCAlertTools showTipAlertViewWith:[UIApplication sharedApplication].keyWindow.rootViewController title:@"您确定删除该商品吗" message:nil cancelTitle:@"取消" defaultTitle:@"确定" cancelHandler:^{
//                        [subscriber sendNext:@(0)];
                        [subscriber sendCompleted];
                    } defaultHandler:^{
                        [self executeCmdWithSubscriber:subscriber type:@"1"];
                    }];
                    
                }else {
                    [self executeCmdWithSubscriber:subscriber type:@"1"];
                }
                return nil;
            }];
        }];
    }
    return _divisionCmd;
}


- (void)executeCmdWithSubscriber:(id<RACSubscriber>  _Nonnull) subscriber type:(NSString *)type{
    
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    NSDictionary *dic = @{@"asstoken":info.asstoken,
                          @"goods_id":self.baseModel.goods_id,
                          @"type":type};
    
    [NetWorkManager.sharedManager requestWithUrl:kGods_cartAdjustNum withParameters:dic withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
        if (kStatusTrue) {
            self.baseModel.have_num = StringFormat(@"%@", responseObject[@"data"]);
            self.baseModel.hide = ![self.baseModel.have_num boolValue];
            if (self.baseModel.deleteEnsure && ![self.baseModel.have_num boolValue]) {//购物车列表减为0
                [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"removeGoods"];
            }else {
                [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];
            }
            
            if ([self.baseModel.have_num boolValue]) {
                [[ZCCartManager manager].goodsDic setObject:self.baseModel forKey:self.baseModel.goods_id];
            }else {//购物车商品减为0
                [[ZCCartManager manager].goodsDic removeObjectForKey:self.baseModel.goods_id];
            }

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
}

@end
