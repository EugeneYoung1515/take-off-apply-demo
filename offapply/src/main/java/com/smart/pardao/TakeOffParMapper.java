package com.smart.pardao;

import com.smart.domain.TakeOff;

import java.util.List;

public interface TakeOffParMapper {
    TakeOff selectTakeOffByUserIdOrderByIdLimitOne(Integer userId);
    TakeOff selectTakeOffByStatusOrderByIdLimitOne(Integer offStatus);
    List<TakeOff> selectAllTakeOffByUserId(Integer param1, Integer param2, Integer param3);
    Integer insertReturnId(TakeOff record);
    Integer selectCountTakeOffByUserId(Integer userId);
}
