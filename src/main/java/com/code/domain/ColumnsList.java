package com.code.domain;

import java.util.List;

/**
 * Created by xiaoyaolan on 2016/9/14.
 */
public class ColumnsList {
    public List<ColumnsModel> getLists() {
        return lists;
    }

    public void setLists(List<ColumnsModel> lists) {
        this.lists = lists;
    }

    private List<ColumnsModel> lists;
    private String className;
    private String packageName;
    private boolean controller;
    private boolean service;
    private String tableName;
    private String tableSchema;

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableSchema() {
        return tableSchema;
    }

    public void setTableSchema(String tableSchema) {
        this.tableSchema = tableSchema;
    }

    public boolean isController() {
        return controller;
    }

    public void setController(boolean controller) {
        this.controller = controller;
    }

    public boolean isService() {
        return service;
    }

    public void setService(boolean service) {
        this.service = service;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }
}
