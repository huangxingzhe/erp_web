package com.hxx.erp.dao;

import com.hxx.erp.model.GoodsGui;
import com.hxx.erp.model.GoodsGuiExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GoodsGuiMapper {
    int countByExample(GoodsGuiExample example);

    int deleteByExample(GoodsGuiExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(GoodsGui record);

    int insertSelective(GoodsGui record);

    List<GoodsGui> selectByExample(GoodsGuiExample example);

    GoodsGui selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") GoodsGui record, @Param("example") GoodsGuiExample example);

    int updateByExample(@Param("record") GoodsGui record, @Param("example") GoodsGuiExample example);

    int updateByPrimaryKeySelective(GoodsGui record);

    int updateByPrimaryKey(GoodsGui record);
}