package com.sekai.memory.book.mapper;

import com.sekai.memory.book.dataobject.SekaiMemoryBookCharacterFavoriteDO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author levono
* @description 针对表【sekai_memory_book_character_favorite(角色收藏表)】的数据库操作Mapper
* @createDate 2026-04-29 20:12:29
* @Entity com.sekai.memory.book.dataobject.SekaiMemoryBookCharacterFavoriteDO
*/

@Mapper
public interface SekaiMemoryBookCharacterFavoriteMapper {

    int deleteByPrimaryKey(Long id);

    int insert(SekaiMemoryBookCharacterFavoriteDO record);

    int insertSelective(SekaiMemoryBookCharacterFavoriteDO record);

    SekaiMemoryBookCharacterFavoriteDO selectByPrimaryKey(Long id);

    List<SekaiMemoryBookCharacterFavoriteDO> selectByUserId(@Param("userId") Long userId);

    List<SekaiMemoryBookCharacterFavoriteDO> selectPageByUserId(@Param("userId") Long userId,
                                                                @Param("offset") int offset,
                                                                @Param("pageSize") int pageSize);

    int countByUserId(@Param("userId") Long userId);

    int deleteByIdAndUserId(@Param("id") Long id, @Param("userId") Long userId);

    int updateByIdAndUserId(SekaiMemoryBookCharacterFavoriteDO record);

    int updateByPrimaryKeySelective(SekaiMemoryBookCharacterFavoriteDO record);

    int updateByPrimaryKey(SekaiMemoryBookCharacterFavoriteDO record);

}
