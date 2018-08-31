package ${PACKAGE_NAME}.service.${MK};

import ${PACKAGE_NAME}.entity.${MK}.${CLASS_NAME};
import ${PACKAGE_NAME}.repository.${MK}.${CLASS_NAME}Dao;
import com.si.service.ServiceImpl;
import ${PACKAGE_NAME}.service.${MK}.${CLASS_NAME}Service;
import org.springframework.stereotype.Service;

/**
 * ${CLASS_NAME}业务接口实现类
 * @author ${author} on ${D}.
 */
@Service
public class ${CLASS_NAME}ServiceImpl extends ServiceImpl<${CLASS_NAME}Dao, ${CLASS_NAME}> implements ${CLASS_NAME}Service {
}