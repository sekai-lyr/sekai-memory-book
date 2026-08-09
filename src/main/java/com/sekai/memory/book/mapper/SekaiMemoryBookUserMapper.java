package com.sekai.memory.book.mapper;

import com.sekai.memory.book.dataobject.SekaiMemoryBookUserDO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 用户表 Mapper
 */
@Mapper
public interface SekaiMemoryBookUserMapper {

    int deleteByPrimaryKey(Long id);

    int insert(SekaiMemoryBookUserDO record);

    int insertSelective(SekaiMemoryBookUserDO record);

    SekaiMemoryBookUserDO selectByPrimaryKey(Long id);

    SekaiMemoryBookUserDO selectByUserName(@Param("userName") String userName);

    SekaiMemoryBookUserDO selectByPhoneNumber(@Param("phoneNumber") String phoneNumber);

    SekaiMemoryBookUserDO selectByLoginName(@Param("loginName") String loginName);

    int updateByPrimaryKeySelective(SekaiMemoryBookUserDO record);

    int updateByPrimaryKey(SekaiMemoryBookUserDO record);
}
