package com.smart.shiro;

import com.smart.domain.TakeOff;
import com.smart.domain.User;
import com.smart.service.UserService;
import com.smart.statuscodeconstant.TakeOffStatusCode;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class MyShiroRealm extends AuthorizingRealm {


    @Autowired
    @Lazy
    private UserService userService;

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //System.out.println("here");
        String username = (String) token.getPrincipal();
        User dbUser = userService.findUserByUserName(username);
        //System.out.println(dbUser.getCredits());
        //System.out.println(userService.findUserByUserName("qwer").getPassword());
        //User dbUser=new User();
        //dbUser.setUserName("qwer");
        //dbUser.setPassword("123456");
        if (dbUser == null) {
            //没有返回登录用户名对应的SimpleAuthenticationInfo对象时,就会在LoginController中抛出UnknownAccountException异常
            return null;
        }

        //验证通过返回一个封装了用户信息的AuthenticationInfo实例即可。
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                dbUser, //用户信息
                dbUser.getPassword(), //密码
                getName() //realm name
        );
        return authenticationInfo;
    }

    //当访问到页面的时候，链接配置了相应的权限或者shiro标签才会执行此方法否则不会执行
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(
            PrincipalCollection principals) {
        //String username = (String) principals.fromRealm(
                //getName()).iterator().next();

        User user = (User) principals.fromRealm(
        getName()).iterator().next();


        if( user != null ) {
            TakeOff takeOff = userService.findTakeOffByUserId(user.getUserId());
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            //System.out.println(takeOff.getOffStatus());
            if (takeOff == null) {
                List<String> list = new ArrayList<>(10);
                list.add("apply");
                info.addStringPermissions(list);
                return info;
            }else{
                Date date = new Date();
                if(takeOff.getOffStatus().equals(TakeOffStatusCode.Is_Accepted_By_Third) && takeOff.getEndDate().getTime()<date.getTime()){
                    List<String> list = new ArrayList<>(10);
                    list.add("apply");
                    info.addStringPermissions(list);
                    return info;
                }else if(takeOff.getOffStatus().equals(TakeOffStatusCode.Off_Prepared) ||takeOff.getOffStatus().equals(TakeOffStatusCode.Is_Not_Accepted)) {
                    List<String> list = new ArrayList<>(10);
                    list.add("update");
                    info.addStringPermissions(list);
                    return info;
                }
            }
        }

        return null;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
    public UserService getUserService(){
        return userService;
    }
}

