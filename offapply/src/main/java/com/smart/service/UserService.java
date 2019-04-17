package com.smart.service;

import com.smart.dao.TakeOffMapper;
import com.smart.dao.UserMapper;
import com.smart.domain.TakeOff;
import com.smart.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private UserMapper userMapper;
    private TakeOffMapper takeOffMapper;


    public boolean hasMatchUser(String userName, String password) {
        int matchCount =userMapper.selectCountUserByUserNameAndPassword(userName, password);
        return matchCount > 0;
    }

    public User findUserByUserName(String userName) {
        return userMapper.selectUserByUserName(userName);
    }

    public void applyTakeOff(TakeOff takeOff){
        takeOffMapper.insert(takeOff);
    }

    public TakeOff findTakeOffByUserId(Integer userId){
        return takeOffMapper.selectTakeOffByUserIdOrderByIdLimitOne(userId);
    }

    public TakeOff findTakeOffByStatus(Integer offStatus){
        return takeOffMapper.selectTakeOffByStatusOrderByIdLimitOne(offStatus);
    }

    public void updateTakeOffIfPropertyNull(TakeOff takeOff){
        takeOffMapper.updateByPrimaryKey(takeOff);
    }

    public void updateTakeOff(TakeOff takeOff){
        takeOffMapper.updateByPrimaryKeySelective(takeOff);
    }

    public User findUserById(Integer userId){
        return userMapper.selectByPrimaryKey(userId);
    }

    public User findUserByUserType(Integer userType){
        return userMapper.selectUserByType(userType);
    }

    public TakeOff findTakeOffById(Integer offId){
        return takeOffMapper.selectByPrimaryKey(offId);
    }

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Autowired
    public void setTakeOffMapper(TakeOffMapper takeOffMapper) {
        this.takeOffMapper = takeOffMapper;
    }
}
