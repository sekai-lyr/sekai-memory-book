package com.sekai.memory.book.mapper;

import com.sekai.memory.book.dataobject.SekaiMemoryBookOrderDO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SekaiMemoryBookOrderMapper {

    int insertSelective(SekaiMemoryBookOrderDO record);

    SekaiMemoryBookOrderDO selectByOrderNo(@Param("orderNo") String orderNo);

    List<SekaiMemoryBookOrderDO> listByUserId(@Param("userId") Long userId);

    int updateStatusPaid(SekaiMemoryBookOrderDO record);
}
