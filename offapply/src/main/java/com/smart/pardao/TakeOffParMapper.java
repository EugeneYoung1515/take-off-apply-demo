package com.smart.pardao;

import com.smart.domain.TakeOff;

public interface TakeOffParMapper {
    TakeOff selectTakeOffByUserIdOrderByIdLimitOne(Integer userId);
    TakeOff selectTakeOffByStatusOrderByIdLimitOne(Integer offStatus);
}
