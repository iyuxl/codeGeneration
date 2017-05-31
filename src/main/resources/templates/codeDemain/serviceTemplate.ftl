package ${PACKAGE_NAME}.service.${MK};

import java.util.Date;
import java.util.Map;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springside.modules.utils.Exceptions;
import com.alibaba.fastjson.JSON;

import ${PACKAGE_NAME}.exception.ServiceException;
import ${PACKAGE_NAME}.entity.${MK}.${CLASS_NAME};
import ${PACKAGE_NAME}.repository.${MK}.${CLASS_NAME}Dao;
import com.xkx.service.base.BaseService;
import com.xkx.domain.ResultBean;
import com.xkx.utils.BQDynamicSpecifications;
import com.xkx.utils.BQSearchFilter;
import com.xkx.utils.DateUtil;
import com.xkx.utils.XBeanMapper;

@Service
public class ${CLASS_NAME}Service extends BaseService {
    private static final Logger LOG = LoggerFactory.getLogger(${CLASS_NAME}Service.class);

    @Autowired
    private ${CLASS_NAME}Dao ${CLASS_NAME_LINK}Dao;

    /**
     * 创建分页请求.
     */
    private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
        Sort sort = null;
        sort = new Sort(Direction.DESC, "created");
        return new PageRequest(pageNumber - 1, pagzSize, sort);
    }

    /**
     * 创建动态查询条件组合.
     */
    private Specification<${CLASS_NAME}> buildSpecification(Map<String, Object> searchParams) {
        Map<String, BQSearchFilter> filters = BQSearchFilter.parse(searchParams);
        Specification<${CLASS_NAME}> spec = BQDynamicSpecifications.bySearchFilter(filters.values(), ${CLASS_NAME}.class);
        return spec;
    }

    public ${CLASS_NAME} getObj(${PRI} id) {
        if(LOG.isDebugEnabled()) {
            LOG.debug("find obj:  " + id);
        }
        return ${CLASS_NAME_LINK}Dao.findOne(id);
    }

    /**
     * 新增保存
     * @param obj
     */
    @Transactional
    public void createSave(${CLASS_NAME} obj) {
        if(LOG.isDebugEnabled()) {
            LOG.debug("save obj: " + JSON.toJSONString(obj, true));
        }
        ${CLASS_NAME_LINK}Dao.save(obj);
    }

    /**
     * 修改保存
     * @param obj
     */
    @Transactional
    public void updateSave(${CLASS_NAME} obj) {
        if(LOG.isDebugEnabled()) {
            LOG.debug("update obj: " + JSON.toJSONString(obj, true));
        }
        ${CLASS_NAME} domain = getObj(obj.getId());
        //TODO 将不被修改的值赋值给obj
        XBeanMapper.copy(obj, domain);
        ${CLASS_NAME_LINK}Dao.save(domain);
    }

    /**
     * 删除记录
     *
     */
    @Transactional
    public void deleteObjs(List<${PRI}> ids) {
        if(LOG.isDebugEnabled()) {
            LOG.debug("delete objs: " + JSON.toJSONString(ids, true));
        }
        for (Long id:ids) {
            ${CLASS_NAME_LINK}Dao.delete(id);
        }
    }

    public Page<${CLASS_NAME}> getObjs(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
        PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
        Specification<${CLASS_NAME}> spec = buildSpecification(searchParams);
        return ${CLASS_NAME_LINK}Dao.findAll(spec, pageRequest);
    }
}