package ${PACKAGE_NAME}.repository.${MK};

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import ${PACKAGE_NAME}.entity.${MK}.${CLASS_NAME};

/**
 * @author ${author} on ${D}.
 * @desc ${CLASS_NAME} db操作类
 */
public interface ${CLASS_NAME}Dao extends PagingAndSortingRepository<${CLASS_NAME}, ${PRI}>, JpaSpecificationExecutor<${CLASS_NAME}>{
}