package com.sekai.memory.book.mapper;

import com.sekai.memory.book.dataobject.SekaiMemoryBookQuoteDO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author levono
* @description 针对表【sekai_memory_book_quote(台词收藏表)】的数据库操作Mapper
* @createDate 2026-04-29 20:12:23
* @Entity com.sekai.memory.book.dataobject.SekaiMemoryBookQuoteDO
*/

@Mapper
public interface SekaiMemoryBookQuoteMapper {

    int deleteByPrimaryKey(Long id);

    int insert(SekaiMemoryBookQuoteDO record);

    int insertSelective(SekaiMemoryBookQuoteDO record);

    SekaiMemoryBookQuoteDO selectByPrimaryKey(Long id);

    List<SekaiMemoryBookQuoteDO> selectByUserId(@Param("userId") Long userId);

    List<SekaiMemoryBookQuoteDO> selectPageByUserId(@Param("userId") Long userId,
                                                    @Param("offset") int offset,
                                                    @Param("pageSize") int pageSize);

    int countByUserId(@Param("userId") Long userId);

    int deleteByIdAndUserId(@Param("id") Long id, @Param("userId") Long userId);

    int updateByIdAndUserId(SekaiMemoryBookQuoteDO record);

    int updateByPrimaryKeySelective(SekaiMemoryBookQuoteDO record);

    int updateByPrimaryKey(SekaiMemoryBookQuoteDO record);

}
