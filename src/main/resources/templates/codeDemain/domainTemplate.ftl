package ${PACKAGE_NAME}.domain.${MK};

import java.io.Serializable;
import java.util.Date;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.Version;

@DynamicUpdate
@DynamicInsert
@Entity
@Table(name = "${TABLE_NAME}")
public class ${CLASS_NAME} implements Serializable {

	private static final long serialVersionUID = 1L;

	<#list datas as data>
	<#if data.columnKey == "PRI">
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	</#if>
	<#if data.column_Name == "versionNum">
    @Version
	</#if>
	//${data.columnComment}
	private ${data.data_Type} ${data.column_Name};
		
	public void set${data.methodName}(${data.data_Type} ${data.column_Name}) {
		this.${data.column_Name} = ${data.column_Name};
	}	
	public ${data.data_Type} get${data.methodName}() {
		return ${data.column_Name};
	}
	</#list>
}