//
//APIConst.m
//DWduifubao
//
//Created by 席亚坤 on 17/5/10.
//Copyright © 2017年 bianming. All rights reserved.




///外网
//NSString * const kServerUrl = @"https://api.zgduifubao.com/?";
///内网
NSString * const kServerUrl = @"http://qiaoqiao.dongwuit.com/?";
///act+api
NSString * const ACT_API = @"act=Api";
///获取系统配置
NSString * const  Request_System = @"/System/config";
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
NSString * const  Request_ForgottenPassword =@"/User/forgottenPassword";
///修改密码
NSString * const  Request_UpdatePassword  = @"/User/updatePassword";
///获取个人信息
NSString * const  Request_UserInfo = @"/User/userInfo";
///修改个人信息
NSString * const  Request_UpdateUserInfo = @"/User/updateUserInfo";
///实名认证
NSString * const  Request_Certify = @"/UserCertify/certify";
///重新实名认证
NSString * const  Request_UpdateCertify = @"/UserCertify/updateCertify";
///实名认证查询
NSString * const  Request_CertifyInfo = @"/UserCertify/info";
///首页轮播图+公告+我的信用卡
NSString * const  Request_Home_requestAd = @"/Home/requestAd";
///查看计划
NSString * const  Request_PlanList = @"/Plan/planList";
///删除计划
NSString * const  Request_DeletePlan = @"/Plan/deletePlan";
///计算保证金/手续费
NSString * const  Request_CalculateFee = @"/Plan/calculateFee";
///获取计划信息/预览计划
NSString * const  Request_PlanInfo = @"/Plan/planInfo";
///更换计划
NSString * const  Request_UpdatePlan = @"/Plan/updatePlan";
///添加借记卡
NSString * const  Request_BankAddDebitCard = @"/Bank/addDebitCard";
///添加信用卡
NSString * const  Request_AddCreditCard = @"/Bank/addCreditCard";
///提现
NSString * const  Request_Withdraw = @"/Bank/withdraw";



















