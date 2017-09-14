//
//APIConst.m
//DWduifubao
//
//Created by 席亚坤 on 17/5/10.
//Copyright © 2017年 bianming. All rights reserved.




///外网
NSString * const kServerUrl = @"http://39.108.129.18/?";
///内网
//NSString * const kServerUrl = @"http://qiaoqiao.ftxqq.cn/?";
///act+api
NSString * const ACT_API = @"act=Api";
///获取系统配置
NSString * const  Request_System = @"/System/config";
///版本检测
NSString * const  Request_VersionCheck = @"/System/versionCheck";
///消息列表
NSString * const  Request_MessageList = @"/Message/requestMessageList";
///请求验证码
NSString * const  Request_VerifyCode = @"/VerifyCode/sendVerifyCode";
///注册
NSString * const  Request_Register  = @"/Login/requestRegister";
///登录
NSString * const  Request_Login = @"/Login/login";
//第三方登录
NSString * const  Request_ThirdLogin =@"/Login/thirdLogin";
//第三方登录绑定手机号
NSString * const  Request_ThirdLoginBindMobile =@"/Login/thirdLoginBindMobile";
///找回密码
NSString * const  Request_ForgottenPassword =@"/User/forgotPassword";
///修改密码
NSString * const  Request_UpdatePassword  = @"/User/updatePassword";
///获取个人信息
NSString * const  Request_UserInfo = @"/User/userInfo";
///修改个人信息
NSString * const  Request_UpdateUserInfo = @"/User/updateUserInfo";
///实名认证
NSString * const  Request_Certify = @"/User/certify";
///实名认证查询
NSString * const  Request_CertifyInfo = @"/User/info";
///首页轮播图+公告+我的信用卡
NSString * const  Request_Home_requestAd = @"/HomePage/allInfo";
///获取文章内容
NSString * const  Request_Home_articleInfo = @"/HomePage/articleInfo";
///我的银行卡
NSString * const  Request_BankCardList = @"/Bank/bankCardList";
///获取银行卡信息
NSString * const  Request_BankCardInfo = @"/Bank/bankCardInfo";



///计划列表
NSString * const  Request_PlanList = @"/Plan/planList";
///计划流水
NSString * const  Request_PlanFlowList = @"/Plan/planFlowList";


///删除计划
NSString * const  Request_DeletePlan = @"/Plan/deletePlan";
///下一步（生成计划)
NSString * const  Request_CreatePlan = @"/Plan/createPlan";
///提交计划
NSString * const  Request_SubmitPlan = @"/Plan/submitPlan";


///计算保证金/手续费
NSString * const  Request_CalculateFee = @"/Plan/calculateFee";
///获取计划信息/预览计划
NSString * const  Request_PlanInfo = @"/Plan/planInfo";
///更换计划
NSString * const  Request_ReplacePlan = @"/Plan/replacePlan";
///支付计划
NSString * const  Request_PayPlan = @"/Plan/payPlan";


///添加借记卡
NSString * const  Request_BankAddDebitCard = @"/Bank/addDebitCard";
///添加信用卡
NSString * const  Request_AddCreditCard = @"/Bank/addCreditCard";
///修改资料（信用卡）
NSString * const  Request_EditCreditCard = @"/Bank/editCreditCard";
///卡片解绑
NSString * const  Request_DeleteCard = @"/Bank/deleteCard";
///快捷签约短信
NSString * const  Request_quickSms = @"/Bank/quickSms";
///快捷签约查询
NSString * const  Request_quickQuery = @"/Bank/quickQuery";
///提现
NSString * const  Request_Withdraw = @"/Bank/withdraw";
///快速充值（荣邦）
NSString * const  Request_QuickRecharge = @"/UserRecharge/quickRecharge";
///快速充值--获取验证码（华付通)
NSString * const  Request_HftQuickSms = @"/UserRecharge/hftQuickSms";
///快速充值（华付通）
NSString * const  Request_HftQuickRecharge = @"/UserRecharge/hftQuickRecharge";
///用户账户流水
NSString * const  Request_User_flowLis = @"/User/flowList";




///银行卡账单
NSString * const  Request_BillList = @"/Bank/billList";







/*---------------------------------数据---------------------------------*/
///返回时间
CGFloat  const backTime = 0.4;
///切角
CGFloat  const cutRadius = 8.0;
///边宽
CGFloat  const borderW = 1.0;




