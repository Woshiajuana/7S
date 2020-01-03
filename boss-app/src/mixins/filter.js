
import DateUtil from '@/utils/date'

const filters = {
    filterDate (value) {
        return value ? DateUtil.formatDate('yyyy-MM-dd hh:mm:ss', new Date(value)) : '';
    },
};

export default {
    filters,
}
