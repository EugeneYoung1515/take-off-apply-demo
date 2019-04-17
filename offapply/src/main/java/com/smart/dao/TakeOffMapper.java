package com.smart.dao;

import com.smart.domain.TakeOff;
import com.smart.pardao.TakeOffParMapper;

public interface TakeOffMapper extends TakeOffParMapper{
    int deleteByPrimaryKey(Integer offId);

    int insert(TakeOff record);

    int insertSelective(TakeOff record);

    TakeOff selectByPrimaryKey(Integer offId);

    int updateByPrimaryKeySelective(TakeOff record);

    int updateByPrimaryKey(TakeOff record);
}