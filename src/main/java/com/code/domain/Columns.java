package com.code.domain;

import com.code.util.CommonUtil;

/**
 * Created by xiaoyaolan on 2016/9/8.
 */
public class Columns {

    private String columnName;
    private String dataType;
    private String columnType;
    private String columnComment;
    private String columnKey;
    private String tableName;
    private Long characterMaximumLength;

    public String getIsNullable() {
        return isNullable;
    }

    public void setIsNullable(String isNullable) {
        this.isNullable = isNullable;
    }

    private String isNullable;

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }

    public String getColumnComment() {
        return columnComment;
    }

    public void setColumnComment(String columnComment) {
        this.columnComment = columnComment;
    }

    public String getColumnKey() {
        return columnKey;
    }

    public void setColumnKey(String columnKey) {
        this.columnKey = columnKey;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Long getCharacterMaximumLength() {
        return characterMaximumLength;
    }

    public void setCharacterMaximumLength(Long characterMaximumLength) {
        this.characterMaximumLength = characterMaximumLength;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getMethodName() {
        return CommonUtil.geneClassOrMethodName(getColumn_Name());
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }
    private String methodName;
    private String data_Type;

    public String getColumn_Name() {
        return CommonUtil.geneKey(this.columnName.toLowerCase());
    }

    public void setColumn_Name(String column_Name) {
        this.column_Name = column_Name;
    }

    private String column_Name;

    public String getData_Type() {
        return CommonUtil.getDataType(this.dataType, this.columnType);
    }

    public void setData_Type(String data_Type) {
        this.data_Type = data_Type;
    }

    private String symbol;

    public String getSymbol() {
        return "$";
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }
}
