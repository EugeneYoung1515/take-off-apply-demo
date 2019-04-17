package com.smart.pardao;

import com.smart.domain.User;

public interface UserParMapper {
    Integer selectCountUserByUserNameAndPassword(String userName,String password);
    User selectUserByUserName(String usrName);
    User selectUserByType(Integer userType);
}
