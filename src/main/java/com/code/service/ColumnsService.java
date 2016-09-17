package com.code.service;

import com.code.domain.Columns;
import com.code.domain.ColumnsList;
import com.code.domain.ColumnsModel;
import com.code.util.CommonUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by xiaoyaolan on 2016/9/8.
 */
@Service
public class ColumnsService {
    private static final String QUERY = "select COLUMN_NAME,DATA_TYPE,COLUMN_TYPE,"
            + "COLUMN_COMMENT,COLUMN_KEY,TABLE_NAME,CHARACTER_MAXIMUM_LENGTH from COLUMNS"
            + " WHERE table_name = ? AND table_schema = ?;";
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Value("${code.source.outpath:src/main/java/}")
    private String outpath;
    /**
     * 根据表名和schema获取字段信息
     * @param tableName
     * @param tableSchema
     * @return
     */
    public List<Columns> getAllColumns(String tableName, String tableSchema) {
        List lists = Lists.newArrayList();
        jdbcTemplate.query(QUERY, new Object[]{tableName, tableSchema}, new RowCallbackHandler() {
            @Override
            public void processRow(ResultSet resultSet) throws SQLException {
                Columns obj = new Columns();
                obj.setTableName(resultSet.getString("TABLE_NAME"));
                obj.setDataType(resultSet.getString("DATA_TYPE"));
                obj.setColumnType(resultSet.getString("COLUMN_TYPE"));
                obj.setColumnName(resultSet.getString("COLUMN_NAME"));
                obj.setColumnKey(resultSet.getString("COLUMN_KEY"));
                obj.setColumnComment(resultSet.getString("COLUMN_COMMENT"));
                obj.setCharacterMaximumLength(resultSet.getLong("CHARACTER_MAXIMUM_LENGTH"));
                lists.add(obj);
            }
        });
        return lists;
    }

    public void saveCode(ColumnsList obj) throws Exception {
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
        //cfg.setDirectoryForTemplateLoading(ResourceUtils.getFile("templates/codeDemain"));
        cfg.setClassLoaderForTemplateLoading(this.getClass().getClassLoader(), "/templates/codeDemain");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setLogTemplateExceptions(false);
        List<Columns> objs = getAllColumns(obj.getTableName(), obj.getTableSchema());
        Map<String, Object> maps = Maps.newHashMap();
        if (objs == null || objs.isEmpty()) {
            return;
        } else {
            for (Columns o:objs) {
                if ("PRI".equals(o.getColumnKey())) {
                    maps.put("PRI", o.getData_Type());
                }
            }
        }
        //TODO 生成Entity
        Template template = cfg.getTemplate("domainTemplate.ftl", "utf-8");
        maps.put("symbol", "$");
        maps.put("PACKAGE_NAME", obj.getPackageName());
        maps.put("CLASS_NAME", obj.getClassName());
        maps.put("CLASS_NAME_LINK", CommonUtil.geneUnKey(obj.getClassName()));
        maps.put("TABLE_NAME", obj.getTableName());
        maps.put("datas", objs);
        String tempJava = FreeMarkerTemplateUtils.processTemplateIntoString(template, maps);
        File f = new File(outpath + StringUtils.replace(obj.getPackageName(), ".", "/") + "/domain/"  + obj.getClassName() + ".java");
        FileUtils.writeStringToFile(f, tempJava, "utf-8");
        System.out.println(obj.getClassName() + "Entity生成完毕");
        //TODO 生成Dao
        template = cfg.getTemplate("daoTemplate.ftl", "utf-8");
        tempJava = FreeMarkerTemplateUtils.processTemplateIntoString(template, maps);
        f = new File(outpath + StringUtils.replace(obj.getPackageName(), ".", "/") + "/repository/" + obj.getClassName().trim() + "Dao.java");
        FileUtils.writeStringToFile(f, tempJava, "utf-8");
        System.out.println("Dao代码生成成功");
        //TODO 生成Service
        if (obj.isService()) {
            template = cfg.getTemplate("serviceTemplate.ftl", "utf-8");
            tempJava = FreeMarkerTemplateUtils.processTemplateIntoString(template, maps);
            f = new File(outpath + StringUtils.replace(obj.getPackageName(), ".", "/") + "/service/" + obj.getClassName().trim() + "Service.java");
            FileUtils.writeStringToFile(f, tempJava, "utf-8");
            System.out.println("Service代码生成成功");
        }
        //TODO 生成Controller
        if (obj.isController()) {
            template = cfg.getTemplate("controllerTemplate.ftl", "utf-8");
            tempJava = FreeMarkerTemplateUtils.processTemplateIntoString(template, maps);
            f = new File(outpath + StringUtils.replace(obj.getPackageName(), ".", "/") + "/controller/" + obj.getClassName().trim() + "Controller.java");
            FileUtils.writeStringToFile(f, tempJava, "utf-8");
            System.out.println("Controller代码生成成功");
        }
        //TODO 生成init.jsp
        List<Columns> inits = Lists.newArrayList();
        for (ColumnsModel o:obj.getLists()) {
            if (o.isCondition()) {
                for (Columns c : objs) {
                    if (StringUtils.equals(o.getColumnName(), c.getColumnName())) {
                        inits.add(c);
                        break;
                    }
                }
            }
        }
        if (!inits.isEmpty()) {
            maps.put("inits", inits);
            template = cfg.getTemplate("initTemplate.ftl", "utf-8");
            tempJava = FreeMarkerTemplateUtils.processTemplateIntoString(template, maps);
            f = new File(outpath + "/" + obj.getClassName().trim() + "/init.jsp");
            FileUtils.writeStringToFile(f, tempJava, "utf-8");
            System.out.println("init.jsp代码生成成功");
        }
        //TODO 生成list.jsp
        List<Columns> lists = Lists.newArrayList();
        for (ColumnsModel o:obj.getLists()) {
            if (o.isList()) {
                for (Columns c : objs) {
                    if (StringUtils.equals(o.getColumnName(), c.getColumnName())) {
                        lists.add(c);
                        break;
                    }
                }
            }
        }
        if (!lists.isEmpty()) {
            maps.put("lists", lists);
            template = cfg.getTemplate("listTemplate.ftl", "utf-8");
            tempJava = FreeMarkerTemplateUtils.processTemplateIntoString(template, maps);
            f = new File(outpath + "/" + obj.getClassName().trim() + "/list.jsp");
            FileUtils.writeStringToFile(f, tempJava, "utf-8");
            System.out.println("list.jsp代码生成成功");
        }
        //TODO 生成add.jsp
        List<Columns> adds = Lists.newArrayList();
        for (ColumnsModel o:obj.getLists()) {
            if (o.isAdd()) {
                for (Columns c : objs) {
                    if (StringUtils.equals(o.getColumnName(), c.getColumnName())) {
                        adds.add(c);
                        break;
                    }
                }
            }
        }
        if (!adds.isEmpty()) {
            maps.put("adds", adds);
            template = cfg.getTemplate("addTemplate.ftl", "utf-8");
            tempJava = FreeMarkerTemplateUtils.processTemplateIntoString(template, maps);
            f = new File(outpath + "/" + obj.getClassName().trim() + "/add.jsp");
            FileUtils.writeStringToFile(f, tempJava, "utf-8");
            System.out.println("add.jsp代码生成成功");
        }
    }
}
