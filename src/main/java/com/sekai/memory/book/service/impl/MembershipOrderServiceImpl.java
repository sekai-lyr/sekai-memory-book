package com.sekai.memory.book.service.impl;

import com.sekai.memory.book.dataobject.SekaiMemoryBookOrderDO;
import com.sekai.memory.book.mapper.SekaiMemoryBookOrderMapper;
import com.sekai.memory.book.service.MembershipOrderService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Service
public class MembershipOrderServiceImpl implements MembershipOrderService {

    @Resource
    private SekaiMemoryBookOrderMapper orderMapper;

    @Override
    @Transactional
    public SekaiMemoryBookOrderDO createDemoOrder(Long userId, String planCode, BigDecimal amount) {
        if (userId == null) {
            return null;
        }
        SekaiMemoryBookOrderDO order = new SekaiMemoryBookOrderDO();
        order.setOrderNo(buildOrderNo());
        order.setUserId(userId);
        order.setPlanCode(planCode == null || planCode.isBlank() ? "PRO_MONTHLY" : planCode);
        order.setAmount(amount == null ? new BigDecimal("12.00") : amount);
        order.setPayChannel("DEMO");
        order.setStatus("PENDING");
        orderMapper.insertSelective(order);
        return orderMapper.selectByOrderNo(order.getOrderNo());
    }

    @Override
    @Transactional
    public void markPaid(String orderNo, String payChannel) {
        SekaiMemoryBookOrderDO order = orderMapper.selectByOrderNo(orderNo);
        if (order == null) {
            return;
        }
        order.setStatus("PAID");
        order.setPayChannel(payChannel == null || payChannel.isBlank() ? "DEMO" : payChannel);
        order.setPaidTime(LocalDateTime.now());
        orderMapper.updateStatusPaid(order);
    }

    @Override
    public List<SekaiMemoryBookOrderDO> listByUserId(Long userId) {
        if (userId == null) {
            return List.of();
        }
        return orderMapper.listByUserId(userId);
    }

    private String buildOrderNo() {
        String day = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String suffix = UUID.randomUUID().toString().replace("-", "").substring(0, 8).toUpperCase();
        return "SMB" + day + suffix;
    }
}
