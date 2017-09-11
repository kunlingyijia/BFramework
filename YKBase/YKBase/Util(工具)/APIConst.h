//
//APIConst.h
//DWduifubao
//
//Created by 席亚坤 on 17/5/10.
//Copyright © 2017年 bianming. All rights reserved.
//

#import <UIKit/UIKit.h>


extern  NSString * const kServerUrl;
///act+api
extern  NSString * const ACT_API;
///获取系统配置
extern NSString * const  Request_System ;
///版本检测
extern NSString * const  Request_VersionCheck ;
///消息列表
extern NSString * const  Request_MessageList ;
///请求验证码
extern NSString * const  Request_VerifyCode ;
///注册
extern NSString * const  Request_Register;
///登录
extern NSString * const  Request_Login ;
///登录
extern NSString * const  Request_ThirdLogin ;
//第三方登录绑定手机号
extern NSString * const  Request_ThirdLoginBindMobile ;
///找回密码
extern NSString * const  Request_ForgottenPassword ;
///修改密码
extern NSString * const  Request_UpdatePassword ;
///获取个人信息
extern NSString * const  Request_UserInfo ;
///修改个人信息
extern NSString * const  Request_UpdateUserInfo ;
///实名认证
extern NSString * const  Request_Certify ;
///实名认证查询
extern NSString * const  Request_CertifyInfo ;
///消息列表
extern NSString * const  Request_MessageList ;
///首页轮播图+公告+我的信用卡
extern NSString * const  Request_Home_requestAd ;
///获取文章内容
extern NSString * const  Request_Home_articleInfo ;
///我的银行卡
extern NSString * const  Request_BankCardList;
///获取银行卡信息
extern NSString * const  Request_BankCardInfo;

///计划列表
extern NSString * const  Request_PlanList ;
///计划流水
extern NSString * const  Request_PlanFlowList ;


///删除计划
extern NSString * const  Request_DeletePlan ;
///下一步（生成计划)
extern NSString * const  Request_CreatePlan ;
///提交计划
extern NSString * const  Request_SubmitPlan ;
///计算保证金/手续费
extern NSString * const  Request_CalculateFee ;
///获取计划信息/预览计划
extern NSString * const  Request_PlanInfo ;
///更换计划
extern NSString * const  Request_ReplacePlan ;
///支付计划
extern NSString * const  Request_PayPlan ;

///添加借记卡
extern NSString * const  Request_BankAddDebitCard ;
///添加信用卡
extern NSString * const  Request_AddCreditCard ;
///修改资料（信用卡）
extern NSString * const  Request_EditCreditCard ;
///卡片解绑
extern NSString * const  Request_DeleteCard ;
///快捷签约短信
extern NSString * const  Request_quickSms ;
///快捷签约查询
extern NSString * const  Request_quickQuery ;
///提现
extern NSString * const  Request_Withdraw ;
///快速充值
extern NSString * const  Request_QuickRecharge ;

///银行卡账单
extern NSString * const  Request_BillList ;













/*---------------------------------数据---------------------------------*/
///返回时间
extern  CGFloat  const backTime;
///切角
extern  CGFloat  const cutRadius;
///边宽
extern  CGFloat  const borderW;


