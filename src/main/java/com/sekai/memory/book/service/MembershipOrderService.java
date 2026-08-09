package com.sekai.memory.book.service;

import com.sekai.memory.book.dataobject.SekaiMemoryBookOrderDO;

import java.math.BigDecimal;
import java.util.List;

public interface MembershipOrderService {

    SekaiMemoryBookOrderDO createDemoOrder(Long userId, String planCode, BigDecimal amount);

    void markPaid(String orderNo, String payChannel);

    List<SekaiMemoryBookOrderDO> listByUserId(Long userId);
}
