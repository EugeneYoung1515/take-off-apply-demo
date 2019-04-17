package com.smart.dao;

import com.smart.domain.User;
import com.smart.pardao.UserParMapper;

public interface UserMapper extends UserParMapper{
    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
}