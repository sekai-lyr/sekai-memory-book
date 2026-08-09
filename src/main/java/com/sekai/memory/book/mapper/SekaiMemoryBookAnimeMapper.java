package com.sekai.memory.book.mapper;

import com.sekai.memory.book.dataobject.SekaiMemoryBookAnimeDO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author levono
* @description 针对表【sekai_memory_book_anime(番剧回忆表)】的数据库操作Mapper
* @createDate 2026-04-29 20:12:34
* @Entity com.sekai.memory.book.dataobject.SekaiMemoryBookAnimeDO
*/

@Mapper
public interface SekaiMemoryBookAnimeMapper {

    int deleteByPrimaryKey(Long id);

    int insert(SekaiMemoryBookAnimeDO record);

    int insertSelective(SekaiMemoryBookAnimeDO record);

    SekaiMemoryBookAnimeDO selectByPrimaryKey(Long id);

    SekaiMemoryBookAnimeDO selectByIdAndUserId(@Param("id") Long id, @Param("userId") Long userId);

    List<SekaiMemoryBookAnimeDO> selectByUserId(@Param("userId") Long userId);

    List<SekaiMemoryBookAnimeDO> selectFilteredByUserId(@Param("userId") Long userId,
                                                        @Param("keyword") String keyword);

    int countByUserId(@Param("userId") Long userId, @Param("keyword") String keyword);

    int deleteByIdAndUserId(@Param("id") Long id, @Param("userId") Long userId);

    int updateByIdAndUserId(SekaiMemoryBookAnimeDO record);

    int updateByPrimaryKeySelective(SekaiMemoryBookAnimeDO record);

    int updateByPrimaryKey(SekaiMemoryBookAnimeDO record);

}
