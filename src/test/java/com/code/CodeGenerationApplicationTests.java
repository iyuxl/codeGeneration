package com.code;

import com.alibaba.fastjson.JSON;
import com.code.domain.Columns;
import com.code.service.ColumnsService;
import com.google.common.collect.Lists;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.test.context.junit4.SpringRunner;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CodeGenerationApplicationTests {
	private static final String QUERY = "select COLUMN_NAME,DATA_TYPE,COLUMN_TYPE,"
			+ "COLUMN_COMMENT,COLUMN_KEY,TABLE_NAME,CHARACTER_MAXIMUM_LENGTH from COLUMNS"
			+ " WHERE table_name = ? AND table_schema = ?;";
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ColumnsService columnsService;
	@Test
	public void contextLoads() {
		/*List lists = Lists.newArrayList();
		jdbcTemplate.query(QUERY, new Object[]{"DEPT", "offportal"}, new RowCallbackHandler() {
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

		System.out.println(JSON.toJSONString(lists));

		List<Columns> ll = columnsService.getAllColumns("DEPT", "offportal");
		System.out.println(JSON.toJSONString(ll));*/

	}

}
