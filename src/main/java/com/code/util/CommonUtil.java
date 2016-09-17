package com.code.util;

import org.apache.commons.lang3.StringUtils;

/**
 * Created by xiaoyaolan on 2016/9/15.
 */
public class CommonUtil {
    public static String geneClassOrMethodName(String key){
        String[] keys = key.split("_");
        StringBuffer sb = new StringBuffer();
        int size = keys.length;
        for (int i = 0; i < size; i++) {
            sb.append(StringUtils.capitalize(keys[i]));
        }
        return sb.toString();
    }

    public static String geneKey(String key){
        String[] keys = key.split("_");
        StringBuffer sb = new StringBuffer();
        int size = keys.length;
        for (int i = 0; i < size; i++) {
            if (i == 0) {
                sb.append(keys[i]);
            } else {
                sb.append(StringUtils.capitalize(keys[i]));
            }
        }
        return sb.toString();
    }

    public static String geneUnKey(String key){
        String[] keys = key.split("_");
        StringBuffer sb = new StringBuffer();
        int size = keys.length;
        for (int i = 0; i < size; i++) {
            if (i == 0) {
                sb.append(StringUtils.uncapitalize(keys[i]));
            } else {
                sb.append(StringUtils.uncapitalize(keys[i]));
            }
        }
        return sb.toString();
    }

    public static String getDataType(String dataType, String columnType) {
        switch (dataType.toLowerCase()) {
            case "varchar":
                dataType = "String";
                break;
            case "date":
                dataType = "Date";
                break;
            case "timestamp":
                dataType = "Date";
                break;
            case "datetime":
                dataType = "Date";
                break;
            case "bigint":
                dataType = "Long";
                break;
            case "int":
                dataType = getColumnType(dataType, columnType);
                break;
            default:
                dataType = "String";
                break;
        }
        return dataType;
    }

    public static String getColumnType(String dataType, String columnType) {
        String size = StringUtils.substring(columnType, dataType.length() + 1, columnType.indexOf(")"));
        if (Integer.parseInt(size) > 5) {
            return "Long";
        }
        return "Integer";
    }
}
